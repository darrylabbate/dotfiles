This README contains info for configurations which need to be done manually

## Change computer name

Changing the computer's name via `scutil` allows you to remove the `.local` extension that macOS appends by default. This annoyingly shows up in things like SSH keys.

```
scutil --set ComputerName <computername>
scutil --set HostName <computername>
```

## Install Adobe CC

Homebrew will install the Adobe CC installer via Homebrew Cask, but the installer still needs to be run manually to set up Adobe CC for the machine. The installer is currently found at `/usr/local/Caskroom/adobe-creative-cloud/latest/Creative Cloud Installer.app`.
