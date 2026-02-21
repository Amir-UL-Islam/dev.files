My day job is mostly focused on Java and DevOps in the Unix platform. Therefore most of **zsh, tmux** config focused on servers and Java.
I have also included [sshh](https://github.com/yudai/sshh) (wonderful tool for ssh reconned) and [git-recover](https://github.com/ethomson/git-recover)(unfortunately does not ship  with git)

And use nvim for Quick fixing.

I am trying to update my .dotfiles config as plugin-less as possible. If you have any ideas, share your thoughts. 

## macOS Install
1. Install Homebrew from https://brew.sh
2. Run:

```bash
./install.sh
```

What this does:
- Installs all Homebrew packages and casks in `Brewfile`
- Symlinks configs for `tmux`, `nvim`, `zsh`, and `kitty`
- Installs vim-plug and Neovim plugins
- Installs CoC extensions listed in `init.vim`
