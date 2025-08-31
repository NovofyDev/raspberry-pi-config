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

# Enable the firewall first. The --force flag prevents the interactive prompt.
# This command also starts the ufw service and makes it persistent across reboots.
echo "Enabling the firewall. This may briefly disconnect your SSH session."
sudo ufw --force enable

# Limit SSH connections to prevent brute-force attacks.
# This command is idempotent; running it multiple times will not cause an error.
sudo ufw limit ssh/tcp

echo "UFW configuration complete."
echo "------------------------------------------"

# --- END SET UP
echo "Raspberry Pi setup complete!"
echo "You may need to log out and log back in for some changes to take effect."
