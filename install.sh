#!/bin/bash

#install_games() {
#    if command -v apt-get &> /dev/null; then
#        for i in $(apt-cache search dungeon | grep -iE "dungeon|game|rogue" | awk '{print $1}'); do
#            echo "============================================="
#            echo "$i"
#            sudo apt-get install -y "$i"
#        done
#        for i in $(apt-cache search rogue | grep -iE "dungeon|game|rogue" | awk '{print $1}');do
#            echo "============================================="
#            echo "$i"
#            sudo apt-get install -y "$i"
#        done
#    elif command -v pacman &> /dev/null; then
#        sudo pacman -S --needed --overwrite "*" --noconfirm yay angband asciiportal cataclysm-dda dwarffortress glhack nethack rogue stone-soup
#        if command -v yay &> /dev/null; then
#            yay -Syyu --needed --overwrite "*" tome4
#        fi
#    fi
#}

#install_draw() {
#    if command -v pacman &> /dev/null; then
#        sudo pacman -S --needed --overwrite "*" --noconfirm gimp inkscape krita
#    fi
#}
#
#install_audio() {
#    if command -v pacman &> /dev/null; then
#        sudo pacman -S --needed --overwrite "*" --noconfirm ardour audacity lmms mixxx non-sequencer qtractor rosegarden
#    fi
#}

#install_music() {
#    echo ""
#    echo "===================================="
#    echo "== install mpd and ncmpcpp config =="
#    echo "===================================="
#    echo ""
#    if command -v pacman &> /dev/null; then
#        sudo pacman -S --needed --overwrite "*" --noconfirm mpd ncmpcpp
#    fi
#
#    echo ""
#    echo "====================================="
#    echo "== Download mpd and ncmpcpp config =="
#    echo "====================================="
#    echo ""
#    curl -fLo ~/.config/mpd/mpd.conf --create-dirs \
#        https://gitlab.com/T6705/dotfiles/raw/master/.config/mpd/mpd.conf
#    curl -fLo ~/.config/ncmpcpp/config --create-dirs \
#        https://gitlab.com/T6705/dotfiles/raw/master/.config/ncmpcpp/config
#}

#install_spacemacs() {
#    if command -v apt-get &> /dev/null; then
#        sudo apt-get install -y emacs exuberant-ctags global pandoc python-pygments
#    elif command -v pacman &> /dev/null; then
#        sudo pacman -S --needed --overwrite "*" --noconfirm ctags emacs pandoc python-pygments
#    fi
#
#    if command -v npm &> /dev/null; then
#        npm install -g eslint js-beautify vmd
#    fi
#
#    if command -v go &> /dev/null; then
#        go get -u -v github.com/nsf/gocode
#        go get -u -v github.com/rogpeppe/godef
#        go get -u -v golang.org/x/tools/cmd/oracle
#        go get -u -v golang.org/x/tools/cmd/gorename
#        go get -u -v golang.org/x/tools/cmd/goimports
#    fi
#
#    echo ""
#    echo "======================="
#    echo "== install spacemacs =="
#    echo "======================="
#    echo ""
#    if [[ -d ~/.emacs.d ]]; then
#        cd ~/.emacs.d && time git pull
#    else
#        time git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
#    fi
#
#    echo ""
#    echo "==============================="
#    echo "== Download spacemacs config =="
#    echo "==============================="
#    echo ""
#    curl https://gitlab.com/T6705/dotfiles/raw/master/.spacemacs > ~/.spacemacs
#}

install_dependencies() {
    if command -v apt-get &> /dev/null; then
        sudo apt-get update
        sudo apt-get upgrade -y
        sudo apt-get dist-upgrade -y
        sudo apt-get autoremove -y
        sudo apt-get clean
        sudo apt-get install -y curl figlet fontconfig git glances htop lolcat npm ntp ntpdate ranger ruby-rouge time tmux vim vim-athena vim-gnome vim-gtk vim-nox xclip xsel zsh

        sudo curl "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy" > /usr/bin/diff-so-fancy
        sudo chmod +x /usr/bin/diff-so-fancy
    elif command -v pacman &> /dev/null; then
        sudo pacman-mirrors -f 0 && sudo pacman -Syy && sync
        sudo pacman -Syyu --noconfirm
        sudo pacman -S --needed --overwrite "*" --noconfirm base
        sudo pacman -S --needed --overwrite "*" --noconfirm base-devel
        sudo pacman -S --needed --overwrite "*" --noconfirm cower pacaur yay
        sudo pacman -S --needed --overwrite "*" --noconfirm bat code curl exa fd fontconfig git httpie hub iotop lsd meld npm ntp python-pip python2-pip ranger ripgrep ruby-rouge tig time tmux vim wmctrl wmctrl xclip xdotool xorg-xkill xorg-xkill xsel zsh
        sudo pacman -S --needed --overwrite "*" --noconfirm autoconf automake cmake libtool pkg-config unzip
        sudo pacman -S --needed --overwrite "*" --noconfirm compton diff-so-fancy figlet glances htop lolcat net-tools nnn screenfetch veracrypt xdg-utils
        sudo pacman -S --needed --overwrite "*" --noconfirm "$(pacman -Ssq numix) | grep -v gtk-theme-numix-solarized"
        sudo pacman -S --needed --overwrite "*" --noconfirm "$(pacman -Ssq papirus)"
        sudo pacman -S --needed --overwrite "*" --noconfirm "$(pacman -Ssq Matcha | grep theme)"
        sudo pacman -S --needed --overwrite "*" --noconfirm gnome-themes-maia maia-cursor-theme maia-icon-theme

        if command -v yay &> /dev/null; then
            yay -Syyu --needed --overwrite "*" cava dropbox dropbox-cli gitkraken hyperfine neofetch  secure-delete spotify
        fi
        if command -v pip2 &> /dev/null; then
            sudo pip2 install -U neovim
        fi
    fi

    if command -v pip3 &> /dev/null; then
        sudo pip3 install -U neovim
    fi

    if command -v diff-so-fancy &> /dev/null; then
        git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
    fi

    if command -v npm &> /dev/null && ! command -v pacman &> /dev/null; then
        sudo npm install npm@latest -g
    fi

    echo ""
    echo "========================="
    echo "== Download gtk config =="
    echo "========================="
    echo ""
    curl -fLo ~/.config/gtk-3.0/settings.ini --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/gtk-3.0/settings.ini
}

install_gnome() {
    echo ""
    echo "==================="
    echo "== install gnome =="
    echo "==================="
    echo ""
    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y $(apt-cache search dconf | awk '{print $1}' | grep -E "^dconf")
        sudo apt-get install -y curl gnome
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm curl dconf gnome
    fi

    echo ""
    echo "==========================="
    echo "== download gnome config =="
    echo "==========================="
    echo ""
    curl https://gitlab.com/T6705/dotfiles/raw/master/gnome.dconf > /tmp/gnome.dconf

    echo ""
    echo "======================="
    echo "== load gnome config =="
    echo "======================="
    echo ""
    if command -v dconf &> /dev/null; then
        dconf load / < /tmp/gnome.dconf
    fi
}

install_i3() {
    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y compton feh i3 i3 i3-wm i3-wm-dbg i3blocks i3lock i3lock-fancy i3status maim mpv rofi scrot snapd vlc

        sudo apt-get install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev

        echo ""
        echo "====================="
        echo "== install i3-gaps =="
        echo "====================="
        echo ""
        time mkdir -p ~/git/hub
        cd ~/git/hub
        rm -vrf i3-gaps

        # clone the repository
        time git clone https://www.github.com/Airblader/i3 i3-gaps
        cd i3-gaps

        # compile & install
        autoreconf --force --install
        rm -vrf build/
        time mkdir -p build && cd build/

        # Disabling sanitizers is important for release versions!
        # The prefix and sysconfdir are, obviously, dependent on the distribution.
        ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
        time make
        time sudo make install

        echo ""
        echo "====================="
        echo "== install polybar =="
        echo "====================="
        echo ""
        sudo apt-get install -y build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev

        time mkdir -p ~/git/hub
        cd ~/git/hub
        rm -vrf polybar
        time git clone --recursive https://github.com/jaagr/polybar
        cd polybar
        time ./build.sh

        echo ""
        echo "==========================="
        echo "== Download i3lock-fancy =="
        echo "==========================="
        echo ""
        time mkdir -p ~/git/hub
        cd ~/git/hub
        rm -vrf i3lock-fancy
        time git clone "https://github.com/meskarune/i3lock-fancy"
        cd ~/git/hub/i3lock-fancy
        sudo cp -v lock /usr/local/bin/
        sudo cp -r -v icons /usr/local/bin/

    elif command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm compton feh maim mpv playerctl qutebrowser rofi vlc

        echo ""
        echo "====================="
        echo "== install i3-gaps =="
        echo "====================="
        echo ""
        sudo pacman -S --needed --overwrite "*" --noconfirm i3-gaps i3lock i3-scrot

        echo ""
        echo "====================="
        echo "== install polybar =="
        echo "====================="
        echo ""
        sudo pacman -S --needed --overwrite "*" --noconfirm base-devel libmpdclient wireless_tools
        sudo pacman -S --needed --overwrite "*" --noconfirm "$(pacman -Ssq alsa | grep alsa)"
        if command -v yay &> /dev/null; then
            yay -Syyu
            yay -Syyu --needed --overwrite "*" polybar-git
        fi
        #time mkdir -p ~/git/hub
        #time git clone https://aur.archlinux.org/polybar-git.git ~/git/hub/polybar-git
        #cd ~/git/hub/polybar-git
        #makepkg -si

        echo ""
        echo "========================="
        echo "== Download flashfocus =="
        echo "========================="
        echo ""
        yay -Syyu --needed --overwrite "*" flashfocus-git

        echo ""
        echo "================================"
        echo "== Download flashfocus config =="
        echo "================================"
        echo ""
        curl -fLo ~/.config/flashfocus/flashfocus.yml --create-dirs https://gitlab.com/T6705/dotfiles/raw/master/.config/flashfocus/flashfocus.yml
    fi

    echo ""
    echo "========================"
    echo "== Download corrupter =="
    echo "========================"
    echo ""
    time mkdir -p ~/git/hub
    time git clone https://github.com/r00tman/corrupter ~/git/hub/corrupter
    time cd ~/git/hub/corrupter && time go build -o corrupter main.go

    echo ""
    echo "========================"
    echo "== Download i3 config =="
    echo "========================"
    echo ""
    curl -fLo ~/.config/i3/config --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/i3/config
    curl -fLo ~/.config/i3/i3blocks/i3blocks.conf --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/i3/i3blocks/i3blocks.conf
    curl -fLo ~/.config/i3/compton.conf --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/i3/compton.conf
    curl -fLo ~/.config/i3/scripts/i3lock.sh --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/i3/scripts/i3lock.sh
    curl -fLo ~/.config/i3/scripts/random_wallpaper.sh --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/i3/scripts/random_wallpaper.sh
    curl -fLo ~/.config/i3/scripts/start-term.sh --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/i3/scripts/start-term.sh
    curl -fLo ~/.config/i3/lock.png --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/i3/lock.png
    find ~/.config/i3 -type f -iname '*.sh' -exec chmod +x {} \;

    echo ""
    echo "============================="
    echo "== Download polybar config =="
    echo "============================="
    echo ""
    curl -fLo ~/.config/polybar/config --create-dirs https://gitlab.com/T6705/dotfiles/raw/master/.config/polybar/config
    curl -fLo ~/.config/polybar/config2 --create-dirs https://gitlab.com/T6705/dotfiles/raw/master/.config/polybar/config2
    curl -fLo ~/.config/polybar/config3 --create-dirs https://gitlab.com/T6705/dotfiles/raw/master/.config/polybar/config3
    curl -fLo ~/.config/polybar/scripts/bluetooth.sh --create-dirs https://gitlab.com/T6705/dotfiles/raw/master/.config/polybar/scripts/bluetooth.sh
    curl -fLo ~/.config/polybar/scripts/launch.sh --create-dirs https://gitlab.com/T6705/dotfiles/raw/master/.config/polybar/scripts/launch.sh
    curl -fLo ~/.config/polybar/scripts/logo.sh --create-dirs https://gitlab.com/T6705/dotfiles/raw/master/.config/polybar/scripts/logo.sh
    curl -fLo ~/.config/polybar/scripts/next.sh --create-dirs https://gitlab.com/T6705/dotfiles/raw/master/.config/polybar/scripts/next.sh
    curl -fLo ~/.config/polybar/scripts/playpause.sh --create-dirs https://gitlab.com/T6705/dotfiles/raw/master/.config/polybar/scripts/playpause.sh
    curl -fLo ~/.config/polybar/scripts/previous.sh --create-dirs https://gitlab.com/T6705/dotfiles/raw/master/.config/polybar/scripts/previous.sh
    curl -fLo ~/.config/polybar/scripts/spotify_p.sh --create-dirs https://gitlab.com/T6705/dotfiles/raw/master/.config/polybar/scripts/spotify_p.sh
    curl -fLo ~/.config/polybar/scripts/tor.sh --create-dirs https://gitlab.com/T6705/dotfiles/raw/master/.config/polybar/scripts/tor.sh
    chmod +x ~/.config/polybar/scripts/*.sh
    find ~/.config/polybar -type f -iname '*.sh' -exec chmod +x {} ;

    echo ""
    echo "================================="
    echo "== Download qutebrowser config =="
    echo "================================="
    echo ""
    curl -fLo ~/.config/qutebrowser/qutebrowser.conf --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/qutebrowser/qutebrowser.conf
}

install_dunst() {
    echo ""
    echo "==================="
    echo "== install dunst =="
    echo "==================="
    echo ""
    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y dunst notify-osd
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm dunst dunstify notify-osd
    fi

    echo ""
    echo "==========================="
    echo "== Download dunst config =="
    echo "==========================="
    echo ""
    curl -fLo ~/.config/dunst/Reload_dunst.sh --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/dunst/Reload_dunst.sh
    curl -fLo ~/.config/dunst/dunstrc --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/dunst/dunstrc
}

install_ibus() {
    echo ""
    echo "=================="
    echo "== install ibus =="
    echo "=================="
    echo ""
    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y ibus ibus-gtk ibus-gtk3 ibus-input-pad ibus-qt4 ibus-rime ibus-table ibus-table-cantonese ibus-table-cantonhk ibus-table-latex ibus-table-quick ibus-table-quick-classic ibus-table-quick3 ibus-table-quick5
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm curl ibus ibus-rime ibus-table ibus-table-chinese ibus-table-extraphrase libgusb libibus libusb libusbmuxd
    fi
    curl -fLo ~/.config/ibus/rime/default.custom.yaml --create-dirs https://gitlab.com/T6705/dotfiles/raw/master/.config/ibus/rime/default.custom.yaml
    curl https://gitlab.com/T6705/dotfiles/raw/master/.xinitrc > ~/.xinitrc
}

install_file_manager() {
    echo ""
    echo "=========================="
    echo "== install file manager =="
    echo "=========================="
    echo ""
    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y ranger

        sudo apt-get install -y vifm

        ################################
        # https://github.com/jarun/nnn #
        ################################
        sudo apt-get install -y nnn                              # terminal file manager
        sudo apt-get install -y atool patool                     # create, list and extract archives
        sudo apt-get install -y mediainfo libimage-exiftool-perl # multimedia file details
        sudo apt-get install -y moreutils                        # batch rename, move, delete dir entries

        ###########################
        # install all nnn plugins #
        ###########################
        curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm elinks ffmpegthumbnailer lynx odt2txt ranger w3m

        sudo pacman -S --needed --overwrite "*" --noconfirm vifm

        ################################
        # https://github.com/jarun/nnn #
        ################################
        sudo pacman -S --needed --overwrite "*" --noconfirm nnn                           # terminal file manager
        sudo pacman -S --needed --overwrite "*" --noconfirm atool                         # create, list and extract archives
        sudo pacman -S --needed --overwrite "*" --noconfirm mediainfo perl-image-exiftool # multimedia file details
        sudo pacman -S --needed --overwrite "*" --noconfirm moreutils                     # batch rename, move, delete dir entries

        ###########################
        # install all nnn plugins #
        ###########################
        curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs | sh
    fi

    echo ""
    echo "============================"
    echo "== Download ranger config =="
    echo "============================"
    echo ""
    curl -fLo ~/.config/ranger/rc.conf --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/ranger/rc.conf
    curl -fLo ~/.config/ranger/rifle.conf --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/ranger/rifle.conf
    curl -fLo ~/.config/ranger/scope.sh --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/ranger/scope.sh
    chmod +x ~/.config/ranger/scope.sh
}

install_tmux() {
    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y tmux
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm tmux
    fi

    echo ""
    echo "=================================="
    echo "== Download Tmux Plugin Manager =="
    echo "=================================="
    echo ""

    sudo rm -vrf ~/.tmux
    time git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    echo ""
    echo "=========================="
    echo "== Download tmux config =="
    echo "=========================="
    echo ""
    curl https://gitlab.com/T6705/dotfiles/raw/master/.tmux.conf > ~/.tmux.conf
    curl https://gitlab.com/T6705/dotfiles/raw/master/.tmux.conf.local > ~/.tmux.conf.local
}

install_vim() {
    echo ""
    echo "=================="
    echo "== build neovim =="
    echo "=================="
    echo ""

    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y autoconf automake cmake g++ gettext libtool libtool-bin ninja-build pkg-config python-pip python3-pip unzip
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm base-devel cmake go ninja npm unzip yay
    fi

    if [ -d ~/git/hub/neovim ]; then
        time cd ~/git/hub/neovim && time git pull
    else
        time mkdir -p ~/git/hub
        time cd ~/git/hub
        time git clone https://github.com/neovim/neovim
    fi

    time cd ~/git/hub/neovim
    time make CMAKE_BUILD_TYPE=RelWithDebInfo
    time sudo make install
    time nvim -v

    if command -v pip &> /dev/null; then
        sudo pip install -U neovim
    fi

    if command -v pip3 &> /dev/null; then
        sudo pip3 install -U neovim
    fi

    echo ""
    echo "============================================================="
    echo "== vim-anywhere (https://github.com/cknadler/vim-anywhere) =="
    echo "============================================================="
    echo ""
    curl -fsSL https://raw.github.com/cknadler/vim-anywhere/master/install | bash

    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y vim
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm cscope ctags prettier python-neovim
        sudo pip install -U vulture
    fi

    echo ""
    echo "========================"
    echo "== Download vim-plugs =="
    echo "========================"
    echo ""

    ### vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    ### nvim
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo ""
    echo "===================="
    echo "== Update Plugins =="
    echo "===================="
    echo ""

    curl https://gitlab.com/T6705/dotfiles/raw/master/visincr.vba > /tmp/visincr.vba

    if command -v npm &> /dev/null; then
        sudo npm -g install eslint
        sudo npm -g install instant-markdown-d
        sudo npm -g install tern
    fi

    if command -v vim &> /dev/null; then
        vim /tmp/visincr.vba +"so %" +qall
        vim +PlugUpdate
    fi

    if command -v nvim &> /dev/null; then
        nvim /tmp/visincr.vba +"so %" +qall
        nvim +PlugUpdate
    fi

    echo ""
    echo "============================="
    echo "== install Language server =="
    echo "============================="
    echo ""

    if command -v pacman &> /dev/null; then
        # for bash
        sudo pacman -S --needed --overwrite "*" --noconfirm bash-language-server

        # for c
        yay -Syyu --needed --overwrite "*" cquery

        # for go
        rm -vrf ~/git/hub/tools
        cd ~/git/hub/
        git clone -b bingo https://github.com/saibing/tools.git
        cd tools/gopls
        go install
    fi

    echo ""
    echo "=============================="
    echo "== Download vim/nvim config =="
    echo "=============================="
    echo ""
    curl -fLo ~/.config/nvim/augroups.vim --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/augroups.vim
    curl -fLo ~/.config/nvim/functions.vim --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/functions.vim
    curl -fLo ~/.config/nvim/general.vim --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/general.vim
    curl -fLo ~/.config/nvim/mappings.vim --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/mappings.vim
    curl -fLo ~/.config/nvim/plugins.vim --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/plugins.vim
    curl -fLo ~/.config/nvim/plugins_config.vim --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/plugins_config.vim
    curl -fLo ~/.config/nvim/coc-settings.json --create-dirs \
        https://gitlab.com/T6705/dotifles/raw/master/.config/nvim/coc-settings.json
    curl -fLo ~/.config/nvim/.ycm --create-dirs \
        https://gitlab.com/T6705/dotifles/raw/master/.config/nvim/.ycm_extra_conf.py

    ### vim
    curl https://gitlab.com/T6705/dotfiles/raw/master/.vimrc > ~/.vimrc

    ### nvim
    curl -fLo ~/.config/nvim/init.vim --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/init.vim

    reset
}

install_st() {
    echo ""
    echo "=================="
    echo "== git clone st =="
    echo "=================="
    echo ""
    if [ -d ~/git/hub/st ]; then
        time cd ~/git/hub/st && time git pull
    else
        time mkdir -p ~/git/hub
        time git clone git://git.suckless.org/st ~/git/hub/st
    fi

    echo ""
    echo "==================================="
    echo "== Download font and color patch =="
    echo "==================================="
    echo ""
    curl -fLo /tmp/font-and-color.patch --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/st/font-and-color.patch
    cd ~/git/hub/st && patch < /tmp/font-and-color.patch


    echo ""
    echo "============================"
    echo "== compile and install st =="
    echo "============================"
    echo ""
    make && sudo make install
}

install_terminal() {
    install_st
    if command -v pacman &> /dev/null; then
        echo ""
        echo "======================="
        echo "== install alacritty =="
        echo "======================="
        echo ""
        sudo pacman -S --needed --overwrite "*" --noconfirm alacritty alacritty-terminfo

        echo ""
        echo "==============================="
        echo "== Download alacritty config =="
        echo "==============================="
        echo ""
        curl -fLo ~/.config/alacritty/alacritty.yml --create-dirs \
            https://gitlab.com/T6705/dotfiles/raw/master/.config/alacritty/alacritty.yml

        echo ""
        echo "======================="
        echo "== install kitty =="
        echo "======================="
        echo ""
        sudo pacman -S --needed --overwrite "*" --noconfirm kitty

        echo ""
        echo "==========================="
        echo "== Download kitty config =="
        echo "==========================="
        echo ""
        curl -fLo ~/.config/kitty/kitty.conf --create-dirs \
            https://gitlab.com/T6705/dotfiles/raw/master/.config/kitty/kitty.conf
    fi
}

install_shell() {
    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y curl zsh
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm curl zsh
    fi

    echo ""
    echo "=========================="
    echo "== Download curl config =="
    echo "=========================="
    echo ""
    curl https://gitlab.com/T6705/dotfiles/raw/master/.curlrc > ~/.curlrc

    echo ""
    echo "=========================="
    echo "== Download bash config =="
    echo "=========================="
    echo ""
    curl https://gitlab.com/T6705/dotfiles/raw/master/.bashrc > ~/.bashrc

    echo ""
    echo "========================="
    echo "== Download zsh config =="
    echo "========================="
    echo ""
    curl https://gitlab.com/T6705/dotfiles/raw/master/.zshrc > ~/.zshrc
    curl -fLo ~/.zsh/aliases.zsh --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.zsh/aliases.zsh
    curl -fLo ~/.zsh/functions.zsh --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.zsh/functions.zsh

    echo ""
    echo "=============================="
    echo "== Download starship config =="
    echo "=============================="
    echo ""
    curl -fLo ~/.config/starship.toml --create-dirs \
        https://gitlab.com/T6705/dotfiles/raw/master/.config/starship.toml

    echo ""
    echo "====================================="
    echo "== Download zsh plugins and themes =="
    echo "====================================="
    echo ""

    if [[ -d ~/.oh-my-zsh ]]; then
        time cd ~/.oh-my-zsh && time git pull
    else
        time git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi

    time mkdir -p ~/.oh-my-zsh/custom/plugins

    if [[ -d ~/.oh-my-zsh/custom/plugins/alias-tips ]]; then
        time cd ~/.oh-my-zsh/custom/plugins/alias-tips && time git pull
    else
        time git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips
    fi

    if [[ -d ~/.oh-my-zsh/custom/plugins/k ]]; then
        time cd ~/.oh-my-zsh/custom/plugins/k && time git pull
    else
        time git clone https://github.com/supercrabtree/k ~/.oh-my-zsh/custom/plugins/k
    fi

    if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
        time cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && time git pull
    else
        time git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    fi

    if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]]; then
        time cd ~/.oh-my-zsh/custom/plugins/zsh-completions && time git pull
    else
        time git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
    fi

    if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
        time cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && time git pull
    else
        time git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    fi

    if [[ -d ~/.oh-my-zsh/custom/themes/spaceship-prompt ]]; then
        time cd ~/.oh-my-zsh/custom/themes/spaceship-prompt && time git pull
        if [[ ! -h ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme ]]; then
            ln -s ~/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme
        fi
    else
        time git clone https://github.com/denysdovhan/spaceship-prompt.git ~/.oh-my-zsh/custom/themes/spaceship-prompt
        ln -s ~/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme
    fi

    if command -v cargo &> /dev/null; then
        cargo install starship
    fi

    echo ""
    echo "========================"
    echo "== install hack fonts =="
    echo "========================"
    echo ""
    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y fonts-hack-otf fonts-hack-ttf fonts-hack-web
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm ttf-hack
    fi

    echo ""
    echo "========================"
    echo "== install fira fonts =="
    echo "========================"
    echo ""
    if command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm $(pacman -Ssq fira)
    fi

    echo ""
    echo "============================="
    echo "== install powerline fonts =="
    echo "============================="
    echo ""

    if [ -d /tmp/fonts ]; then
        time cd /tmp/fonts && time git pull
        time ./install.sh
    else
        time git clone https://github.com/powerline/fonts.git /tmp/fonts
        time /tmp/fonts/install.sh
    fi

    echo ""
    echo "========================"
    echo "== install Noto fonts =="
    echo "========================"
    echo ""

    if command -v apt-get &> /dev/null; then
        cd /tmp
        wget "https://noto-website.storage.googleapis.com/pkgs/Noto-hinted.zip"
        unzip Noto-hinted.zip
        time mkdir -p ~/.fonts
        cp -v ./*.otc ~/.fonts
        cp -v ./*.otf ~/.fonts
        cp -v ./*.ttf ~/.fonts
        fc-cache -f -v # optional
        sudo time mkdir -p /usr/share/fonts/opentype/noto
        sudo cp -v ./*.otc /usr/share/fonts/opentype/noto
        sudo cp -v ./*.otf /usr/share/fonts/opentype/noto
        sudo cp -v ./*.ttf /usr/share/fonts/opentype/noto
        sudo fc-cache -f -v # optional
    elif command -v pacman &> /dev/null; then
        for i in $(pacman -Ssq noto | grep -E ^noto); do sudo pacman -S --needed --overwrite "*" --noconfirm $i ; done
    fi

    echo ""
    echo "========================"
    echo "== install Nerd fonts =="
    echo "========================"
    echo ""
    if [ -d ~/git/hub/nerd-fonts ]; then
        time cd ~/git/hub/nerd-fonts && time git pull
        time ./install.sh FiraCode
        time ./install.sh Hack
        time ./install.sh JetBrainsMono
    else
        time mkdir -p ~/git/hub
        time git clone https://github.com/ryanoasis/nerd-fonts ~/git/hub/nerd-fonts
        time ~/git/hub/nerd-fonts/install.sh FiraCode
        time ~/git/hub/nerd-fonts/install.sh Hack
        time ~/git/hub/nerd-fonts/install.sh JetBrainsMono
    fi

    echo ""
    echo "======================="
    echo "== install powerline =="
    echo "======================="
    echo ""

    if command -v apt-get &> /dev/null; then
        sudo apt-get install fonts-powerline -y

        #https://github.com/milkbikis/powerline-shell
        #https://github.com/banga/powerline-shell

        #rm -vrf ~/powerline-shell
        #time git clone https://github.com/milkbikis/powerline-shell ~/powerline-shell
        #cd ~/powerline-shell
        #cp -v config.py.dist config.py
        #./install.py
        ##python ~/powerline-shell/install.py
        #ln -s ~/powerline-shell/powerline-shell.py ~/powerline-shell.py

        sudo pip install -U powerline-shell
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm fontforge powerline powerline-fonts
    fi

    echo ""
    echo "======================="
    echo "== install LS_COLORS =="
    echo "======================="
    echo ""
    # https://github.com/trapd00r/LS_COLORS
    wget https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O $HOME/.dircolors

    echo ""
    echo "================="
    echo "== install fzf =="
    echo "================="
    echo ""
    if [ -f ~/.fzf/install ]; then
        time cd ~/.fzf && time git pull
        time ~/.fzf/install
    else
        time git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        time ~/.fzf/install
    fi

    echo ""
    echo "================================================="
    echo "== install hub (https://github.com/github/hub) =="
    echo "================================================="
    echo ""
    if command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm hub
    elif command -v snap &> /dev/null; then
        snap install hub --classic
    fi

    echo ""
    echo "====================================================="
    echo "== install ccat (https://github.com/jingweno/ccat) =="
    echo "====================================================="
    echo ""
    if command -v pacman &> /dev/null; then
        sudo pacman -S --needed --overwrite "*" --noconfirm go
    elif command -v apt-get &> /dev/null; then
        sudo apt-get install -y golang
    fi
    if command -v go &> /dev/null; then
        export GOPATH=$HOME/go
        go get -u github.com/jingweno/ccat
        export PATH=$PATH:$GOPATH/bin
    fi

    echo ""
    echo "==================="
    echo "== install pyenv =="
    echo "==================="
    echo ""
    if [[ -d ~/.pyenv ]]; then
        time cd ~/.pyenv && time git pull
    else
        time git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    fi

    echo ""
    echo "=============================="
    echo "== install pyenv-virtualenv =="
    echo "=============================="
    echo ""
    if [[ -d ~/.pyenv/plugins/pyenv-virtualenv ]]; then
        time cd ~/.pyenv/plugins/pyenv-virtualenv && time git pull
    else
        time git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
    fi

    # If this user's login shell is not already "zsh", attempt to switch.
    TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
    if [[ "$TEST_CURRENT_SHELL" != "zsh" ]]; then
        # If this platform provides a "chsh" command (not Cygwin), do it, man!
        if command -v chsh &> /dev/null; then
            echo "Time to change your default shell to zsh!"
            chsh -s "$(grep /zsh$ /etc/shells | tail -1)"
            # Else, suggest the user do so manually.
        else
            echo "I can't change your shell automatically because this system does not have chsh."
            echo "Please manually change your default shell to zsh!"
        fi
    elif [[ "$TEST_CURRENT_SHELL" == "zsh" ]]; then
        . ~/.zshrc
    fi

    curl https://gitlab.com/T6705/dotfiles/raw/master/.xinitrc > ~/.xinitrc
    curl https://gitlab.com/T6705/dotfiles/raw/master/.Xresources > ~/.Xresources
    curl https://gitlab.com/T6705/dotfiles/raw/master/.nethackrc > ~/.nethackrc
}

install_de() {
    de=$1
    install_dependencies

    if [ $de == "i3" ]; then
        install_i3
    elif [ $de == "gnome" ]; then
        install_gnome
    fi

    install_terminal
    install_tmux
    install_vim
    install_shell
    install_dunst
    install_ibus
    install_file_manager
}

main() {
    # if no command line arg given
    if [ -z "$1" ]; then
        user_input="None"
    elif [ -n "$1" ]; then
        # otherwise make first arg as a rental
        user_input=$1
    fi

    case $user_input in
        "gnome") install_de gnome;;
        "i3")    install_de i3;;
        "None") echo "bash install.sh gnome/i3"
    esac
}

main "$1"
