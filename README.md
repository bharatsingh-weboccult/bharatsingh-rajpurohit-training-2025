# bharatsingh-rajpurohit-training-2025

---

## Backup Automation Script

This Bash script automates the process of backing up specified directories to a designated backup location. It creates timestamped backup folders, retains a configurable number of backup versions, and deletes older backups to save space.

---

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Prerequisites](#prerequisites)
4. [Usage](#usage)
5. [Command-Line Options](#command-line-options)
6. [How It Works](#how-it-works)
7. [Example](#example)
8. [Contributing](#contributing)
9. [License](#license)

---

## Overview

The script is designed to automate periodic backups of specified directories. It ensures that only a certain number of backup versions are retained, automatically deleting older backups to save disk space. The script is highly customizable, allowing users to specify directories, backup locations, intervals, and retention policies.

---

## Features

- **Timestamped Backups**: Each backup is stored in a folder named with a timestamp (e.g., `Autobackup_20231004120000`).
- **Customizable Backup Location**: Users can specify a custom backup location or use the default location (the directory where the script resides).
- **Retention Policy**: Retains only a specified number of backup versions and deletes older ones.
- **Error Handling**: Skips non-existent directories and avoids deleting unrelated files or folders.
- **Interval-Based Execution**: Runs backups at regular intervals (in seconds).

---

## Prerequisites

- **Bash Shell**: The script is written for Bash and requires a Linux/Unix-based system.
- **Permissions**: Ensure the user running the script has write permissions to the backup location.
- **Directories**: Verify that the directories you want to back up exist and are accessible.

---

## Usage

To run the script, use the following syntax:

```bash
./backup.sh -d <directories> [-b <backup_location>] [-i <interval_seconds>] [-n <num_backups>]
```

### Example:
```bash
./backup.sh -d /home/user/documents,/home/user/pictures -b /mnt/backup -i 7200 -n 3
```

---

## Command-Line Options

| Option | Description                                                                 | Default Value               |
|--------|-----------------------------------------------------------------------------|-----------------------------|
| `-d`   | Comma-separated list of directories to back up (required).                  | None (must be specified)    |
| `-b`   | Backup location (optional).                                                | Current directory of script |
| `-i`   | Time interval between backups in seconds (optional).                       | 3600 seconds (1 hour)       |
| `-n`   | Number of backup versions to keep (optional).                              | 5                           |

---

## How It Works

1. **Backup Creation**:
   - The script creates a new folder with a timestamped name (e.g., `Autobackup_20231004120000`) in the specified backup location.
   - It copies the contents of the specified directories into this folder.

2. **Cleanup**:
   - After creating the new backup, the script lists all existing backup folders (`Autobackup_*`) in the backup location.
   - It keeps only the most recent `NUM_BACKUPS` backup folders and deletes older ones.

3. **Interval**:
   - The script waits for the specified interval (`INTERVAL`) before running the next backup.

---

## Example

### Scenario:
You want to back up `/home/user/documents` and `/home/user/pictures` every 2 hours and retain only the 3 most recent backups.

### Command:
```bash
./backup.sh -d /home/user/documents,/home/user/pictures -b /mnt/backup -i 7200 -n 3
```

### Output:
- A new backup folder will be created every 2 hours in `/mnt/backup` (e.g., `/mnt/backup/Autobackup_20231004120000`).
- Only the 3 most recent backups will be retained, and older ones will be deleted.

---

## Contributing

If you'd like to contribute to this project:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m "Add some feature"`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

---
Let me know if you need help with anything else! 😊
