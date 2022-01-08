# Setup

Before you can run the example files, you will need to install the VM with URsim and setup port forwarding.

## Installing the URsim VM
1. Follow the instructions to download the latest [Offline simulator for non linux](https://www.universal-robots.com/download/software-e-series/simulator-non-linux/offline-simulator-e-series-ur-sim-for-non-linux-5117/)

## Setting up Port Forwarding between host and VM

1. Don't open the VM.
2. Go to the settings for the VM -> Network
3. Select Port Forwarding

![Port Forwarding](https://github.com/rag-h/mtrn4230_course_development/blob/main/rtde/images/portforwarding.png)

4. Create a new rule with the following


| Name   | Protocol | Host IP   | Host Port | Guest IP  | Guest Port |
|--------|----------|-----------|-----------|-----------|------------|
| Rule x | TCP      | 127.0.0.1 | 30003     | 10.0.2.15 | 30003      |
