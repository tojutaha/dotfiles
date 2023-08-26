# Set up the prompt
#source ~/.zplug/init.zsh
#zplug load

autoload -U colors && colors
#PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "

autoload -Uz promptinit
promptinit
#prompt adam1
prompt fire
#PROMPT="[%*] %n %d "
#PROMPT="[%*] %n %~ "
#PROMPT="%{$fg[blue]%}%*%{$reset_color%}%{$fg[yellow]%}%n%{$reset_color%}%{$fg[green]%}%d%{$reset_color%} "
PROMPT="%{$fg[blue]%}%*%{$reset_color%} %{$fg[yellow]%}%n%{$reset_color%}%{$fg[green]%} %~%{$reset_color%} "
#PS1="%n@%m~ %& # "
setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

alias ls='exa -l --color=always --group-directories-first'
alias cal='ncal -B 1 -A 1'
alias cls='clear'

#ZSH_THEME="gruvbox"
#ZSH_THEME="sunrise"
#SOLARIZED_THEME="dark"

plugins=(
    git
)

export PATH="/usr/local/opt/llvm/bin:$PATH"
