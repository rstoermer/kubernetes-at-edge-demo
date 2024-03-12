#!/bin/bash

# Define user and hosts array
USER="rene"
SSH_KEY="$HOME/.ssh/ssh_pi.pub"

# master, fast-worker, slow-worker
declare -a ETH0_IPS=("192.168.2.3" "192.168.2.4" "192.168.2.5")