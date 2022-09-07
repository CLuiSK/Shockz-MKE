#!/bin/bash

run_scan(){
    
    # Results path
    path="$(pwd)/enum/$1"

    # Creates a folder with the IP as its name
    mkdir -p "${path}"

    ##### TCP #####

    # Full TCP Port Discovery Scan
    nmap -p- --open -sS --min-rate 2000 -v -Pn "$1" -oG "${path}/allPorts"
    # Get UDP Ports
    ports="$(cat "${path}/allPorts" | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
    # Full TCP Checks Scan
    nmap -sS -A --reason --min-rate 2000 -v -Pn -p "${ports}" "$1" -oN "${path}/tcp_results"

    ##### UDP #####

    # UDP TOP 100 Ports Discovery
    sudo nmap -sU --top-ports 100 -Pn -F -v "$1" -oG "${path}/allports_udp"
    # Get UDP ports
    udp_ports="$(cat "${path}/allports_udp" | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"

    # If we have ports
    if [ "$udp_ports" ]; then
        # Run a Full UDP Checks Scan
        sudo nmap -sU -A -Pn -p "${udp_ports}" "$1" -oN "${path}/udp_results"
    fi

    # Full TCP VULN Scripts
    nmap -sS -A --script='(*) and not (brute or broadcast or dos or external or fuzzer)' --script-args=unsafe=1 --reason --min-rate 2000 -v -Pn -p "${ports}" "$1" -oN "${path}/full_vuln_scripts"
}

# MAIN PROGRAM

COUNTER=0

# We run through the arguments, We create parallelism by creating processes for every IP
for ip in "$@"
do
    let COUNTER=$COUNTER+1
    run_scan "$ip" &
done