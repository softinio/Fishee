![Fishee Logo By Caspian Rahmanian](FisheeLogo.jpeg)

<sub>Fishee Logo By [Caspian Rahmanian](https://github.com/ducktinio)</sub>

# Fishee

Fishee is a command-line interface (CLI) tool designed specifically for users of the Fish Shell. It provides a convenient way to manage and manipulate your Fish Shell history files, making it easier to maintain and transfer command history across different environments.

## About Fishee

As a long-time user of the Fish Shell, I developed Fishee to streamline the process of handling Fish Shell history files. Whether you're looking to consolidate history from multiple machines or simply want to clean up your existing history, Fishee offers a set of features to assist you.

## Features

- **Print Fish History**: Display the contents of your Fish Shell history file directly in the terminal.
- **Merge History Files**: Combine two Fish Shell history files into one. This is particularly useful when you want to integrate history from different computers or backups.
- **Remove Duplicates**: Automatically eliminate duplicate entries from the merged history file, ensuring a clean and concise history.
- **Backup and Restore**: Optionally create a backup of your current history file before making any changes, providing a safety net in case you need to revert.

## Usage

To get started with Fishee, open your terminal and run the following command to see the available options:

```bash
fishee --help
```

### Command-Line Options

```
USAGE: fishee [--history-file <history-file>] [--merge-file <merge-file>] [--output-file <output-file>] [--dry-run] [--remove-duplicates] [--backup] [--no-backup]

OPTIONS:
  -f, --history-file <history-file>
                          Specify the location of your Fish Shell history file. Defaults to
                          ~/.local/share/fish/fish_history if not provided.
  -m, --merge-file <merge-file>
                          Provide the file path of the history file you wish to merge with your current history.
  -w, --output-file <output-file>
                          Define the file to write the merged history to. By default, it overwrites the current history file.
  -d, --dry-run           Perform a dry run to preview changes without modifying the actual history file.
  -r, --remove-duplicates Remove duplicate entries from the combined history. Default is false.
  -b, --backup/--no-backup
                          Choose whether to backup the current history file before writing changes. Default is --backup.
  -h, --help              Display help information about the Fishee tool.
```
