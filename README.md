Dotfiles for use on MacOS and Linux based machines.

Dotfiles are managed using [GNU Stow](https://www.gnu.org/software/stow/)

Newsboat has alternative Stow packages. Install only one on each machine:

- `stow newsboat` uses FreshRSS and the shared query list.
- `stow newsboat-work` uses the work machine's standalone config and feed URLs.

When switching, unstow the previous package first (for example,
`stow -D newsboat`), then stow the desired package. Back up any regular files
in `~/.config/newsboat/` before replacing them with Stow links.
For another machine, copy `newsboat-work` to `newsboat-<machine>`, edit its
config and URLs, and stow that package instead.
