# dev-setup

Scripts and dotfiles to quickly set up dev environment.

## Usage

### Windows

```powershell
.\setup.ps1 -Distro Ubuntu # or other
```

### WSL / Linux

1. Clone the repo
   ```sh
   git clone https://github.com/mkk5/dev-setup.git && cd ~/dev-setup
   ```
2. Install [uv](https://docs.astral.sh/uv/getting-started/installation/)
3. Install Ansible and run the playbook
   ```sh
   uv tool install ansible
   ansible-playbook playbook.yml
   ```
4. Place private files

   | File | Destination |
   |---|---|
   | SSH keys | `~/.ssh/` |
   | `config.private` | `~/.ssh/` |
   | `.gitconfig-work` | `~/` |

## Private Dotfile Examples

```
# ~/.gitconfig-work
[user]
    email = <email>
    signingkey = ~/.ssh/<name>.pub
```
```
# ~/.ssh/config.private
Host a1-o
    HostName <ip>
```

## TODO
- Replace `setup.ps1` with [WinGet configuration](https://learn.microsoft.com/en-us/windows/package-manager/configuration/) | [DSC](https://learn.microsoft.com/en-us/powershell/dsc/overview?view=dsc-3.0)
- Ansible playbook
- Add `wsl.conf`
- Add `.bashrc` config
    - bash_completion
    - colors
    - git branches
    - aliases
    - start ssh-agent, etc
