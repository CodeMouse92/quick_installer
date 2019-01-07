# CodeMouse92's Quick Installer

This is a script I use to quickly install recommended packages on my OEM installations of Ubuntu.
It automatically adds the official or best PPAs for packages, when possible. See the
`-h` command for help.

Before you use this yourself, I recommend you carefully review what packages will be installed.
The `-L` option will list the packages and their sources.

**Only intended to be used with Ubuntu 18.04 and later.**

## Installation

To download and use this script, run the following in your home folder.

```bash
wget https://github.com/CodeMouse92/quick_installer/blob/master/quick_installer.sh
chmod +x quick_installer.sh
./quick_installer.sh
```

## Usage
To use, simply invoke with one or more options. See `-h` for the complete list of options.

```bash
./quick_installer.sh -h
```

For example, to install the recommended office and reference packages, run...

```bash
./quick_installer.sh -or
```

**I strongly recommend deleting the script from your home folder when you're done using it.**
