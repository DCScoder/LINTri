#!/bin/bash
###################################################################################
#
#    Script:    LINTri.sh
#    Version:   1.3
#    Author:    Dan Saunders
#    Contact:   dcscoder@gmail.com
#    Purpose:   Linux Cyber Security Incident Response Script (Bash)
#    Usage:     sudo ./LINTri.sh
#
#    This program is free software: you can redistribute it and / or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <https://www.gnu.org/licenses/>.
#
###################################################################################

Version='v1.3'

########## Startup ##########

echo "

           __       ________  ____    __  __________
          |  |     |__    __||    \  |  ||___    ___| ______  __
          |  |        |  |   |  \  \ |  |    |  |    |   ___||__|
          |  |____  __|  |__ |  |\  \|  |    |  |    |  /    |  |
          |_______||________||__| \_____|    |__|    |__|    |__|


Script / Skript: LINTri.sh - $Version - Author / Autor: Dan Saunders dcscoder@gmail.com

"
echo -e "\e[93m
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Please Note:

Hi $(whoami), script running on $(hostname), please do not touch.

Bitte beachten Sie:

Hallo $(whoami), skript laeuft auf $(hostname), bitte nicht beruehren.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\e[0m"

echo "
Running script / Ausfuehrendes Skript..."

########## Admin ##########

echo "
(Task 1 / 10) Admin tasks running / Admin-Aufgabe laeuft."

# Destination
Destination=$(pwd)
# System Date/Time
Timestamp=$(date +%Y%m%d_%H%M%S)
# Computer Name
Endpoint=$(hostname)
# Triage
Name='LINTri_'$Endpoint\_$Timestamp
Triage=$Name
# Directory Structure
mkdir $Triage
chmod 777 $Triage
# Start Log
exec 2> $Triage/LINTri.log

########## Memory ##########

echo "
(Task 2 / 10) Gather memory information / Sammeln von Speicherprozessinformationen."

# Directory Structure
mkdir $Triage/Memory
chmod 777 $Triage/Memory
# Processes
vol_format=user,pid,ppid,%cpu,%mem,vsz,rss,tty,stat,stime,time,cmd
ps axwwSo $vol_format > $Triage/Memory/Process_List.txt
# Memory Information
cat /proc/meminfo > $Triage/Memory/Memory_Information.txt
# Memory Statistics
vmstat > $Triage/Memory/Memory_Statistics.txt
# Loaded Modules
lsmod | head > $Triage/Memory/Loaded_Modules.txt
# Open Files
lsof > $Triage/Memory/Open_Files.txt

########## Accounts ##########

echo "
(Task 3 / 10) Gather account information / Kontoinformationen sammeln."

# Directory Structure
mkdir $Triage/Accounts
chmod 777 $Triage/Accounts
mkdir $Triage/Accounts/Bash
chmod 777 $Triage/Accounts/Bash
mkdir $Triage/Accounts/ZSH
chmod 777 $Triage/Accounts/ZSH
mkdir $Triage/Accounts/Python
chmod 777 $Triage/Accounts/Python
mkdir $Triage/Accounts/MRU
chmod 777 $Triage/Accounts/MRU
# Bash History
find / -name ".bash_history" -exec tar -rf $Triage/Accounts/Bash/bash_history.tar "{}" \;
# Bash Profile
find / -name ".bash_profile" -exec tar -rf $Triage/Accounts/Bash/bash_profile.tar "{}" \;
# Bash Logout
find / -name ".bash_logout" -exec tar -rf $Triage/Accounts/Bash/bash_logout.tar "{}" \;
# Bash RC
find / -name ".bashrc" -exec tar -rf $Triage/Accounts/Bash/bashrc.tar "{}" \;
# ZSH History
find / -name ".zsh_history" -exec tar -rf $Triage/Accounts/ZSH/zsh_history.tar "{}" \;
# ZSH RC
find / -name ".zshrc" -exec tar -rf $Triage/Accounts/ZSH/zshrc.tar "{}" \;
# Python History
find / -name ".python_history" -exec tar -rf $Triage/Accounts/Python/python_history.tar "{}" \;
# Most Recently Used
find / -name "recently-used.xbel" -exec tar -rf $Triage/Accounts/MRU/recently-used-xbel.tar "{}" \;
# User Accounts
cat /etc/passwd > $Triage/Accounts/passwd
# Password Hashes
cat /etc/shadow > $Triage/Accounts/shadow
# User Groups
cat /etc/group > $Triage/Accounts/group
# User Permissions
cat /etc/sudoers > $Triage/Accounts/sudoers
# Active Users
who -a > $Triage/Accounts/Users_Active.txt
# Users Most Recent Logon
lastlog > $Triage/Accounts/Users_All_Last_Logon.txt
# UTMP Activity
utmpdump /var/run/utmp > $Triage/Accounts/UTMP_Activity.txt
# WTMP Activity
utmpdump /var/log/wtmp > $Triage/Accounts/WTMP_Activity.txt
# BTMP Activity
utmpdump /var/log/btmp > $Triage/Accounts/BTMP_Activity.txt

########## Configuration ##########

echo "
(Task 4 / 10) Gather system information / Sammeln von Systeminformationen."

# Directory Structure
mkdir $Triage/Configuration
chmod 777 $Triage/Configuration
mkdir $Triage/Configuration/Crontab
chmod 777 $Triage/Configuration/Crontab
mkdir $Triage/Configuration/init
chmod 777 $Triage/Configuration/init
mkdir $Triage/Configuration/init.d
chmod 777 $Triage/Configuration/init.d
mkdir $Triage/Configuration/rc.local
chmod 777 $Triage/Configuration/rc.local
mkdir $Triage/Configuration/rc.local.d
chmod 777 $Triage/Configuration/rc.local.d
# Hostname
hostname > $Triage/Configuration/Hostname.txt
# System Date/Time/Zone
timedatectl > $Triage/Configuration/System_Date_Time_Zone.txt
# Uptime
uptime > $Triage/Configuration/Uptime.txt
# DNS Resolver
cat /etc/resolv.conf > $Triage/Configuration/resolv.conf
# Host
cat /etc/host.conf > $Triage/Configuration/host.conf
# Name Service Switch
cat /etc/nsswitch.conf > $Triage/Configuration/nsswitch.conf
# Kernel Information
cat /proc/version > $Triage/Configuration/Kernel_Information.txt
# Operating System Information
cat /etc/*release* > $Triage/Configuration/OS_Information.txt
# Disk Management
lsblk > $Triage/Configuration/Disk_Drives.txt
# Disk Partition Table
fdisk -lu > $Triage/Configuration/Disk_Partition_Table.txt
# Disk Usage
df -h > $Triage/Configuration/Disk_Usage.txt
# File System Information
mount > $Triage/Configuration/Mounted_File_Systems.txt
# USB Devices
lsusb -v > $Triage/Configuration/USB_Devices.txt
# PCI Devices
lspci > $Triage/Configuration/PCI_Devices.txt
# Crontab Listing
ls -al /etc/cron.* > $Triage/Configuration/Crontab_Files.txt
# Crontab Files
cp -rfp /etc/cron.d $Triage/Configuration/Crontab
cp -rfp /etc/cron.daily $Triage/Configuration/Crontab
cp -rfp /etc/cron.hourly $Triage/Configuration/Crontab
cp -rfp /etc/cron.weekly $Triage/Configuration/Crontab
cp -rfp /etc/cron.monthly $Triage/Configuration/Crontab
cp -rfp /var/spool/cron/crontabs $Triage/Configuration/Crontab
# Service Status
systemctl list-unit-files --type=service > $Triage/Configuration/Service_Status.txt
# init Files
cp -rfp /etc/init $Triage/Configuration/init
# init.d Files
cp -rfp /etc/init.d $Triage/Configuration/init.d
# rc.local Files
cp -rfp /etc/rc.local $Triage/Configuration/rc.local
# rc.local.d Files
cp -rfp /etc/rc.local.d $Triage/Configuration/rc.local.d

########## Logs ##########

echo "
(Task 5 / 10) Gather log information / Sammeln von Protokollinformationen."

# Directory Structure
mkdir $Triage/Logs
chmod 777 $Triage/Logs
# Log Configuration
cat /etc/logrotate.conf > $Triage/Logs/logrotate.conf
# SSHD Journal Events
journalctl -u sshd > $Triage/Logs/SSHD_Journal_Events.txt
# /var/log/*
tar -zcf $Triage/Logs/var_log.tar.gz /var/log
# /var/run/utmp UTMP Log
tar -zcf $Triage/Logs/var_run_utmp.tar.gz /var/run/utmp

########## Network ##########

echo "
(Task 6 / 10) Gather network information / Sammeln von Netzwerkinformationen."

# Directory Structure
mkdir $Triage/Network
chmod 777 $Triage/Network
mkdir $Triage/Network/SSH
chmod 777 $Triage/Network/SSH
# Netstat
netstat -anp > $Triage/Network/Netstat_Connections.txt
# Socket Statistics
ss > $Triage/Network/Socket_Statistics.txt
# Host IP Address
hostname -I > $Triage/Network/Host_IP_Address.txt
# DHCP
cat /etc/resolv.conf > $Triage/Network/resolv.conf
# Hosts
cat /etc/hosts > $Triage/Network/hosts
# Hosts Allow
cat /etc/hosts.allow > $Triage/Network/hosts.allow
# Hosts Deny
cat /etc/hosts.deny > $Triage/Network/hosts.deny
# Routing Table
netstat -rn > $Triage/Network/Routing_Table.txt
# ARP Table
cat /proc/net/arp > $Triage/Network/arp
# IP Configuration
ifconfig -a > $Triage/Network/ipconfig.txt
# Port Status
nmap $(hostname -I) > $Triage/Network/Port_Status.txt
# IP Tables Filter Rules
iptables -t filter -L -v -n > $Triage/Network/iptables_Filter.txt
# IP Tables NAT Rules
iptables -t nat -L -n -v > $Triage/Network/iptables_NAT.txt
# SSH Configuration
find / -name "ssh_config" -exec tar -rf $Triage/Network/SSH/ssh_config.tar "{}" \;
# Users SSH Known Hosts
find / -name "known_hosts" -exec tar -rf $Triage/Network/SSH/known_hosts.tar "{}" \;
# Users SSH Authorized Keys
find / -name "authorized_keys" -exec tar -rf $Triage/Network/SSH/authorized_keys.tar "{}" \;

########## Programs ##########

echo "
(Task 7 / 10) Gather program information / Sammeln von Programminformationen."

# Directory Structure
mkdir $Triage/Programs
chmod 777 $Triage/Programs
# Installed Packages
dpkg-query -W > $Triage/Programs/Installed_Packages.txt
# Installed Modules
lsmod > $Triage/Programs/Installed_Modules.txt
# Installed Binary Hashes
for b in '/usr/bin/*'
do
        md5sum $b > $Triage/Programs/Installed_Binary_Hashes.txt
done

########## File System ##########

echo "
(Task 8 / 10) Gather file system information / Sammeln von Dateisysteminformationen."

# Directory Structure
mkdir $Triage/FileSystem
chmod 777 $Triage/FileSystem
# Trash Bin File Entries
for r in '/home/*/.local/share/Trash/info/*'
do
		cat $r > $Triage/FileSystem/Trash_Bin_File_Entries.txt	
done
# Trash Bin Raw Metadata
find / -name "*.trashinfo" -exec tar -rf $Triage/FileSystem/trashinfo.tar "{}" \;
# Trash Bin File Hashes
for tb in '/home/*/.local/share/Trash/files/*'
do
        md5sum $tb > $Triage/FileSystem/Trash_Bin_File_Hashes.txt
done
# Downloads File Hashes
find /home/*/Downloads -type f -exec md5sum {} \; > $Triage/FileSystem/Downloads_MD5_Hashes.txt
# tmp File Collection
tar -zcf $Triage/FileSystem/tmp.tar.gz tmp
# tmp File Hashes
find /tmp -type f -exec md5sum {} \; > $Triage/FileSystem/tmp_MD5_Hashes.txt
# tmp Directory Listing
find /tmp -print0 | xargs -0 stat > $Triage/FileSystem/tmp_Dir_Listing.txt
# etc Directory Listing
find /etc -print0 | xargs -0 stat > $Triage/FileSystem/etc_Dir_Listing.txt
# Potential Webshell File Hashes
find / -xdev -type f \( -iname '*.jsp' -o -iname '*.php' -o -iname '*.asp' -o -iname '*.aspx' \) 2>/dev/null -print0 | xargs -0 md5sum > $Triage/FileSystem/Potential_Webshell_File_Hashes.txt

########## Internet ##########

echo "
(Task 9 / 10) Gather internet information / Sammeln von Internet-Informationen."

# Directory Structure
mkdir $Triage/Internet
chmod 777 $Triage/Internet
# Firefox History
find / -name "places.sqlite" -exec tar -rf $Triage/Internet/places-sqlite.tar "{}" \;
# Firefox Cookies
find / -name "cookies.sqlite" -exec tar -rf $Triage/Internet/cookies-sqlite.tar "{}" \;
# Firefox Forms
find / -name "formhistory.sqlite" -exec tar -rf $Triage/Internet/formhistory-sqlite.tar "{}" \;

########## Organise Collection ##########

echo "
(Task 10 / 10) Organise Collection / Sammlung organisieren."

# Hashing
find $Triage -type f -exec md5sum {} \; > $Destination/$Triage/Hashes.txt

# Compress Archive
tar -zcf $Triage.tar.gz $Destination/$Triage

# Delete Folder
rm -rf $Triage

echo -e "\e[92m
Script completed! / Skript abgeschlossen!"