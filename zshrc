# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:/$HOME/.bin:$HOME/.emacs.d/elpa/rtags-20180619.823/rtags-2.18/bin:$PATH
export PATH=$HOME/Documents/software/deep-mesos/deep-mesos/client-tools:$PATH
export FPATH=$HOME/.zsh_custom:$FPATH
export PYTHON_CONFIGURE_OPTS="--enable-shared"
#export PYTHONPATH=$HOME/Documents/gaze-label-web/server/app

export ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export TERM=xterm-256color

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gentoo"


# BULLETTRAIN_PROMPT_ORDER=(
#   context
#   dir
#   virtualenv
# )
# BULLETTRAIN_CONTEXT_BG=238
# BULLETTRAIN_VIRTUALENV_BG=red
# BULLETTRAIN_VIRTUALENV_FG=black
# BULLETTRAIN_DIR_BG=blue
# BULLETTRAIN_DIR_FG=black
# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"


# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"


# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"


# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13


# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"


# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"


# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"


# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"


# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"


# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"


# Would you like to use another custom folder than $ZSH/custom?
 ZSH_CUSTOM=~/.zsh_custom/


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    docker
    git
    vi-mode
    pip
    colored-man-pages
    command-not-found
    extract
    z
)


source $ZSH/oh-my-zsh.sh


# User configuration


# export MANPATH="/usr/local/man:$MANPATH"


# You may need to manually set your language environment
# export LANG=en_US.UTF-8


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


bindkey "^K" up-line-or-search
bindkey "^J" down-line-or-search
autoload -U zranger
bindkey -s '^O' 'zranger^M'
alias pdfjoin="pdfjoin --paper a4paper --rotateoversize false"

alias -g 'llvm=llvm -t zsh'
alias tmux='tmux -u'
alias o='mimeopen'
alias em='emacsclient -nc'

export EDITOR="emacsclient -nc"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/laurent/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/laurent/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/laurent/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/laurent/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

conda activate my
# <<< conda initialize <<<


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/laurent/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/laurent/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/laurent/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/laurent/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
