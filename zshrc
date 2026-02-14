function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF=$'%F{yellow}'
COLOR_TIME=$'%f'
COLOR_DIR=$'%F{197}'
COLOR_GIT=$'%F{39}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_DIR}%~ ${COLOR_TIME}%@ 🌱 ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} ❯ '

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias ls="lsd"
alias vi="nvim"
alias dhc="cd /Users/amir/IdeaProjects/dhc"
alias idea="cd /Users/amir/IdeaProjects"
alias disk="dysk"
alias gsc="gitleaks protect --staged"


alias fzf="fzf -m --preview=\"bat --color=always {}\""


# for Fast loading
if [ $commands[kubectl] ]; then
  kubectl() {
    unfunction "$0"
    source <(kubectl completion zsh)
    $0 "$@"
  }
fi

# Auto Start Tmux
if [ -z "$TMUX" ]; then
    # Start tmux if not already inside a tmux session
    if tmux has-session 2>/dev/null; then # 2>/dev/null part redirects any error messages (if no session exists) to /dev/null, effectively suppressing them.
        exec tmux
    else
        exec tmux
    fi
fi



# For Markdown View on Terminal
mdp() {
    pandoc -t plain `find . -maxdepth 1 -iname "${1:-readme.md}"` | less
}


if [ ! -L ~/.config/alacritty/alacritty.toml ]; then
    ln -s ~/vim.kitty.tmux/alacritty.toml ~/.config/alacritty/alacritty.toml
fi

if [ ! -L ~/.gitconfig ]; then
    ln -s ~/vim.kitty.tmux/.gitconfig ~/.gitconfig
fi

if [ ! -L ~/.gitattributes ]; then
    ln -s ~/vim.kitty.tmux/.gitattributes ~/.gitattributes
fi

if [ ! -L /usr/local/bin/sshh ]; then
   ln -s ~/vim.kitty.tmux/sshh /usr/local/bin/sshh
fi
if [ ! -L /usr/local/bin/git-recover ]; then
   ln -s ~/vim.kitty.tmux/git-recover /usr/local/bin/git-recover
fi


# In your git-managed zshrc
function ssh() {
    # Load secrets only if the file exists
    local secret_file="$HOME/Library/Mobile Documents/com~apple~CloudDocs/env_secrets.sh"
    [ -f "$secret_file" ] && source "$secret_file"

    if [[ "$1" == "prod" ]]; then
        command ssh "${PROD_SERVER:-root@localhost}" "${@:2}"
    elif [[ "$1" == "dev" || "$1" == "stage" ]]; then
        command ssh "${DEV_SERVER:-cmed@localhost}" "${@:2}"
    elif [[ "$1" == "database" ]]; then
        command ssh "${DB_SERVER:-cmed@localhost}" "${@:2}"
    else
        command ssh "$@"
    fi
}

ae() {
    # Check for pyvenv.cfg in the current directory or any parent directory
    local env_dir=$(pwd)
    while [ "$env_dir" != "/" ]; do
        if [ -f "$env_dir/pyvenv.cfg" ] || [ -f "$env_dir/bin/activate" ]; then
            # Found a virtual environment
            source "$env_dir/bin/activate"
            return 0
        fi
        env_dir=$(dirname "$env_dir")
    done

    # Check the current directory's bin/activate as a last resort
    if [ -f "bin/activate" ]; then
        source "bin/activate"
    else
        echo "No virtual env present here"
        return 1
    fi
}
