# Dotfiles

Configuration for macOS, Linux and Windows, organised into packages managed with
[GNU Stow](https://www.gnu.org/software/stow/).

From the root of this repository, stow a package into your home directory:

```sh
stow --target="$HOME" zsh
```

Choose the packages you need for the machine. For example, on macOS:

```sh
stow --target="$HOME" macos tmux scripts
```

To remove a package's Stow links without deleting its files from this repository:

```sh
stow --delete --target="$HOME" zsh
```

To refresh links after changing a package, use `stow --restow --target="$HOME" zsh`.
