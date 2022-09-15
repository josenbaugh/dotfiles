# If you come from bash you might have to change your $PATH.  export PATH=$HOME/bin:/usr/local/bin:$PATH

DISABLE_AUTO_TITLE="true"

setopt prompt_subst             # allow command substitution inside the prompt
PROMPT='%F{#b93429}%~ %F{#81a396}$(git_branch)%F{#ebdbb2}%(!.#.$) %f'     # set the prompt value

bindkey -v


## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expan
setopt share_history          # share command history data

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='nvim'
export TERMINAL="st"
export SUDO_ASKPASS=/usr/lib/ssh/x11-ssh-askpass
export GNUPGHOME="${XDG_DATA_HOME:-${HOME:-/home/$LOGNAME}}/.gnupg"
export PATH="$PATH:/home/josh/.local/bin"

alias vim="nvim"
alias yt="youtube-dl --add-metadata -i"
alias yta="yt -x -f bestaudio/best"
alias ffmpeg="ffmpeg -hide_banner"
alias s=". search"
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
alias salt='docker exec -it web ./salt'
alias saltlogs='docker-compose exec web bash -c "tail -f /www/saltlog/elk.log | jq ."'

# open keychain
eval `keychain --eval -Q --quiet --nogui --noask ~/.ssh/id_rsa_xyz`

# fix home end delete
bindkey "^[[H" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char

# autocompletion using arrow keys (based on history)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search # Up
bindkey '\e[B' down-line-or-beginning-search # Down

# case insensitive tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# function to return current branch name or nothing
function git_branch() {
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $branch == "" ]]; then
        :
    else
        printf '(%s)' $branch
    fi
}

# put pwd in title
# last command failed, print x then prompt
precmd() {
    if [[ $? == 0 ]];  then
        echo -en "\e]2;$PWD\a"
    else
        printf $'❌ \n'
    fi

}


. /home/josh/torch/install/bin/torch-activate
