# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="/home/josh/.oh-my-zsh"

ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR='nvim'
export TERMINAL="st"
alias vim="nvim"
alias yt="youtube-dl --add-metadata -i"
alias yta="yt -x -f bestaudio/best"
alias ffmpeg="ffmpeg -hide_banner"
alias s=". search"
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

export PATH="$PATH:/home/josh/.local/bin"
bindkey -v
export SUDO_ASKPASS=/usr/lib/ssh/x11-ssh-askpass
