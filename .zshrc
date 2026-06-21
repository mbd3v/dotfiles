# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias dotfile_config="git --git-dir=$HOME/.dot_cfg/.git --work-tree=$HOME/.dot_cfg"
alias ll="ls -la --color=auto"
alias ls="ls --color=auto"
alias cd="z"


HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

if [ -d /home/$USER/go/bin ]; then
    export PATH=$PATH:/home/$USER/go/bin
fi

if [ -d /home/$USER/.my_bin ]; then
    alias nvim="~/.my_bin/nvim.appimage"
    if [ -d /home/$USER/.my_bin/go ]; then 
        export PATH=$PATH:/home/$USER/.my_bin/go/bin
    fi
fi

export VISUAL=nvim
export EDITOR="$VISUAL"

export GPG_TTY=$TTY


export PATH=$PATH:/home/$USER/.local/bin

# Change the path to your mingw bin files if different
# The check is reduntant however makes it so there is no error if adding this .zshrc
# to your system.
if [ -d /mnt/c/dev/MinGW/ ]; then
    export PATH=$PATH:/mnt/c/dev/MinGW/bin
fi

if [ -d /home/$USER/.cargo/bin/ ]; then
    export PATH=$PATH:/home/$USER/.cargo/bin
fi

# Note that ".ghidra_bin" is a custom name I gave to the ghidra folder 
# containing the ghidraRun file.
if [ -d /home/$USER/.ghidra_bin ]; then
    export PATH=$PATH:/home/$USER/.ghidra_bin
fi

if [ -d /usr/local/cuda-12.3/bin ]; then
    export PATH=$PATH:/usr/local/cuda-12.3/bin
fi

if [ -d /mnt/c/Program\ Files/Microsoft\ Visual\ Studio/2022/Community/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin ]; then
    export PATH=$PATH:/mnt/c/Program\ Files/Microsoft\ Visual\ Studio/2022/Community/Common7/IDE/CommonExtensions/Microsoft/CMake/CMake/bin 
fi

if [ -d /usr/local/go ]; then
    export PATH=$PATH:/usr/local/go/bin
fi

if [ -d /home/$USER/go/bin ]; then
    export PATH=$PATH:/home/$USER/go/bin
fi

if [ -S /home/$USER/.bitwarden-ssh-agent.sock ]; then
    export SSH_AUTH_SOCK=/home/$USER/.bitwarden-ssh-agent.sock
fi


# If you are using GWSL and not using Windows 11 and not using WSL Version 2 for your 
# linux distrobution, then uncomment the following two lines to enable the use of
# GWSL for running linux gui applications.

# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0 #GWSL
# export PULSE_SERVER=tcp:$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}') #GWSL

export NVM_DIR="/home/viper/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# export GIT_SSH_COMMAND="ssh -i ~/.ssh/mab7470"

export CHROME_BIN=/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe

# Load Angular CLI autocompletion.
#source <(ng completion script)

# For local installations when using git clone of the repo
#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# For when installed via DNF on fedora
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Check if podman-remote exists, and podman does not. If not, create alias
if ! command -v podman >/dev/null 2>&1 && command -v podman-remote >/dev/null 2>&1; then
    alias podman="podman-remote"
fi


autoload -U compinit; compinit
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

cd ~
