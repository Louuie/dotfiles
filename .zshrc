. "$HOME/.cargo/env"
export PATH=~/.npm-global/bin:$PATH
export CLOUDSDK_PYTHON=python2

# Neofetch
neofetch

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line



# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Aliases for github
alias ga="git add"
alias gp="git push -u origin master"
alias gc="git clone"

# Aliases for streamlink
alias sl="streamlink"

# Aliases for colored ls
alias ls="ls --color=auto"

# Aliases for Maven
alias mbld="mvn package"

# Aliases for Vim
alias v="vim"

# Aliases for nvidia-settings
alias nvs="nvidia-settings"

# Aliases for easy reboot
alias rbt="sudo reboot now"

# Aliases for building arch linux packages
alias mpkg="makepkg -si"

# Aliases for connecting to certain SSH servers
alias kodex="ssh kodex@107.185.51.97 -p26"
alias ftbvps="ssh ftbvps@107.185.51.97 -p22"

# Aliases for running Xinitrc
alias x="/./.xinitrc.sh"

# Aliases for running GoXLR
alias goxlr="cd Softwares/goxlr-on-linux && ./run_goxlr.sh"

# Alias for running i3memory script by Brodie Roberston
alias i3memory="./i3memory.sh"

# Adding Git support?
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'
# PROMPT='${vcs_info_msg_0_}%# '
zstyle ':vcs_info:git:*' formats '%b'


# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# Suggest aliases for commands
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh 2>/dev/null
# Search repos for programs that can't be found
source /usr/share/zsh/plugins/command-not-found.zsh 2>/dev/null
# Added Git plugin
source /usr/share/zsh/plguins/git.plugin.zsh 2>/dev/null

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/louie/Softwares/google-cloud-sdk/path.zsh.inc' ]; then . '/home/louie/Softwares/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/louie/Softwares/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/louie/Softwares/google-cloud-sdk/completion.zsh.inc'; fi
