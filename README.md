#~/dotfiles

##macOS

###Setup new macOS machine

This repository is only accessible via SSH key verification (for no reason honestly). You'll need to create an SSH key on the new machine and add it to your [Bitbucket Settings](https://bitbucket.org/account/user/rootbeersoup/ssh-keys/)

```bash
ssh-keygen
cat ~/.ssh/id_rsa.pub | pbcopy
```

Once that's all done:

```bash
git clone git@bitbucket.org:rootbeersoup/dotfiles.git && cd dotfiles && source bootstrap.sh
```

The [`bootstrap.sh`](https://bitbucket.org/rootbeersoup/dotfiles/src/master/bootstrap.sh) script:

* Updates macOS if necessary
* Installs [Homebrew](https://brew.sh)
* Installs all packages and applications specified in the [`Brewfile`](https://bitbucket.org/rootbeersoup/dotfiles/src/master/Brewfile)
* Creates necessary symlinks to the home directory via GNU Stow
* Installs preferred macOS system defaults via [`defaults.sh`](https://bitbucket.org/rootbeersoup/dotfiles/src/master/defaults.sh)


Now you doin it

###Maintaining macOS setup

Symlinks are managed with GNU Stow (installed with Homebrew). Files you wish to be symlinked to the home directory need to be placed in a folder within `~/dotfiles`. Using the `stow` command from the `~/dotfiles` directory will symlink the contents of the folder you choose (`/bash`, `/vim`, etc) to the grandparent directory, which is wherever the `/dotfiles` folder is contained.

Assuming you clone the dotfiles repository in your home directory, executing the commands:
```bash
cd ~/dotfiles
stow bash
```
will symlink the contents of `dotfiles/bash` to the home directory, which is currently `.bash_profile` and `.bashrc`

You can use the `stow` command anytime you add a new file to a folder you wish to symlink directly to the home directory. You do not need to delete existing files or symlinks; GNU Stow will overwrite them automatically. This can all be done without Stow using the `ln -s` command, but I find Stow with folder management to be cleaner and easier to maintain.


##How it Works

[`.bash_profile`](https://bitbucket.org/rootbeersoup/dotfiles/src/master/bash/.bash_profile) automatically sources configurations defined in the files contained in the main /dotfiles folder. Any file beginning with `.` will automatically be sourced.
