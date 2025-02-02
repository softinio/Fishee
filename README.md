![Fishee Logo By Caspian Rahmanian](FisheeLogo.jpeg)

<sub>Fishee Logo By [Caspian Rahmanian](https://github.com/ducktinio)</sub>

# Fishee

Fishee CLI Tool for Fish Shell

## About Fishee

So I have been a user of Fish Shell for quite a while now and really enjoy using it.

So I decided to write this CLI tool for Fish Shell that helps me manage my fish history.

## Features

- Print my fish history
- Merge two history files into one
    - Useful for when you want to add fish history from one computer to another
- remove duplicates from history file when merging

## Usage

In terminal run:

```bash
fishee --help
```

```
USAGE: fishee [--history-file <history-file>] [--merge-file <merge-file>] [--output-file <output-file>] [--dry-run] [--remove-duplicates] [--backup] [--no-backup]

OPTIONS:
  -f, --history-file <history-file>
                          Location of your fish history file. Will default to
                          ~/.local/share/fish/fish_history
  -m, --merge-file <merge-file>
                          File path to file to merge with history file.
  -w, --output-file <output-file>
                          File to write to. Default: same as current history
                          file.
  -d, --dry-run           Dry run. Will only print to the console without
                          actually modifying the history file.
  -r, --remove-duplicates Remove duplicates from combined history. Default:
                          false
  -b, --backup/--no-backup
                          Backup fish history file given before writing.
                          (default: --backup)
  -h, --help
```
