# KeePassXC / rclone / Stow

# 1. Install dependencies
sudo apt install -y stow curl
curl -fsSL https://rclone.org/install.sh | sudo bash

# 2. Configure Google Drive (create remote named "gdrive")
rclone config

# 3. Verify remote database exists
rclone lsf gdrive:Passwords/

# 4. Install dotfiles
cd ~/dotfiles
stow --ignore='README\.md' keepass
chmod +x ~/.local/bin/keepass-sync

# 5. Back up existing local database, if present
if [ -f "$HOME/Passwords" ]; then
    cp -p "$HOME/Passwords" "$HOME/Passwords.bak"
fi

# 6. Stop any existing synchronization
systemctl --user stop keepass-sync.timer

# 7. Preview initial synchronization (Google Drive takes precedence)
rclone bisync "$HOME" gdrive:Passwords \
    --include '/Passwords' \
    --resync-mode path2 \
    --dry-run -v

# 8. Initialize synchronization
# IMPORTANT: Review the dry-run output before executing this.
# Merge any local-only credentials into the Drive database first.
rclone bisync "$HOME" gdrive:Passwords \
    --include '/Passwords' \
    --resync-mode path2 -v

# 9. Reload systemd and enable automatic synchronization
systemctl --user daemon-reload
systemctl --user reset-failed keepass-sync.service
systemctl --user enable --now keepass-sync.timer

# 10. Test synchronization
systemctl --user start keepass-sync.service

# 11. Verify service and timer
systemctl --user status keepass-sync.service
systemctl --user status keepass-sync.timer

# 12. Check logs
journalctl --user -u keepass-sync.service -n 50 --no-pager

# 13. Verify the databases are identical
rclone check "$HOME" gdrive:Passwords \
    --include '/Passwords' \
    --download
