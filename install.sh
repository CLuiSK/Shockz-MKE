#!/bin/bash

blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
red="\e[0;31m\033[1m"
cyan="\e[0;36m\033[1m"

end="\033[0m\e[0m"

userPath=/home/shockz
rootPath=/root
file=$(readlink -f $0)
current_path=$(dirname $file)


# COSAS DE MI MKE = ZSHRC SCRIPTS

function user_shockz(){

    echo -e "${cyan} [*] Instalando dependencias ${end}"
    apt-get update && apt-get upgrade -y
    apt install build-essential git vim xcb libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev -y
    sudo apt update && sudo apt install cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev -y
    sudo apt update
    sudo apt install meson libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-glx0-dev -y
    # Instalacion de rofi
    sudo apt install rofi -y
    # Instalacion de firejail
    sudo apt install firejail -y
    # Instalacion de gnome-terminal
    sudo apt install gnome-terminal -y
    # Instalacion de FEH (wallpapers)
    sudo apt install feh -y
    # Instalacion de bspwm
    sudo apt install bspwm -y
    # Instalación de ranger
    sudo apt install ranger -y
    # Instalacion de scrub
    sudo apt install scrub
    # Instalando wmname
    sudo apt install wmname -y
    # Instalando xclip
    sudo apt install xclip -y


    # Disable sleep/suspend
    sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

    ### BSPWM y SXHKD
    echo -e "${cyan} [*] Descargando e instalando BSPWM y SXHKD ${end}"
    cd $userPath/Descargas
    git clone https://github.com/baskerville/bspwm.git
    git clone https://github.com/baskerville/sxhkd.git

    cd bspwm/ && make && sudo make install
    cd ../sxhkd/ && make && sudo make install

    # Instalacion de polybar
    echo -e "${cyan} [*] Instalando la polybar ${end}"
    cd $userPath/Descargas/
    git clone --recursive https://github.com/polybar/polybar
    cd polybar/
    mkdir build
    cd build/
    sudo cmake ..
    sudo make -j$(nproc)
    sudo make install

    # Instalacion de picom
    echo -e "${cyan} [*] Instalando picom ${end}"
    cd $userPath/Descargas && git clone https://github.com/ibhagwan/picom.git
    cd picom/ && git submodule update --init --recursive
    meson --buildtype=release . build
    ninja -C build
    sudo ninja -C build install

    # Instalacion de hackfonts
    echo -e "${cyan} [*] Instalando HackNet Fonts ${end}"
    cd /usr/local/share/fonts && sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip && sudo unzip Hack.zip
    sudo rm Hack.zip

    # wallpapers
    echo -e "${cyan} [*] Configurando el wallpaper ${end}"
    mkdir $userPath/Escritorio/wallpaper
    cp $current_path/wallpaper/wallpaper.png $userPath/Escritorio/wallpaper/fondo.png

    echo -e "${cyan} [*] Copiando archivos de configuracion ${end}"
    sudo cp -r $current_path/config/* $userPath/.config/
    # Si se va usar root como user en login
    #sudo cp -r $current_path/config /root/.config
    chown -R shockz:shockz $userPath/.config
    chmod +x $userPath/.config/bspwm/bspwmrc
    chmod +x $userPath/.config/bspwm/scripts/bspwm_resize

    # Fuentes polybar
    echo -e "${cyan} [*] Estableciendo las fuentes para la polybar ${end}"
    cd $userPath/Descargas && git clone https://github.com/VaughnValle/blue-sky.git
    cd blue-sky/polybar/fonts
    sudo cp * /usr/share/fonts/truetype/
    fc-cache -v
    cd $userPath
    # Eliminamos el repo
    rm -r $userPath/Descargas/blue-sky

    # Permisos de ejecucion a scripts de polybar
    echo -e "${cyan} [*] Dando permisos a los scripts del entorno ${end}"
    chmod +x $userPath/.config/bin/*
    chmod +x $userPath/.config/polybar/scripts/powermenu_alt

    # Lock
    #sudo apt update
    #echo "Seleccionar slim"
    #sudo apt install slim libpam0g-dev libxrandr-dev libfreetype6-dev libimlib2-dev libxft-dev -y 
    #cd $userPath/Descargas/
    #git clone https://github.com/joelburget/slimlock.git
    #cd slimlock/ && sudo make && sudo make install
    #cd $userPath/Descargas/blue-sky/slim
    #sudo cp slim.conf /etc/
    #sudo cp slimlock.conf /etc
    #sudo cp -r default /usr/share/slim/themes


    # POWERLEVEL 10K
    echo -e "${cyan} [*] Instalando y configurando powerlevel10k ${end}"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $userPath/powerlevel10k
    # Copia de zshrc y .p10.zsh
    sudo cp $current_path/zshrc $userPath/.zshrc
    sudo cp $current_path/p10k.zsh $userPath/.p10k.zsh

    # Plugins zsh
    echo -e "${cyan} [*] Instalancion de plugins zsh ${end}"
    # Instalacion de bat = cat mejorado
    echo -e "${cyan} [**] Instalando bat ${end}"
    cd $userPath
    wget "https://github.com/sharkdp/bat/releases/download/v0.18.2/bat-musl_0.18.2_amd64.deb"
    sudo dpkg -i bat-musl_0.18.2_amd64.deb
    rm bat-musl_0.18.2_amd64.deb

    # Instalacion de lsd : listado inteligente
    echo -e "${cyan} [**] Instalando lsd ${end}"
    wget "https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd-musl_0.20.1_amd64.deb"
    sudo dpkg -i lsd-musl_0.20.1_amd64.deb
    rm lsd-musl_0.20.1_amd64.deb

    # Instalacion de fzf: autocompletado
    echo -e "${cyan} [**] Instalando fzf ${end}"
    git clone --depth 1 https://github.com/junegunn/fzf.git $userPath/.fzf
    chown -R shockz:shockz $userPath/.fzf
    su shockz -c "$userPath/.fzf/install"

    sudo cp -r $current_path/zsh-plugins /usr/share/ && chown shockz:shockz /usr/share/zsh-plugins

}

function user_root(){

    echo -e "${cyan} [*] Instalando y configurando powerlevel10k para el user root${end}"
    # Powerlevel 10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $rootPath/powerlevel10k
    sudo cp $current_path/p10k.zsh $rootPath/.p10k.zsh

    # Link simbolico a la zshrc del user shockz
    ln -s -f $userPath/.zshrc $rootPath/.zshrc

    # Para otro SO que no sea Kali (default:zsh)
    #usermod --shell /usr/bin/zsh shockz
    #usermod --shell /usr/bin/zsh root

    # Fixing de problemas migracion a users desde root
    chown shockz:shockz /root
    chown shockz:shockz /root/.cache -R
    chown shockz:shockz /root/.local -R

    echo -e "${cyan} [*] Instalando fzf para root ${end}"
    # FZF autocompletado
    git clone --depth 1 https://github.com/junegunn/fzf.git $rootPath/.fzf
    $rootPath/.fzf/install

}

function custom(){
    echo -e "${cyan} [*] Aplicando cambios a nivel de sistema ${end}"
    # Teclado español
    sudo setxkbmap -layout 'es,es' -model pc105

    # Firefox + Firejail
    # Permisos para futuras herramientas
    chown shockz:shockz /opt
    # descargar firefox, muevo a opt y instalo firefox
    #firejail /opt/firefox
    # Configurar foxyproxy y poner duckduckgo

    # Fixing burpsuite
    update-alternatives --config java

    echo -e "${cyan} [*] Copiando custom scripts ${end}"
    # Script para habilitar copy-paste en vmware
    sudo cp $current_path/scripts/copy_paste.sh $userPath/.config/bin/
    chmod +x $userPath/.config/bin/copy_paste.sh && chown shockz:shockz $userPath/.config/bin/copy_paste.sh

    # Script tty
    sudo cp $current_path/scripts/tty.sh $userPath/.config/bin/
    chmod +x $userPath/.config/bin/tty.sh && chown shockz:shockz $userPath/.config/bin/tty.sh

    # Configuracion SSH
    echo -e "${cyan}[+] Aplicando configuracion ssh${end}"
    sudo apt-get install openssh-server openssh-client -y
    ##con awk port 22 para habilitar ssh /etc/ssh/sshd_config si es necesario
    sudo systemctl enable ssh
    sudo systemctl restart ssh

    # Diccionarios
    echo -e "${cyan}[+] Extrayendo rockyou${end}"
    gunzip /usr/share/wordlists/rockyou.txt.gz
    sudo apt-get install lftp -y
    wordlist_path=$current_path/wordlists
    
    # Fixing first 13 lines of fuzzing dic
    sudo sed -i '1,13d' /usr/share/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-medium.txt

    echo -e "${purple}[+] Deseas instalar Kaonashi? [y/n]${end}"
    read option

    if [[ $option == "y" ]];then
        echo -e "${cyan}[+] Instalando Kaonashi${end}"
        sudo lftp -c "torrent $wordlist_path/kaonashi14M.7z.torrent $wordlist_path/kaonashiWPA100M.7z.torrent $wordlist_path/kaonashi.7z.torrent"
        sudo mkdir /usr/share/wordlists/kaonashi
        sudo mv  $userPath/kaonashi14M.7z  $userPath/kaonashiWPA100M.7z  $userPath/kaonashi.7z /usr/share/wordlists/kaonashi
        cd /usr/share/wordlists/kaonashi && 7z x ./kaonashi14M.7z && 7z x ./kaonashiWPA100M.7z && 7z x ./kaonashi.7z && rm kaonashi14M.7z kaonashiWPA100M.7z kaonashi.7z
        echo -e "${cyan}[+] Copiando otras wordlists ${end}"
    fi

    sudo cp $wordlist_path/pwned-passwords-sha1-ordered-by-count-v7.7z.torrent /usr/share/wordlists/
    echo -e "${cyan}[+] Configurando actualizaciones automaticas en boot ${end}"
    sudo apt install unattended-upgrades -y && dpkg-reconfigure --priority=low unattended-upgrades
    #echo -e "${cyan}[+] Instalando ufw ${end}"
    #sudo apt install ufw -y
    #sudo sudo ufw enable
    # Copiando los drivers y scripts para la configuración del adaptador de red wifi
    echo -e "${cyan}[+] Copiando los drivers y scripts para la configuración del adaptador de red wifi ${end}"
    cp $current_path/TP_LINK_ADAPTER.zip $userPath
    cd $userPath && unzip TP_LINK_ADAPTER.zip && rm TP_LINK_ADAPTER.zip
    echo -e "${cyan}[+] Instalando herramientas wifi ${end}"
    # wifite
    # dos2unix

    #Instalación de hcxtools
    echo -e "${cyan}[+] Instalando hcxtools ${end}"
    sudo apt install hcxtools -y
    #Instalación de airgeddon
    echo -e "${cyan}[+] Instalando airgeddon ${end}"
    cd /usr/bin && sudo git clone https://github.com/v1s1t0r1sh3r3/airgeddon
    #Instalacion ciphey
    python3 -m pip install ciphey --upgrade
    # Instalacion VS Code
    echo -e "${cyan}[+] Instalando VS Code ${end}"
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    sudo apt-get update && \
    sudo apt install code code-insiders

    echo -e "${cyan}[+] Instalando SecLists ${end}"
    # Instalacion seclists
    sudo apt install seclists -y

    echo -e "${cyan}[+] Instalando Remmina ${end}"
    # Instalacion remmina
    sudo apt install remmina -y
	
    echo -e "${cyan}[+] Instalando neofetch ${end}"
    # Instalacion neofetch
    sudo apt install neofetch -y

    echo -e "${cyan}[+] Instalando steghide ${end}"
    # Instalacion steghide
    apt install steghide -y

    echo -e "${cyan}[+] Instalando haiti ${end}"
    # Instalacion haiti
    gem install haiti-hash

    echo -e "${cyan}[+] Instalando rlwrap ${end}"
    # Instalacion rlweap
    sudo apt install rlwrap -y

    echo -e "${cyan}[+] Instalando shellcheck ${end}"
    # Instalacion shellcheck    
    sudo apt-get install shellcheck -y

    # Instalacion autorecon    
    cd /usr/bin && sudo git clone https://github.com/Tib3rius/AutoRecon && cd -

    echo -e "${cyan}[+] Instalando rustscan ${end}"
    # Instalacion de rustscan
    wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb
    sudo dpkg -i rustscan_2.0.1_amd64.deb
    rm rustscan_2.0.1_amd64.deb

    echo -e "${cyan}[+] Instalando play ${end}"
    # Instalacion play    
    sudo apt install sox -y
    sudo apt install libsox-fmt-mp3 -y

    echo -e "${cyan}[+] Instalando audacity ${end}"
    # Instalacion audacity    
    sudo apt install audacity -y


    # Instalacion de scrot
    echo -e "${cyan}[+] Instalando scrot ${end}"
    sudo apt-get install scrot -y

    # Instalacion go y ffuf
    echo -e "${cyan}[+] Instalando go y ffuf ${end}"
    sudo apt install golang -y
    git clone https://github.com/ffuf/ffuf ; cd ffuf ; go get ; go build ; cd .. ; rm -r ffuf

    # Sudo sin requerir passwd
    # apt-get install kali-grant-root && dpkg-reconfigure kali-grant-root

    # AWS Cli
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    sudo rm -r aws && sudo rm awscliv2.zip


    echo -e "${cyan}[+] Limpiando... ${end}"
    # Limpieza de directorios
    sudo rm -r $userPath/Descargas/*
}


# https://patorjk.com/software/taag/#p=display&h=0&f=Delta%20Corps%20Priest%201&t=Shockz%20MKE
echo -e "

   ▄████████    ▄█    █▄     ▄██████▄   ▄████████    ▄█   ▄█▄  ▄███████▄          ▄▄▄▄███▄▄▄▄      ▄█   ▄█▄    ▄████████ 
  ███    ███   ███    ███   ███    ███ ███    ███   ███ ▄███▀ ██▀     ▄██       ▄██▀▀▀███▀▀▀██▄   ███ ▄███▀   ███    ███ 
  ███    █▀    ███    ███   ███    ███ ███    █▀    ███▐██▀         ▄███▀       ███   ███   ███   ███▐██▀     ███    █▀  
  ███         ▄███▄▄▄▄███▄▄ ███    ███ ███         ▄█████▀     ▀█▀▄███▀▄▄       ███   ███   ███  ▄█████▀     ▄███▄▄▄     
▀███████████ ▀▀███▀▀▀▀███▀  ███    ███ ███        ▀▀█████▄      ▄███▀   ▀       ███   ███   ███ ▀▀█████▄    ▀▀███▀▀▀     
         ███   ███    ███   ███    ███ ███    █▄    ███▐██▄   ▄███▀             ███   ███   ███   ███▐██▄     ███    █▄  
   ▄█    ███   ███    ███   ███    ███ ███    ███   ███ ▀███▄ ███▄     ▄█       ███   ███   ███   ███ ▀███▄   ███    ███ 
 ▄████████▀    ███    █▀     ▀██████▀  ████████▀    ███   ▀█▀  ▀████████▀        ▀█   ███   █▀    ███   ▀█▀   ██████████ 
                                                    ▀                                             ▀                      
"

#Se comprueban los privilegios
[ "$(id -u)" -ne 0 ] && (echo -e "${red} [!] Este script debe ejecutarse con privilegios root ${end}" >&2) && exit 1;

user_shockz
user_root
custom

echo -e "${purple}[+] FINALIZADA ${end}"
