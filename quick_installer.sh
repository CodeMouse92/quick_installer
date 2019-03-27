#!/bin/bash

function install_core {
    wget -qO - https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key add -
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ `lsb_release -sc` main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-`lsb_release -sc`.list

    sudo apt install -y apt-xapian-index brave-browser caffeine clamav clamav-daemon clamtk gufw libdvd-pkg mpv redshift-gtk synaptic ubuntu-restricted-extras

    sudo dpkg-reconfigure libdvd-pkg
}

function install_development {
    sudo apt install -y curl

    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update

    # Basic tools
    sudo apt install -y arcanist build-essential cmake code emacs geany geany-plugins git openssh-client kcachegrind meld php php-cli php-curl php-xml valgrind vim

    # C++
    wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
    sudo add-apt-repository -y "deb http://apt.llvm.org/`lsb_release -sc`/ llvm-toolchain-`lsb_release -sc` main"
    sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test

    sudo apt install -y python-lldb-6.0
    sudo apt install -y clang-6.0 clang-6.0-doc libclang-common-6.0-dev libclang-6.0-dev libclang1-6.0 libclang1-6.0-dbg libllvm6.0 libllvm6.0-dbg lldb-6.0 llvm-6.0 llvm-6.0-dev llvm-6.0-doc llvm-6.0-examples llvm-6.0-runtime clang-format-6.0 python-clang-6.0 libfuzzer-6.0-dev
    sudo ln -sf /usr/bin/llvm-symbolizer-6.0 /usr/bin/llvm-symbolizer
    sudo ln -sf /usr/bin/lldb-server-6.0 /usr/lib/llvm-6.0/bin/lldb-server-6.0.0
    sudo apt install -y gcc g++ gcc-8 g++-8 gcc-8-doc gcc-8-multilib g++-8-multilib libc6-dev-i386
    sudo apt install -y cccc cppcheck

    # Python
    sudo apt install -y pandoc pylint3 python3 python3-dev python3-pip python3-sphinx python3-virtualenv python-dev virtualenv

    # Java
    sudo apt install -y openjdk-11-doc openjdk-11-jdk openjdk-11-jre
}

function install_fun_games_puzzles {
    sudo apt install 2048-qt aisleriot gnome-games gnome-cards-data
}

function install_fun_games_full {
    install_fun_games_puzzles
    sudo apt install freeciv lincity-ng supertux supertuxkart wesnoth
}

function install_graphics_design {
    sudo add-apt-repository -y ppa:thomas-schiex/blender
    sudo add-apt-repository -y ppa:pmjdebruijn/darktable-release
    sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp
    sudo add-apt-repository -y ppa:inkscape.dev/stable
    sudo add-apt-repository -y ppa:kritalime/ppa
    sudo add-apt-repository -y ppa:scribus/ppa
    sudo apt remove -y gimp

    sudo apt install -y birdfont blender darktable gimp gpick inkscape krita mypaint pcregrep scribus synfigstudio

    cd /usr/local/bin
    sudo wget https://github.com/CodeMouse92/WacomRotate/raw/master/wacomrotate
    sudo wget https://github.com/CodeMouse92/WacomTouchToggle/raw/master/wacomtouch
    sudo wget https://github.com/CodeMouse92/WacomDisplayMap/raw/master/wacommap
    sudo chmod +x wacom*
}

function install_office {
    sudo add-apt-repository -y ppa:mdoyen/homebank
    sudo add-apt-repository -y ppa:libreoffice/ppa
    sudo add-apt-repository -y ppa:andreasbutti/xournalpp-master

    sudo apt install -y calibre dia focuswriter glabel gnome-calendar gnome-clocks gnome-todo gramps hexchat homebank libreoffice planner xournalpp
}

function install_production {
    sudo add-apt-repository -y ppa:ubuntuhandbook1/audacity
    sudo add-apt-repository -y ppa:audio-recorder/ppa
    sudo add-apt-repository -y ppa:stebbins/handbrake-releases
    sudo add-apt-repository -y ppa:mscore-ubuntu/mscore-stable
    sudo add-apt-repository -y ppa:ubuntuhandbook1/dvdstyler
    sudo add-apt-repository -y ppa:obsproject/obs-studio

    sudo apt install -y ardour audacity audio-recorder dvdstyler handbrake hydrogen hydrogen-drumkits hydrogen-drumkits-effects kdenlive lmms musescore obs-studio qjackctl
}

function install_reference {
    wget -qO - https://static.geogebra.org/linux/office@geogebra.org.gpg.key | sudo apt-key add -
    sudo add-apt-repository -y "deb http://www.geogebra.net/linux/ stable main"

    sudo apt install -y convertall geogebra-classic gnome-dictionary gnome-maps kalzium speedcrunch stellarium zegrapher
}

function install_upgrades {
    sudo apt update
    sudo apt full-upgrade -y
    sudo apt autoremove -y
    sudo apt autoclean
}

function show_help {
    echo "Quickly adds PPAs and installs packages for Ubuntu."
    echo "This utility was designed by CodeMouse92 for his OEM computer renovation work."
    echo "See -L for a complete list of packages."
    echo ""
    echo "Select one or more options."
    echo "    -c    Core"
    echo "    -d    Development Tools"
    echo "    -f    Fun & Games (All)"
    echo "    -g    Graphics Design"
    echo "    -o    Office"
    echo "    -p    Audio/Video Production"
    echo "    -r    Reference & Education"
    echo "    -u    Upgrades"
    echo "    -z    Fun & Games (Puzzles Only)"
}

function show_package_list {
    echo "=== Package List ==="

    echo ""
    echo "Core"
    echo "  * apt-xapian-index (main)"
    echo "  * brave-browser (deb https://brave-browser-apt-release.s3.brave.com/)"
    echo "  * caffeine (main)"
    echo "  * clamav (main)"
    echo "  * clamav-daemon (main)"
    echo "  * clamtk (main)"
    echo "  * gufw (main)"
    echo "  * libdvd-pkg (main)"
    echo "  * mpv (main)"
    echo "  * redshift-gtk (main)"
    echo "  * synaptic (main)"
    echo "  * ubuntu-restricted-extras (main)"

    echo ""
    echo "Development Tools"
    echo "  General Tools"
    echo "  * arcanist (main)"
    echo "  * build-essential (main)"
    echo "  * cmake (main)"
    echo "  * code (deb https://packages.microsoft.com/repos/vscode/)"
    echo "  * curl (main)"
    echo "  * emacs (main)"
    echo "  * geany (main)"
    echo "  * geany-plugins (main)"
    echo "  * git (main)"
    echo "  * kcachegrind (main)"
    echo "  * openssh-client (main)"
    echo "  * meld (main)"
    echo "  * php (main)"
    echo "  * php-cli (main)"
    echo "  * php-curl (main)"
    echo "  * php-xml (main)"
    echo "  * valgrind (main)"
    echo "  * vim (main)"
    echo "  C and C++"
    echo "  * cccc (main)"
    echo "  * cppcheck (main)"
    echo "  * [GCC 7 toolchain] (ppa:ubuntu-toolchain-r/test)"
    echo "  * [LLVM Clang 5.0 toolchain] (deb https://apt.llvm.org/)"
    echo "  Java"
    echo "  * openjdk-11-doc (main)"
    echo "  * openjdk-11-jdk (main)"
    echo "  * openjdk-11-jre (main)"
    echo "  Python 3"
    echo "  * pandoc (main)"
    echo "  * pylint3 (main)"
    echo "  * python3 (main)"
    echo "  * python3-dev (main)"
    echo "  * python3-pip (main)"
    echo "  * python3-sphinx (main)"
    echo "  * python3-virtualenv (main)"
    echo "  * python-dev (main)"
    echo "  * virtualenv (main)"

    echo ""
    echo "Fun & Games (Full)"
    echo "  * 2048-qt (main)"
    echo "  * aisleriot (main)"
    echo "  * freeciv (main)"
    echo "  * gnome-games (main)"
    echo "  * gnome-cards-data (main)"
    echo "  * lincity-ng (main)"
    echo "  * supertux (main)"
    echo "  * supertuxkart (main)"
    echo "  * wesnoth (main)"

    echo ""
    echo "Fun & Games (Puzzles Only)"
    echo "  * 2048-qt (main)"
    echo "  * aisleriot (main)"
    echo "  * gnome-games (main)"
    echo "  * gnome-cards-data (main)"

    echo ""
    echo "Graphics Design"
    echo "  * birdfont (main)"
    echo "  * blender (ppa:thomas-schiex/blender)"
    echo "  * darktable (ppa:pmjdebruijn/darktable-release)"
    echo "  * gimp (ppa:otto-kesselgulasch/gimp)"
    echo "  * gpick (main)"
    echo "  * inkscape (ppa:inkscape.dev/stable)"
    echo "  * krita (ppa:kritalime/ppa)"
    echo "  * mypaint (main)"
    echo "  * pcregrep (main) [needed for Wacom scripts]"
    echo "  * scribus (ppa:scribus/ppa)"
    echo "  * synfigstudio (main)"
    echo "  * [Wacom scripts from github.com/codemouse92]"

    echo ""
    echo "Office"
    echo "  * calibre (main)"    
    echo "  * dia (main)"
    echo "  * focuswriter (main)"
    echo "  * glabel (main)"
    echo "  * gnome-calendar (main)"
    echo "  * gnome-clock (main)"
    echo "  * gnome-todo (main)"
    echo "  * gramps (main)"
    echo "  * hexchat (main)"
    echo "  * homebank (ppa:mdoyen/homebank)"
    echo "  * libreoffice (ppa:libreoffice/ppa)"
    echo "  * planner (main)"
    echo "  * xournalpp (ppa:andreasbutti/xournalpp-master)"

    echo ""
    echo "Audio/Video Production"
    echo "  * ardour (main)"
    echo "  * audacity (ppa:ubuntuhandbook1/audacity)"
    echo "  * audio-recorder (ppa:audio-recorder/ppa)"
    echo "  * dvdstyler (ppa:ubuntuhandbook1/dvdstyler)"
    echo "  * handbrake (ppa:stebbins/handbrake-releases)"
    echo "  * hydrogen (main)"
    echo "  * hydrogen-drumkits (main)"
    echo "  * hydrogen-drumkits-effects (main)"
    echo "  * kdenlive (main)"
    echo "  * lmms (main)"
    echo "  * musescore (ppa:mscore-ubuntu/mscore-stable)"
    echo "  * obs-studio (ppa:obsproject/obs-studio)"
    echo "  * qjackctl (main)"

    echo ""
    echo "Reference"
    echo "  * convertall (main)"
    echo "  * geogebra-classic (deb http://www.geogebra.net/linux/)"
    echo "  * gnome-dictionary (main)"
    echo "  * gnome-maps (main)"
    echo "  * kalzium (main)"
    echo "  * speedcrunch (main)"
    echo "  * stellarium (main)"
    echo "  * zegrapher (main)"
    
}

while getopts ":cdfgopruzhL" opt; do
    case $opt in
        c)
            echo "Core"
            install_core
            ;;
        d)
            echo "Development Tools"
            install_development
            ;;
        f)
            echo "Fun & Games"
            install_fun_games_full
            ;;
        g)
            echo "Graphics Design"
            install_graphics_design
            ;;
        o)
            echo "Office"
            install_office
            ;;
        p)
            echo "Audio/Video Production"
            install_production
            ;;
        r)
            echo "Reference & Education"
            install_reference
            ;;
        u)
            echo "Upgrades"
            install_upgrades
            ;;
        z)
            echo "Fun & Games (Puzzles Only)"
            ;;
        h)
            show_help
            ;;
        L)
            show_package_list
            ;;
        \?)
            echo "Invalid option."
            exit 1
            ;;
    esac
done
if [ $OPTIND -eq 1 ]
then
    echo "You must specify one or more options. See -h"
    exit
fi
