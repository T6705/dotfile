###############
## functions ##
###############

# ---------------------------------------------------------------------
# usage: brightness <level> | adjust brightness
# # ---------------------------------------------------------------------
function brightness {
    if [ -n "$1" ]; then
        xrandr --output LVDS1 --brightness $1
    else
        echo "brightness <0-1>"
    fi
}

function 2display {
    # display screen information
    #xrandr
    # LVDS1 as primary monitor, HDMI1 right of LVDS1
    #xrandr --output LVDS1 --auto --primary --output HDMI1 --auto --right-of LVDS1
    connected_displays=`xrandr | grep " connected" | awk '{print $1}'`
    echo $connected_displays

    vared -p "main display : "  -c main
    vared -p "second display : " -c second

    [[ $connected_displays =~ "$main" ]] &&
        [[ $connected_displays =~ "$second" ]] &&
            [[ "$main" != "$second" ]] &&
                xrandr --output $main --auto --primary --output $second --auto --right-of $main
}

function mirrordisplay {
    connected_displays=`xrandr | grep " connected" | awk '{print $1}'`

    echo $connected_displays

    vared -p "main display : "  -c main
    vared -p "second display : " -c second

    [[ $connected_displays =~ "$main" ]] &&
        [[ $connected_displays =~ "$second" ]] &&
            [[ "$main" != "$second" ]] &&
                xrandr --output $main --auto --primary --output $second --auto --same-as $main

    #[[ $connected_displays =~ "$main" ]] && echo "1ok"
    #[[ $connected_displays =~ "$second" ]] && echo "2ok"
    #[[ "$main" != "$second" ]] && echo "3ok"
}

# ---------------------------------------------------------------------
# usage: ipv4_in <filename> | grep ipv4 in file
# ---------------------------------------------------------------------
function ipv4_in {
    if [ -n "$1" ]; then
        regex='([0-9]{1,3}\.){3}[0-9]{1,3}'
        grep -oE "$regex" $1
    else
        echo "'$1' is not a valid file"
    fi
}

# ---------------------------------------------------------------------
# usage: ipv6_in <filename> | grep ipv4 in file
# ---------------------------------------------------------------------
function ipv6_in {
    if [ -n "$1" ]; then
        regex='(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))'
        grep -oE "$regex" $1
    else
        echo "'$1' is not a valid file"
    fi
}

# ---------------------------------------------------------------------
# usage: url_in <filename> | grep url in file
# ---------------------------------------------------------------------
function url_in {
    if [ -n "$1" ]; then
        regex="(http[s]?|ftp|file)://[a-zA-Z0-9][a-zA-Z0-9_-]*(\.[a-zA-Z0-9][a-zA-Z0-9_-]*)*(:\d\+)?(\/[a-zA-Z0-9_/.\-+%?&=;@$,!''*~-]*)?(#[a-zA-Z0-9_/.\-+%#?&=;@$,!''*~]*)?"
        grep -oE "$regex" $1
    else
        echo "'$1' is not a valid file"
    fi
}

# -------------------------------------------------------------------
# Show how much RAM application uses.
# $ ram safari
# # => safari uses 154.69 MBs of RAM.
# from https://github.com/paulmillr/dotfiles
# -------------------------------------------------------------------
function ram {
    local sum
    local items
    local app="$1"
    if [ -z "$app" ]; then
        echo "First argument - pattern to grep from processes"
    else
        sum=0
        for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
            sum=$(($i + $sum))
        done
        sum=$(echo "scale=2; $sum / 1024.0" | bc)
        if [[ $sum != "0" ]]; then
            echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
        else
            echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
        fi
    fi
}

# ---------------------------------------------------------------------
# usage: extract <filename>
# ---------------------------------------------------------------------
function extract {
    echo Extracting $1 ...
    if [ -f $1 ] ; then
        case $1 in
            *.7z)       7z x $1       ;;
            *.Z)        uncompress $1 ;;
            *.bz2)      bunzip2 $1    ;;
            *.gz)       gunzip $1     ;;
            *.rar)      unrar x $1    ;;
            *.tar)      tar xvf $1    ;;
            *.tar.bz2)  tar xjvf $1   ;;
            *.tar.gz)   tar xzvf $1   ;;
            *.tar.xz)   tar xvf $1    ;;
            *.tbz2)     tar xjvf $1   ;;
            *.tgz)      tar xzvf $1   ;;
            *.zip)      unzip $1      ;;
            *)        echo "'$1' cannot be extracted via extract" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# ---------------------------------------------------------------------
# Usage: compress <file> (<type>)
# ---------------------------------------------------------------------
compress() {
    if [[ -e $1 ]]; then
        if [ $2 ]; then
            case $2 in
                bz2 | bzip2)    bzip2           $1                 ;;
                gpg)            gpg -e --default-recipient-self $1 ;;
                gz | gzip)      gzip $1                            ;;
                tar)            tar -cvf $1.$2  $1                 ;;
                tar.Z)          tar -Zcvf $1.$2 $1                 ;;
                tbz2 | tar.bz2) tar -jcvf $1.$2 $1                 ;;
                tgz | tar.gz)   tar -zcvf $1.$2 $1                 ;;
                zip)            zip -r $1.$2    $1                 ;;
                *)
                    echo "Error: $2 is not a valid compression type"
                    ;;
            esac
        else
            compress $1 tar.gz
        fi
    else
        echo "File ('$1') does not exist!"
    fi
}

# ---------------------------------------------------------------------
# usage: colours | print available colors and their numbers
# ---------------------------------------------------------------------
function colours {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}m colour${i}"
        if (( $i % 5 == 0 )); then
            printf "\n"
        else
            printf "\t"
        fi
    done
}
# ---------------------------------------------------------------------
# usage: base64key <keyname> <keysize>
# ---------------------------------------------------------------------
function base64key {
    if [[ ( -n $1 && -n $2 ) ]]; then
        keyname=$1
        size=$2
        openssl rand -base64 -out $keyname $size
    else
        echo "usage: base64key <keyname> <keysize>"
    fi
}

# ---------------------------------------------------------------------
# usage: rsakeypair <keyname> <keysize>
# ---------------------------------------------------------------------
function rsakeypair {
    if [[ ( -n $1 && -n $2 ) ]]; then
        pri=$1
        size=$2
        pub="$pri.pub"
        openssl genrsa -out $pri $size
        openssl rsa -in $pri -out $pub -outform PEM -pubout
    else
        echo "usage: rsakeypair <keyname> <keysize>"
    fi
}

# ---------------------------------------------------------------------
# usage: rsaencrypt <pubkey> <infile> <outfile>
# ---------------------------------------------------------------------
function rsaencrypt {
    if [[ ( -n $1 && -n $2 && -n $3) ]]; then
        pub=$1
        infile=$2
        outfile=$3
        openssl rsautl -encrypt -inkey $pub -pubin -in $infile -out $outfile
    else
        echo "usage: rsaencrypt <pubkey> <infile> <outfile>"
    fi
}

# ---------------------------------------------------------------------
# usage: rsadecrypt <prikey> <infile> <outfile>
# ---------------------------------------------------------------------
function rsadecrypt {
    if [[ ( -n $1 && -n $2 && -n $3) ]]; then
        pri=$1
        infile=$2
        outfile=$3
        openssl rsautl -decrypt -inkey $pri -in $infile -out $outfile
    else
        echo "usage: rsadecrypt <prikey> <infile> <outfile>"
    fi
}

# ---------------------------------------------------------------------
# usage: aesencrypt <infile> <outfile>
# ---------------------------------------------------------------------
function aesencrypt {
    if [[ ( -n $1 && -n $2 && -n $3 ) ]]; then
        infile=$1
        outfile=$2
        keyfile=$3
        #openssl aes-256-cbc -a -salt -in $infile -out $outfile -kfile $keyfile
        openssl enc -aes-256-cbc -a -salt -in $infile -out $outfile -pass file:$keyfile
    elif [[ ( -n $1 && -n $2 ) ]]; then
        infile=$1
        outfile=$2
        #openssl aes-256-cbc -a -salt -in $infile -out $outfile
        openssl enc -aes-256-cbc -a -salt -in $infile -out $outfile
    else
        echo "usage:"
        echo "aesencrypt <infile> <outfile>"
        echo "aesencrypt <infile> <outfile> <keyfile>"
    fi
}

# ---------------------------------------------------------------------
# usage: aesdecrypt <infile> <outfile>
# ---------------------------------------------------------------------
function aesdecrypt {
    if [[ ( -n $1 && -n $2 && -n $3 ) ]]; then
        infile=$1
        outfile=$2
        keyfile=$3
        #openssl aes-256-cbc -d -a -in $infile -out $outfile -kfile $keyfile
        openssl enc -aes-256-cbc -d -a -in $infile -out $outfile -pass file:$keyfile
    elif [[ ( -n $1 && -n $2 ) ]]; then
        infile=$1
        outfile=$2
        #openssl aes-256-cbc -d -a -in $infile -out $outfile
        openssl enc -aes-256-cbc -d -a -in $infile -out $outfile
    else
        echo "usage:"
        echo "aesdecrypt <infile> <outfile>"
        echo "aesdecrypt <infile> <outfile> <keyfile>"
    fi
}

function qutebrowser-install {
    sudo apt-get install -y python3-lxml python-tox python3-pyqt5 python3-pyqt5.qtwebkit python3-pyqt5.qtquick python3-sip python3-jinja2 python3-pygments python3-yaml
    sudo apt-get install -y python3-pyqt5 python3-pyqt5.qtwebkit python3-pyqt5.qtquick python-tox python3-sip python3-dev
    sudo apt-get install -y asciidoc source-highlight
    sudo apt-get install -y gstreamer1.0-plugins-{bad,base,good,ugly}
    time mkdir ~/git
    time rm -rf ~/git/qutebrowser
    time git clone https://github.com/qutebrowser/qutebrowser.git ~/git/qutebrowser
    time cd ~/git/qutebrowser
    time tox -e mkvenv-pypi
}

function qutebrowser-update {
    if [ -f ~/git/qutebrowser/.venv/bin/python3 ]; then
        time cd ~/git/qutebrowser && time git pull
        time tox -r -e mkvenv-pypi
    else
        qutebrowser-install
    fi
}

function qutebrowser {
    if [ -f ~/git/qutebrowser/.venv/bin/python3 ]; then
        ~/git/qutebrowser/.venv/bin/python3 -m qutebrowser "$@"
    else
        qutebrowser-install
        qutebrowser
    fi
}
