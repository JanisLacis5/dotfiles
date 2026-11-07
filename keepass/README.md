# KeePassXC / rclone / Stow

A single Stow package installs the two scripts and their user-systemd units.
Only enable `keepass-sync.timer` on desktop/laptop and only enable
`keepass-backup.timer` on the backup server.

## Prerequisites

`rclone`, `stow`, and `flock` (from util-linux). Configure an rclone Google Drive
remote named `gdrive` separately on each machine. Keep `rclone.conf` out of Git.

## Install

From the `keepass-stow` directory (or copy its `keepass` directory into your dotfiles):

```sh
stow -t "$HOME" keepass
systemctl --user daemon-reload
```

If your dotfiles already use Stow, merge the `keepass` package into that repo.

## First-time sync (desktop and laptop)

Merge any divergent databases in KeePassXC first and back up originals.
The local database is the file `~/Passwords` (not a directory). Its Google Drive
path is `Passwords/Passwords`, or `gdrive:Passwords/Passwords` in rclone.
Make sure the local database exists. Create the remote folder with rclone and
place the authoritative database at `gdrive:Passwords/Passwords` before resyncing.

```sh
rclone mkdir gdrive:Passwords
# If the local database is authoritative, upload it first:
rclone copyto "$HOME/Passwords" gdrive:Passwords/Passwords
rclone bisync "$HOME" gdrive:Passwords --include '/Passwords' --resync-mode path2 --dry-run
# Inspect output; only if expected:
rclone bisync "$HOME" gdrive:Passwords --include '/Passwords' --resync-mode path2
systemctl --user enable --now keepass-sync.timer
```

`--resync-mode path2` makes Google Drive win for files present on both sides.
A normal run must not use `--resync`.
The include filter limits syncing to the database file. If migrating from the
old directory layout, repeat this initialization for the new paths before
enabling the timer.

## Backup server

```sh
systemctl --user enable --now keepass-backup.timer
systemctl --user start keepass-backup.service
ls -lh "$HOME/backups/keepass"
```

If the server runs without an interactive session, run once:

```sh
sudo loginctl enable-linger "$USER"
```

## Logs

```sh
journalctl --user -u keepass-sync.service -n 60
journalctl --user -u keepass-backup.service -n 60
```

**Caution:** Independent `bisync` runs on multiple machines are not a shared
transaction/lock. Concurrent editing can produce conflicts, and the
`--conflict-resolve newer` policy keeps the newer timestamp as the canonical
name while renaming the other version. Check for `.conflict*` files and merge
with KeePassXC. The server snapshots are write-once by script behavior, not
filesystem-enforced immutable backups.
