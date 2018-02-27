#~/dotfiles

##macOS

Clone repo into home directory.

Delete .bash_profile from the home directory:
```bash
rm ~/.bash_profile
```


Create symlink to new .bash_profile in the home directory:
```bash
ln -s ~/dotfiles/.bash_profile ~
```

Now you doin it

##Linux/Ubuntu (Raspberry Pi,Pine64 etc)

Delete .bashrc from the home directory:
```bash
rm ~/.bashrc
```


Create symlink to new .bash_profile in the home directory:
```bash
ln -s ~/dotfiles/.bash_profile ~/.bashrc
```
