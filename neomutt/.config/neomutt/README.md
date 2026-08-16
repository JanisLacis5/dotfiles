# NeoMutt starter config

This config mirrors the uploaded Neovim setup where that makes sense:

- Catppuccin Mocha colours
- `j/k`, `gg/G`, Ctrl-d/Ctrl-u movement
- Space-leader macros
- Ctrl-h/Ctrl-l and Tab/Shift-Tab mailbox navigation
- NeoVim as the message editor
- Sidebar as the rough equivalent of NvimTree

## Install

```sh
mkdir -p ~/.config/neomutt ~/.cache/neomutt/{headers,bodies}
cp neomuttrc colors-catppuccin-mocha bindings-vim mailcap ~/.config/neomutt/
cp account.example ~/.config/neomutt/account
chmod 600 ~/.config/neomutt/account
$EDITOR ~/.config/neomutt/account
```

Then uncomment this line in `~/.config/neomutt/neomuttrc`:

```neomuttrc
source ~/.config/neomutt/account
```

Start with:

```sh
neomutt
```

Check configuration errors with:

```sh
neomutt -F ~/.config/neomutt/neomuttrc -D
```

## Required / optional tools

- Required: NeoMutt, NeoVim
- Recommended: `pass` or `secret-tool` for credentials
- HTML rendering: `w3m` or `lynx`
- GUI attachment opening: `xdg-open`

## Important

The account file is not plug-and-play. IMAP hosts, SMTP hosts, ports, folder names,
and authentication differ by provider. Blindly pasting credentials into the main
config is bad practice; keep `account` mode `0600` and preferably use a password manager.

Some terminals do not transmit every modified key distinctly. If Ctrl-h or Shift-Tab
behaves strangely, inspect the terminal/tmux bindings before blaming NeoMutt.
