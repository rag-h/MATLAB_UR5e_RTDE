# Setup

## Installing the URsim VM
1. Follow the instructions to download the latest [Offline simulator for non linux](https://www.universal-robots.com/download/software-e-series/simulator-non-linux/offline-simulator-e-series-ur-sim-for-non-linux-5117/)

## Setting up Port Forwarding between host and VM

1. Don't open the VM.
2. Go to the settings for the VM -> Network
3. Select Port Forwarding

![Port Forwarding](https://github.com/rag-h/mtrn4230_course_development/blob/main/rtde/images/portforwarding.png)

4. Create a new rule with the following, but remember to replace the IP address with yours.


| Name   | Protocol | Host IP      | Host Port | Guest IP  | Guest Port |
|--------|----------|--------------|-----------|-----------|------------|
| Rule x | TCP      | IPv4 Address | 30003     | 10.0.2.15 | 30003      |

## How to find your IP address

### Windows
1. Open Command Prompt
2. Type
```
ipconfig
```
3. The IPv4 Address is your IP address

### Mac
1. Follow [guide](https://kb.wisc.edu/helpdesk/page.php?id=6526)