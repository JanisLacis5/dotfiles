autoload -Uz compinit
compinit

# Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '^F' forward-char
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000

setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# Better directory handling / window size
setopt AUTO_CD
setopt CHECK_JOBS

# Enable completion

# If you want ** globbing like bash's globstar
setopt GLOBSTARSHORT

# lesspipe
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# Debian chroot name
if [[ -z "${debian_chroot:-}" && -r /etc/debian_chroot ]]; then
    debian_chroot=$(< /etc/debian_chroot)
fi

# Colors
autoload -Uz colors
colors

# Prompt with username, cwd, and git branch
setopt PROMPT_SUBST
PROMPT='%(?..%F{red}[%?] %f)%F{219}%n%f %F{141}%~%f %F{117}$(git branch 2>/dev/null | grep "*" | sed "s/*//")%f \$ '

# Terminal title for xterm-like terminals
case "$TERM" in
    xterm*|rxvt*)
        precmd() {
            print -Pn "\e]0;${debian_chroot:+($debian_chroot)}%n@%m: %~\a"
        }
        ;;
esac

# ls / grep colors
if [[ -x /usr/bin/dircolors ]]; then
    if [[ -r ~/.dircolors ]]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi

    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# alert alias
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(fc -ln -1 | sed -e '\''s/[;&|]\s*alert$//'\'')"'

# Load aliases from separate file if present
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# PATH
export PATH="$HOME/.local/kitty.app/bin:$PATH"
