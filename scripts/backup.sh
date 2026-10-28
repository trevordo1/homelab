#!/usr/bin/env bash
# ------------------------------------------------------------------
# Homelab nightly backup
# Stops each app briefly, archives ~/homelab (including data folders),
# restarts the apps, copies the archive to an external drive if it's
# plugged in, deletes old backups, and pings Uptime Kuma when done.
# Run as root (from root's crontab) so it can read Docker's data files.
# ------------------------------------------------------------------
set -euo pipefail

# ---------- Settings (edit these) ----------
HOMELAB_DIR="/home/trevor-do/homelab"     # what to back up
BACKUP_DIR="/home/trevor-do/backups"      # where backups go (NOT inside the git repo)
KEEP_DAYS=14                              # delete backups older than this
EXTERNAL_MOUNT=""                         # e.g. "/media/trevor-do/MySSD" (empty = skip)
PUSH_URL=""                               # Uptime Kuma push URL (empty = skip)
# -------------------------------------------

DATE=$(date +%Y-%m-%d_%H%M)
ARCHIVE="$BACKUP_DIR/homelab-$DATE.tar.gz"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }

log "===== Backup starting ====="
mkdir -p "$BACKUP_DIR"

# Find every app folder that has a compose.yaml (actual, uptime-kuma, ...)
mapfile -t APPS < <(find "$HOMELAB_DIR" -mindepth 2 -maxdepth 2 -name compose.yaml -printf '%h\n')

restart_apps() {
  for app in "${APPS[@]}"; do
    log "Starting $(basename "$app")"
    (cd "$app" && docker compose start) || log "WARNING: could not start $app"
  done
}

# Safety net: if anything below fails, the apps still get restarted
trap restart_apps EXIT

# 1. Stop apps so their databases aren't mid-write while we copy them
for app in "${APPS[@]}"; do
  log "Stopping $(basename "$app")"
  (cd "$app" && docker compose stop)
done

# 2. Create the compressed archive
log "Creating $ARCHIVE"
tar -czf "$ARCHIVE" -C "$(dirname "$HOMELAB_DIR")" "$(basename "$HOMELAB_DIR")"

# 3. Restart apps right away (downtime is only a few seconds)
restart_apps
trap - EXIT

# 4. Check the archive isn't corrupted
tar -tzf "$ARCHIVE" > /dev/null
log "Archive OK ($(du -h "$ARCHIVE" | cut -f1))"

# 5. Copy to the external drive, if it's plugged in
if [[ -n "$EXTERNAL_MOUNT" ]]; then
  if mountpoint -q "$EXTERNAL_MOUNT"; then
    mkdir -p "$EXTERNAL_MOUNT/homelab-backups"
    cp "$ARCHIVE" "$EXTERNAL_MOUNT/homelab-backups/"
    find "$EXTERNAL_MOUNT/homelab-backups" -name 'homelab-*.tar.gz' -mtime +"$KEEP_DAYS" -delete
    log "Copied to external drive"
  else
    log "WARNING: external drive not mounted, skipped copy"
  fi
fi

# 6. Delete old local backups
find "$BACKUP_DIR" -name 'homelab-*.tar.gz' -mtime +"$KEEP_DAYS" -delete
log "Removed backups older than $KEEP_DAYS days"

# 7. Tell Uptime Kuma the backup ran
if [[ -n "$PUSH_URL" ]]; then
  curl -fsS -m 10 "$PUSH_URL" > /dev/null && log "Pinged Uptime Kuma" \
    || log "WARNING: could not reach Uptime Kuma"
fi

log "===== Backup finished ====="
