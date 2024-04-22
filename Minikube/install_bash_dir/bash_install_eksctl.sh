#!/bin/bash

# Set architecture, use 'arm64' for ARM systems
ARCH="amd64"
PLATFORM="$(uname -s)_$ARCH"

# Download eksctl
echo "Downloading eksctl..."
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# Optional: Verify checksum
echo "Verifying checksum..."
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

if [ $? -ne 0 ]; then
    echo "Checksum verification failed. Exiting..."
    exit 1
else
    echo "Checksum verified successfully."
fi

# Extract and install eksctl
echo "Installing eksctl..."
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
sudo mv /tmp/eksctl /usr/local/bin

# Verify installation
echo "Verifying eksctl installation..."
eksctl version

if [ $? -eq 0 ]; then
    echo "eksctl installed successfully."
else
    echo "Failed to verify eksctl installation. Exiting..."
    exit 1
fi

# Creating a cluster (commented out - uncomment to use)
# echo "Creating an Amazon EKS cluster..."
# eksctl create cluster

echo "Installation complete. Use 'eksctl create cluster' to create your EKS cluster."
