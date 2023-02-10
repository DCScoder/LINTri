# LINTri
Linux Cyber Security Incident Response Script

#### Description:

The purpose of this script is to preserve and collect notable Linux artefacts. Once dropped onto the target system, the script will utilise a series of internal commands to query information from the host and retrieve data, which it stores in a temporary folder. Once all data has been collected, all files are hashed with the MD5 algorithm and the hash values are retained in a log file. Finally, the collection is archived into a TAR/GZIP file and the temporary store is deleted. The TAR/GZIP file can then be retrieved by the analyst for subsequent analysis offline. The script should be used during fast-time collection and preservation of artefacts during a cyber security incident. Frequent progress updates are provided in English and German languages via the terminal, whilst the script is active. A log of the terminal activities is also created and retained in the archive collection.

#### Artefacts Supported:

Memory:

- Processes
- Memory Information
- Memory Statistics
- Loaded Modules
- Open Files

Accounts:

- Bash History
- Bash Profile
- Bash Logout
- Bash RC
- ZSH History
- ZSH RC
- Python History
- Most Recently Used
- User Accounts
- Password Hashes
- User Groups
- User Permissions
- Active Users
- Users Most Recent Logon
- UTMP Activity
- WTMP Activity
- BTMP Activity

Configuration:

- Hostname
- System Date/Time/Zone
- Uptime
- DNS Resolver
- Host
- Name Switch Service
- Kernel Information
- Operating System Information
- Disk Management
- Disk Partition Table
- Disk Usage
- File System Information
- USB Devices
- PCI Devices
- Crontab Listing
- Crontab Files
- Service Status
- init Files
- init.d Files
- rc.local Files
- rc.local.d Files

Network:

- Netstat
- Socket Statistics
- Host IP Address
- DHCP
- Hosts
- Hosts Allow
- Hosts Deny
- Routing Table
- ARP Table
- IP Configuration
- Port Status
- IP Tables Filter Rules
- IP Tables NAT Rules
- SSH Configuration
- Users SSH Known Hosts
- Users SSH Authorized Keys

Logs:

- Log Configuration
- SSHD Journal Events
- /var/log/*
- /var/run/ UTMP log

Programs:

- Installed Packages
- Installed Modules
- Installed Binary Hashes

File System:

- Trash Bin File Entries
- Trash Bin Raw Metadata
- Trash Bin File Hashes
- Root Temporary File Hashes
- Downloads File Hashes
- tmp File Collection
- tmp File Hashes
- tmp Directory Listing
- etc Directory Listing
- Potential Webshell File Hashes

Internet:
- Firefox History
- Firefox Cookie
- Firefox Forms

#### Usage:

Step 1: Copy LINTri.sh to target host.

Step 2: Set script permissions to execute:

```
chmod +x ./LINTri.sh
```

Step 3: Execute script with Superuser privileges:

```
sudo ./LINTri.sh
```

Step 4: Download resultant (*.tar.gz) archive file via your preferred method.

Step 5: Delete script and archive file from host:

```
rm ./LINTri.sh
```
```
rm ./LINTri_<hostname>_<date>_<time>.tar.gz
```

#### Requirements:
- Script must be run with Superuser privileges.
- Several standard built-in Linux tools are leveraged. No third-party tools are required.
- As the script interacts with sensitive Linux credential files, configure an exclusion path and add hash value to a whitelist on any AV/EDR tools, to allow the script to execute fully.
