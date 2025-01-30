#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 -d <directories> [-b <backup_location>] [-i <interval_seconds>] [-n <num_backups>]"
    echo "  -d: Comma-separated list of directories to back up (e.g., /path/to/dir1,/path/to/dir2)"
    echo "  -b: Backup location (default is the current directory of the script)"
    echo "  -i: Time interval between backups in seconds (default is 3600 seconds)"
    echo "  -n: Number of backup versions to keep (default is 5)"
    exit 1
}

# Default values
DIRECTORIES=""
INTERVAL=3600  # Default interval is 1 hour
NUM_BACKUPS=5  # Default number of backups to keep

# Get the directory where the script is located (default backup location)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_LOCATION="$SCRIPT_DIR"

# Parse command-line arguments
while getopts ":d:b:i:n:" opt; do
    case ${opt} in
        d)
            DIRECTORIES=$OPTARG
            ;;
        b)
            BACKUP_LOCATION=$OPTARG
            ;;
        i)
            INTERVAL=$OPTARG
            ;;
        n)
            NUM_BACKUPS=$OPTARG
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done

# Check if required parameters are provided
if [ -z "$DIRECTORIES" ]; then
    echo "Error: Directories must be specified."
    usage
fi

# Convert comma-separated directories into an array
IFS=',' read -r -a DIR_ARRAY <<< "$DIRECTORIES"

# Ensure backup directory exists
mkdir -p "$BACKUP_LOCATION"

# Infinite loop for periodic backups
while true; do
    # Create a timestamped backup folder
    TIMESTAMP=$(date +"%Y%m%d%H%M%S")
    BACKUP_DIR="$BACKUP_LOCATION/Autobackup_$TIMESTAMP"
    mkdir -p "$BACKUP_DIR"

    # Copy each specified directory into the backup folder
    for dir in "${DIR_ARRAY[@]}"; do
        if [ -d "$dir" ]; then
            echo "Backing up $dir to $BACKUP_DIR"
            cp -r "$dir" "$BACKUP_DIR/"
        else
            echo "Directory $dir does not exist, skipping..."
        fi
    done

    # Remove old backups beyond the specified number, but only those matching the backup folder naming pattern
    BACKUP_FOLDERS=($(ls -dt "$BACKUP_LOCATION"/Autobackup_* 2>/dev/null | tail -n +$((NUM_BACKUPS+1))))
    
    for old_backup in "${BACKUP_FOLDERS[@]}"; do
        if [[ "$old_backup" == "$BACKUP_LOCATION"/Autobackup_* ]]; then
            echo "Removing old backup: $old_backup"
            rm -rf "$old_backup"
        else
            echo "Skipping non-backup folder: $old_backup"
        fi
    done

    echo "Backup completed at $TIMESTAMP. Next backup in $INTERVAL seconds."
    
    # Wait for the specified interval before the next backup
    sleep "$INTERVAL"
done
