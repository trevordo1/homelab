# Cyber Security Learning Roadmap

Based on the **roadmap.sh Cyber Security Expert** roadmap (https://roadmap.sh/cyber-security),
reordered for my starting point: Ubuntu homelab, Docker, SSH, Tailscale, OverTheWire Bandit (~level 10).

**How to use this file**
- `[x]` = done, `[~]` = partly know it, `[ ]` = not started. Edit as you go and push to GitHub.
- Work top to bottom. Each phase builds on the one before.
- "Practice" lines tie each phase to something hands-on: my homelab, OverTheWire, TryHackMe, etc.
- Click any topic on roadmap.sh to get free reading/video links for it.

---

## Phase 1 — Fundamental IT Skills
*Goal: understand the computers you're protecting.*

- [~] Computer hardware components (CPU, RAM, storage, motherboard, NIC)
- [~] Connection types: WiFi, Bluetooth, NFC, infrared
- [x] Installing software and applications
- [x] Operating system installation and configuration
- [~] Operating system versions and differences
- [ ] OS-independent troubleshooting (a repeatable process: identify → test → fix → verify → document)
- [ ] Popular productivity suites: Microsoft Office, Google Workspace, iCloud
- [ ] Cloud storage: Google Drive, OneDrive, Dropbox, Box (what they are and how data gets shared/leaked)

**Practice:** You already did a lot of this: reinstalling Ubuntu, BSOD troubleshooting, server setup.
Write up one troubleshooting story (e.g. the lid-sleep problem) in your GitHub log using the
identify → test → fix → verify steps.

---

## Phase 2 — Operating Systems
*Goal: be comfortable on Windows, Linux and macOS, from the GUI and the command line.*

**Linux**
- [x] GUI vs. CLI navigation
- [x] File CRUD operations (create, read, update, delete)
- [~] Understanding permissions (`chmod`, `chown`, users, groups, sudo)
- [x] Common commands: `cat`, `grep`, `head`, `tail`, `curl`, `ping`
- [~] Bash scripting
- [ ] Linux hardening (firewall, SSH keys, disabling password login, updates)

**Windows**
- [~] Windows navigation and settings
- [ ] PowerShell basics
- [ ] Group Policy
- [ ] Windows event logs (Event Viewer)

**macOS**
- [ ] macOS basics (only need awareness level)

**All**
- [~] Operating system hardening
- [~] Patching (you set up unattended-upgrades)
- [ ] Backups and resiliency (your backup script!)

**Practice:**
- Finish **OverTheWire Bandit** → then **Leviathan**.
- Set up SSH keys + disable password login + `ufw` on the homelab.
- Run and test-restore `backup.sh`.
- Read *The Linux Command Line* (William Shotts, free online), scripting chapters.
- On the XPS: try PowerShell for a week instead of the GUI; open Event Viewer and find your own logins.

---

## Phase 3 — Networking Knowledge
*Goal: understand how data moves. This is the biggest phase and the most important.*

**Models and basics**
- [ ] OSI model (7 layers) — learn this well, everything else hangs off it
- [~] Common protocols and their uses: HTTP/HTTPS, SSH, FTP/SFTP, RDP, DNS, DHCP, NTP
- [~] Common ports and their uses (22, 53, 80, 443, 3389, …)
- [~] IP addressing; public vs. private IPs
- [x] localhost / loopback
- [~] Default gateway
- [ ] Subnet mask, CIDR, subnetting fundamentals (practice until you can do it on paper)
- [~] NAT (you hit double NAT at home)
- [~] DHCP (you set a fixed IP / reservation)
- [~] DNS (you used MagicDNS, `.local`, and `/etc/hosts`)
- [ ] ARP
- [ ] IPAM (IP address management)

**Network devices and layout**
- [~] Router, switch
- [ ] Firewalls and next-generation firewalls
- [~] VLANs
- [ ] DMZ, perimeter, segmentation
- [~] VPNs (Tailscale/WireGuard)
- [ ] Network types: LAN, WLAN, WAN, MAN
- [ ] Topologies: star, ring, mesh, bus

**Virtualization**
- [ ] Virtual machines, hypervisor, host vs. guest OS
- [ ] VirtualBox / VMware / ESXi / Proxmox
- [x] Containers (Docker — not on roadmap.sh but you've done it)

**Troubleshooting tools**
- [x] `ping`
- [ ] `tracert` / `traceroute`
- [ ] `ipconfig` (Windows) / `ip a` (Linux)
- [ ] `nslookup`, `dig`
- [ ] `netstat` / `ss`
- [ ] `route`
- [ ] Packet sniffers / protocol analyzers: **Wireshark**, `tcpdump`
- [ ] Port scanners: **Nmap**

**Practice:**
- Professor Messer's free **Network+** videos (YouTube) — covers almost this whole phase.
- Cisco **Packet Tracer** (free) — build small networks with VLANs and routing.
- In UniFi: put the homelab on its own **VLAN** with firewall rules.
- **Wireshark**: capture yourself loading a website; find the DNS lookup, TCP handshake, TLS handshake.
- **Nmap** your own homelab server; compare open ports to `docker ps` and `ufw status`.
- Bandit levels 15–25 (networking with `nc`, `openssl`, `nmap`).
- Optional: run **Pi-hole** and watch your own DNS traffic.

---

## Phase 4 — Security Fundamentals
*Goal: the core ideas every security job uses.*

**Core concepts**
- [ ] CIA triad (confidentiality, integrity, availability)
- [ ] Understanding risk; risk management
- [ ] Defense in depth
- [ ] Zero trust
- [ ] Least privilege
- [ ] Blue / red / purple teams
- [ ] True/false positives and negatives
- [ ] Known vs. unknown threats; zero-day exploits; APTs

**Authentication and access**
- [~] Authentication vs. authorization
- [ ] Identification, local authentication
- [ ] MFA / 2FA
- [ ] Single sign-on (SSO)
- [ ] Kerberos, LDAP / LDAPS, RADIUS
- [ ] Access control: ACLs, mandatory access control (MAC)

**Cryptography**
- [ ] Hashing, salting
- [~] Public vs. private keys (you made SSH keys!)
- [ ] Key exchange
- [ ] PKI and certificates
- [~] SSL / TLS (SSL vs. TLS, how HTTPS works — you met this with Actual)
- [ ] Obfuscation
- [ ] Secure protocols: IPsec, DNSSEC, S/MIME, SRTP, LDAPS, SFTP

**Wireless security**
- [ ] WEP / WPA / WPA2 / WPA3
- [ ] WPS
- [ ] EAP vs. PEAP

**Defensive tools**
- [ ] Antivirus, antimalware, EDR
- [ ] Host-based firewall, HIPS
- [ ] IDS / IPS (NIDS, NIPS)
- [ ] Honeypots, sinkholes, sandboxing
- [ ] Data loss prevention (DLP)
- [ ] Network access control (NAC)
- [ ] Port blocking
- [ ] Jump servers

**Practice:**
- **CompTIA Security+** study material (Professor Messer Security+ videos are free) — matches this phase closely.
- Crack hashes you create yourself with **Hashcat** on the XPS GPU (learn why salting matters).
- Turn on 2FA everywhere you can; check that your GitHub uses SSH keys.
- Look at your UniFi Wi-Fi security settings: which WPA version is it using?

---

## Phase 5 — Attacks and Exploits
*Goal: know how attackers think so you can defend (or test) properly.*

**Social engineering**
- [ ] Phishing, whaling, smishing, vishing ("whishing")
- [ ] Spam vs. spim
- [ ] Impersonation, tailgating, shoulder surfing, dumpster diving
- [ ] Watering hole, drive-by attacks, typosquatting

**Network attacks**
- [ ] Man-in-the-middle
- [ ] Spoofing, DNS poisoning / spoofing
- [ ] DoS vs. DDoS
- [ ] Replay attacks
- [ ] VLAN hopping
- [ ] Rogue access points, evil twin, deauth attacks

**Application and system attacks**
- [ ] OWASP Top 10
- [ ] SQL injection
- [ ] Cross-site scripting (XSS)
- [ ] Cross-site request forgery (CSRF)
- [ ] Directory traversal
- [ ] Buffer overflow, memory leaks
- [ ] Privilege escalation
- [ ] Pass the hash
- [ ] Brute force vs. password spraying

**Attack frameworks and tools**
- [ ] Cyber Kill Chain
- [ ] MITRE ATT&CK
- [ ] Diamond Model
- [ ] Common hacking tools; common exploit frameworks (Metasploit)
- [ ] Kali Linux / ParrotOS
- [ ] Living-off-the-land resources: GTFOBins, LOLBAS, WADComs
- [ ] Penetration testing rules of engagement

**Practice (in this order):**
1. **OverTheWire Natas** 0–15 (web hacking basics).
2. **PortSwigger Web Security Academy**, Apprentice labs (SQLi, XSS, CSRF, traversal) — free.
3. **picoCTF** web + general skills.
4. TryHackMe free rooms: Nmap, Metasploit intro, OWASP Top 10.
5. Build the **Kali + Metasploitable 2** VM lab on the XPS (host-only network).
6. Look up GTFOBins while doing Linux privilege-escalation rooms.

---

## Phase 6 — Defense, Incident Response and Forensics
*Goal: the blue-team side, which is where most entry-level security jobs are.*

**Monitoring and logs**
- [~] Event logs, syslogs (you've used `journalctl`)
- [ ] Firewall logs, NetFlow
- [ ] SIEM
- [ ] SOAR
- [ ] Packet captures

**Incident response process (memorize the order)**
- [ ] Preparation
- [ ] Identification
- [ ] Containment
- [ ] Eradication
- [ ] Recovery
- [ ] Lessons learned
- [ ] Runbooks

**Forensics and analysis**
- [ ] Digital forensics basics
- [ ] Tools: FTK Imager, Autopsy, WinHex, `dd`, memdump
- [ ] Malware analysis and types
- [ ] Reverse engineering fundamentals
- [ ] Sandboxes/scanners: VirusTotal, any.run, Joe Sandbox, urlscan, UrlVoid, WHOIS

**Threat intelligence**
- [ ] Threat intelligence and OSINT fundamentals
- [ ] Threat hunting basics
- [ ] Vulnerability management

**Practice:**
- Install **Wazuh** or **CrowdSec** on the homelab and watch real login attempts / alerts.
- Write a one-page **runbook** for "my homelab server is down" (Uptime Kuma alert → check → fix).
- TryHackMe free rooms on Splunk/SIEM, Autopsy, and phishing analysis.
- Paste suspicious links/files into VirusTotal and urlscan instead of opening them.
- **TryHackMe Advent of Cyber** in December (free, mixes red and blue).

---

## Phase 7 — Governance, Risk and Compliance (GRC)
*Goal: the business side. Your finance/business law background is an advantage here.*

- [ ] Frameworks: NIST, NIST CSF, ISO 27001, CIS Controls, RMF
- [ ] Compliance; role of compliance and auditors
- [ ] Stakeholders, management, HR and legal in cybersecurity

**Practice:** Read the NIST Cybersecurity Framework summary. Try mapping your homelab to the
five CSF functions: Identify, Protect, Detect, Respond, Recover.
**Note:** GRC and security auditing are common bridges from finance/accounting into security.

---

## Phase 8 — Cloud Skills
*Goal: most companies run on cloud now.*

- [ ] Cloud vs. on-premises
- [ ] Models: IaaS, PaaS, SaaS, serverless
- [ ] Deployment: public, private, hybrid
- [ ] Cloud security concepts (shared responsibility model)
- [ ] Providers: AWS, Azure, GCP (pick one to start; Azure is common in Canadian business)
- [ ] Cloud storage like AWS S3 (and how misconfigured buckets leak data)
- [ ] Infrastructure as code (Docker Compose is a small taste of this)

**Practice:** AWS or Azure free tier; take a free "cloud fundamentals" course (AWS Cloud Practitioner
or Azure AZ-900 learning paths are free).

---

## Phase 9 — Programming (Optional but Recommended)

- [~] Bash
- [ ] Python (most useful for security: automation, parsing logs, writing tools)
- [ ] PowerShell
- [ ] JavaScript (helps with web attacks like XSS)
- [ ] C++ / Go (later, for exploit dev / tools)

**Practice:** Rewrite parts of `backup.sh` yourself. Then learn Python by writing a script that
reads your server's logs and counts failed SSH logins.

---

## Certifications (roughly in order)

**Beginner**
- [ ] CompTIA A+ (optional if you're comfortable with hardware/OS already)
- [ ] CompTIA Network+ ← best first cert for you
- [ ] CompTIA Security+ ← the standard entry-level security cert
- [ ] CompTIA Linux+ or CCNA (pick based on interest: Linux vs. networking)

**Advanced (later, usually with work experience)**
- Offensive: CEH, OSCP, GPEN, GWAPT, CREST
- Defensive / general: GSEC, GIAC certs
- Management / audit: CISA, CISM, CISSP — CISA is the natural fit for a finance/audit background

---

## Practice Platforms (from the roadmap)

- [~] OverTheWire (Bandit → Leviathan → Natas → Krypton → Narnia)
- [ ] TryHackMe
- [ ] picoCTF
- [ ] HackTheBox
- [ ] VulnHub
- [ ] pwn.college (free, good for Linux + binary exploitation later)

---

## Progress Log

| Date | What I learned / did |
|------|----------------------|
| 2026-10-28 | Created this roadmap. Homelab running: Docker, Actual, Uptime Kuma, Tailscale, SSH. |
