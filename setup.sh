#!/bin/bash

# A simple shell script to automate the post-installation setup for a Raspberry Pi.
# This script is intended to be run on a fresh install of Raspberry Pi OS.

# --- SCRIPT WORKFLOW ---
# 1. Update and Upgrade System Packages
# 2. Install Required Packages (mc, vim, ufw)
# 3. Configure and Enable UFW (Uncomplicated Firewall)

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting Raspberry Pi post-install setup..."
echo "------------------------------------------"

# --- SECTION 1: SYSTEM UPDATE AND UPGRADE ---
echo "1/3: Updating and upgrading system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y
echo "System packages updated and upgraded."
echo "------------------------------------------"

# --- SECTION 2: PACKAGE INSTALLATION ---
echo "2/3: Installing required packages (mc, vim, ufw)..."
# Using a single command for efficiency
sudo apt-get install -y mc vim ufw
echo "Required packages installed."
echo "------------------------------------------"

# --- SECTION 3: UFW CONFIGURATION ---
echo "3/3: Configuring and starting UFW (Uncomplicated Firewall)..."

# Use systemctl to reliably check if UFW is active. This avoids issues with
# parsing text output from 'ufw status'.
if systemctl is-active --quiet ufw; then
    echo "UFW is already active. Skipping configuration."
else
    echo "UFW is not active. Configuring rules..."

    # Explicitly start the UFW service before adding rules to avoid errors.
    sudo systemctl start ufw

    # Allow SSH connections on the default port
    sudo ufw allow ssh

    # Limit SSH connections to prevent brute-force attacks.
    # UFW normally allows SSH but denies connections if an IP address
    # tries to initiate 6 or more connections within 30 seconds.
    sudo ufw limit ssh/tcp

    # Enable the firewall. The --force flag prevents the interactive prompt.
    echo "Enabling the firewall. This may briefly disconnect your SSH session."
    sudo ufw --force enable

fi

echo "------------------------------------------"
echo "Raspberry Pi setup complete!"
echo "You may need to log out and log back in for some changes to take effect."
