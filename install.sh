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
    #sudo apt install firejail -y
    # Instalacion de gnome-terminal
    sudo apt install gnome-terminal -y
    # Instalacion de bspwm
    sudo apt install bspwm -y
    # Instalacion feh
    sudo apt install feh -y
    # Instalacion de picom
    echo -e "${cyan} [*] Instalando picom ${end}"
    cd $userPath/Descargas && git clone https://github.com/yshui/picom.git
    cd picom/ && git submodule update --init --recursive
    meson --buildtype=release . build
    ninja -C build
    sudo ninja -C build install
    cd - && rm -r picom


    ### BSPWM y SXHKD
    echo -e "${cyan} [*] Descargando e instalando BSPWM y SXHKD ${end}"
    cd $userPath/Descargas
    git clone https://github.com/baskerville/bspwm.git
    git clone https://github.com/baskerville/sxhkd.git

    cd bspwm/ && make && sudo make install
    cd ../sxhkd/ && make && sudo make install

    # Instalacion de scrub
    sudo apt install scrub
    # Instalando wmname
    sudo apt install wmname -y
    # Instalando xclip
    sudo apt install xclip -y

    # Disable sleep/suspend
    sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

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

    # Instalacion de hackfonts
    echo -e "${cyan} [*] Instalando HackNet Fonts ${end}"
    cd /usr/local/share/fonts && sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip && sudo unzip Hack.zip
    sudo rm Hack.zip

    # wallpapers
    echo -e "${cyan} [*] Configurando el wallpaper ${end}"
    cp -r $current_path/wallpapers $userPath/Escritorio

    echo -e "${cyan} [*] Copiando archivos de configuracion ${end}"
    sudo cp -r $current_path/config/* $userPath/.config
    # Si se va usar root como user en login
    #sudo cp -r $current_path/config /root/.config
    chown -R shockz:shockz $userPath/.config

    #chmod +x $userPath/.config/bspwm/bspwmrc
    #chmod +x $userPath/.config/bspwm/scripts/bspwm_resize

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
    #echo -e "${cyan} [*] Dando permisos a los scripts del entorno ${end}"
    #chmod +x $userPath/.config/bin/*
    #chmod +x $userPath/.config/polybar/scripts/powermenu_alt
    # DEBERIA LLEGAR CON EL ANTERIOR 

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

    sudo cp -r $current_path/zsh-plugins /usr/share/ && chown -R shockz:shockz /usr/share/zsh-plugins

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

    # tools
    echo -e "${cyan} [*] Copiando enum_priv_esc_tools ${end}"
    unzip $current_path/priv_esc_tools.zip -d $userPath

    # Configuracion SSH
    echo -e "${cyan}[+] Aplicando configuracion ssh${end}"
    sudo apt-get install openssh-server openssh-client -y
    ##con awk port 22 para habilitar ssh /etc/ssh/sshd_config si es necesario
    sudo systemctl enable ssh
    sudo systemctl restart ssh

    #------ Diccionarios  ------#
    echo -e "${cyan}[+] Extrayendo rockyou${end}"
    gunzip /usr/share/wordlists/rockyou.txt.gz
    rm /usr/share/wordlists/rockyou.txt.gz
    sudo apt-get install lftp -y
    wordlist_path=$current_path/wordlists
    
    echo -e "${cyan}[+] Instalando SecLists ${end}"
    # Instalacion seclists
    sudo apt install seclists -y

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

    echo -e "${cyan}[+] Instalando pip2 ${end}"
    sudo apt install python-pip -y

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
    sudo apt install code code-insiders -y

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
    ## Dependencias
    sudo apt install feroxbuster gobuster nbtscan oscanner redis-tools snmp sslscan sipvicious tnscmd10g wkhtmltopdf -y

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


    # Sudo sin requerir passwd
    echo -e "${cyan}[+] Instalando grantroot ${end}"
    apt-get install kali-grant-root && dpkg-reconfigure kali-grant-root

    # AWS Cli
    echo -e "${cyan}[+] Instalando aws cli ${end}"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    sudo rm -r aws && sudo rm awscliv2.zip

    # Docker
    echo -e "${cyan}[+] Instalando docker ${end}"
    sudo apt install docker.io -y
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    # Impacket
    echo -e "${cyan}[+] Instalando impacket ${end}"
    sudo apt-get install python3-pip -y
    git clone https://github.com/SecureAuthCorp/impacket.git
    cd impacket
    pip3 install .
    cd - && sudo rm -r impacket
    
    # SMTP enum
    echo -e "${cyan}[+] Instalando smtp enum ${end}"
    sudo apt install smtp-user-enum -y
	
    #SShuttle
    echo -e "${cyan}[+] Instalando sshuttle ${end}"
    apt-get install sshuttle -y
    
    # Tor y Proxychains
    echo -e "${cyan}[+] Instalando tor, proxychains ${end}"
    sudo apt install tor proxychains -y
    
    # MDK3
    echo -e "${cyan}[+] Instalando mdk3 ${end}"
    sudo apt-get install mdk3 -y

    
    # One list for all web
    echo -e "${cyan}[+] Instalando OneList4All ${end}"
    cd /usr/share/ && sudo git clone https://github.com/six2dez/OneListForAll && cd OneListForAll && 7z x onelistforall.7z.001 && cd /home/shockz

    # APKTOOL/Zipalign/jarsigner
    echo -e "${cyan}[+] Instalando Apktool/Zipalign/jarsigner ${end}"
    sudo apt-get install apktool -y
    sudo apt-get install openjdk-11-jdk -y
    sudo apt-get install zipalign -y

    # ysoserial
    echo -e "${cyan}[+] Instalando ysoserial ${end}"
    wget https://jitpack.io/com/github/frohoff/ysoserial/master-SNAPSHOT/ysoserial-master-SNAPSHOT.jar && mkdir /opt/ysoserial && mv ysoserial-master-SNAPSHOT.jar /opt/ysoserial/ysoserial.jar

	# RLWRAP
    echo -e "${cyan}[+] Instalando rlwrap ${end}"
	sudo apt install rlwrap -y
	
	# MITM6
    echo -e "${cyan}[+] Instalando mitm6 ${end}"
	git clone https://github.com/dirkjanm/mitm6.git
	cd mitm6
	python3 -m pip install -r requirements.txt
	python3 setup.py install
	cd - && sudo rm -r mitm6/
	
	# ldapdomaindump
    echo -e "${cyan}[+] Instalando ldapdomaindump ${end}"
	git clone https://github.com/dirkjanm/ldapdomaindump.git
	cd ldapdomaindump
	python3 -m pip install ldap3 dnspython future
	python3 setup.py install
    cd - && rm -r ldapdomaindump
	
	# Evil-winrm
    echo -e "${cyan}[+] Instalando Evil-winrm ${end}"
	sudo gem install winrm winrm-fs stringio
	git clone https://github.com/Hackplayers/evil-winrm.git
	mv evil-winrm /usr/bin/
    chmod +x /usr/bin/evil-winrm
	
	# shcheck.py
    echo -e "${cyan}[+] Instalando shcheck ${end}"
    pip3 install shcheck

    # testssl
    echo -e "${cyan}[+] Instalando testssl ${end}"
    sudo apt install testssl.sh -y
	
    ##--Subdomains OSINT Threat Intelligence--#

    # aquatone
    echo -e "${cyan}[+] Instalando Aquatone ${end}"
    wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip && mkdir aquatone && unzip aquatone_linux_amd64_1.7.0.zip -d aquatone
    mv aquatone/aquatone /usr/local/bin/ && rm -r aquatone*

    # JQ
    echo -e "${cyan}[+] Instalando JQ ${end}"
    sudo apt install jq -y

    # CTFR
    echo -e "${cyan}[+] Instalando CTFR ${end}"
    git clone https://github.com/UnaPibaGeek/ctfr.git && pip3 install -r ctfr/requirements.txt && chmod +x ctfr/ctfr.py && mv ctfr/ctfr.py /usr/local/bin/ && sudo rm -r ctfr

    # prips
    echo -e "${cyan}[+] Instalando Prips ${end}"
    git clone https://github.com/honzahommer/prips.sh.git && prips.sh/install.sh /usr/local && sudo rm -r prips.sh

    ##Spiderfoot
    echo -e "${cyan}[+] Instalando Spiderfoot ${end}"
    git clone https://github.com/smicallef/spiderfoot.git
    pip3 install -r spiderfoot/requirements.txt
    mv spiderfoot /opt/

    # MEGA TOOLS
    echo -e "${cyan}[+] Instalando Megatools ${end}"
    sudo apt install megatools
    echo -e "${cyan}[+] Descomprimiendo data ${end}"
    sudo apt install megatools -y
    megadl --path . $(echo "aHR0cHM6Ly9tZWdhLm56L2ZpbGUvQUJCaWhKaUIjdlFtYUFTZGJUTnNQSlA1ajlodVpMSGQyc2g0VV9wZU54MTFsc0QwVkNnWQo=" | base64 -d)
    sudo apt install p7zip-full -y
    7z x Data.7z
    while [ $? -ne 0 ]; do
        7z x Data.7z
    done
    # BurpSuite pro/ burpbounty
    echo -e "${cyan}[+] Instalando Burpsuite Pro & BurpBounty ${end}"
    mv Data/BurpPro /opt
    ##dump in /opt, follow txt, open burp, open activator, copy license from activator, and manual activate, copy and paste.

    ###### GO TOOLS #####
    echo -e "${cyan}[+] Descargando go${end}"
    # Instalacion de go
    version=$(curl -L -s https://golang.org/VERSION?m=text)
    wget https://dl.google.com/go/${version}.linux-amd64.tar.gz
    tar -C /usr/local -xzf ${version}.linux-amd64.tar.gz
    ln -sf /usr/local/go/bin/go /usr/local/bin/
    rm -rf $version*
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/go
    export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH

    # reconftw y multiples tools de go para bugbounty
    echo -e "${cyan}[+] Descargando reconftw y multiples tools de go para bugbounty${end}"
    git clone https://github.com/six2dez/reconftw.git
    cd reconftw/
    su shockz -c "./install.sh"
    cd -

    # Instalacion go y ffuf
    # echo -e "${cyan}[+] Instalando go y ffuf ${end}"
    # sudo apt install golang -y
    # git clone https://github.com/ffuf/ffuf ; cd ffuf ; go get ; go build ; cd .. ; rm -r ffuf

    # subfinder
    echo -e "${cyan}[+] Instalando Subfinder ${end}"
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

    # git clone https://github.com/projectdiscovery/subfinder.git
    # cd subfinder/v2/cmd/subfinder
    # go build
    # mv subfinder /usr/local/bin/
    # cd -
    # sudo rm -r subfinder
    
    # ipinfo
    echo -e "${cyan}[+] Descargando ipinfo ${end}"
    go install -v github.com/ipinfo/cli/ipinfo@latest

    # git clone https://github.com/ipinfo/cli ipinfo-cli
    # cd ipinfo-cli
    # sudo go build -o /usr/local/bin/ ./ipinfo/
    # cd -
    # sudo rm -r ipinfo-cli


    echo -e "${cyan}[+] Configurando apis de subfinder, amass y spiderfoot y ysoserial txt ${end}"
    mv Data/ysoserial_payloaders /opt
    # mover subfinder api
    subfinder
    mv Data/apis/subfinder.yaml /root/.config/subfinder/provider-config.yaml
    mv Data/apis/amass /home/shockz/.config/amass
    mv Data/apis/spiderfoot /home/shockz/.config/spiderfoot
    mv Data/apis/api-keys.yaml /etc/theHarvester/api-keys.yaml
    mv Data/apis/reconftw.cfg /home/shockz/reconftw/reconftw.cfg

    # freq,gf,waybackurls,airixss,qsreplace
    #echo -e "${cyan}[+] Instalando freq,gf,waybackurls,airixss,qsreplace ${end}"
    echo -e "${cyan}[+] Instalando freq,airixss,gau ${end}"
    go install -v github.com/takshal/freq@latest
    go install -v github.com/ferreiraklet/airixss@latest

    #go get -u github.com/tomnomnom/gf
    #go get -u github.com/tomnomnom/waybackurls
    #go get -u github.com/tomnomnom/qsreplace
    #sudo mv go/bin/* /usr/local/bin/
    #sudo rm -r go

    # # amass
    # echo -e "${cyan}[+] Instalando Amass ${end}"
    # wget https://github.com/OWASP/Amass/releases/download/v3.17.1/amass_linux_amd64.zip && unzip amass_linux_amd64.zip && mv amass_linux_amd64/amass /usr/local/bin/
    # sudo rm -r amass_linux_amd64*

    # # Gotator
    # echo -e "${cyan}[+] Instalando Gotator ${end}"
    # git clone https://github.com/Josue87/gotator.git
    # cd gotator
    # go build
    # mv gotator /usr/local/bin/
    # cd -
    # sudo rm -r gotator

    # # Gospider
    # echo -e "${cyan}[+] Instalando Gospider ${end}"
    # git clone https://github.com/jaeles-project/gospider.git
    # cd gospider
    # go build
    # mv gospider /usr/local/bin/
    # cd -
    # sudo rm -r gospider

    # # unfurl
    # echo -e "${cyan}[+] Instalando Unfurl ${end}"
    # wget https://github.com/tomnomnom/unfurl/releases/download/v0.0.1/unfurl-linux-amd64-0.0.1.tgz
    # tar xzf unfurl-linux-amd64-0.0.1.tgz
    # sudo mv unfurl /usr/bin/
    # rm unfurl-linux-amd64-0.0.1.tgz

    # # Nuclei update
    # echo -e "${cyan}[+] Configuración nuclei ${end}"
    # sudo apt install nuclei
    # nuclei

    # # DNSX
    # echo -e "${cyan}[+] Instalando DNSX ${end}"
    # git clone https://github.com/projectdiscovery/dnsx.git
    # cd dnsx/cmd/dnsx
    # go build
    # mv dnsx /usr/local/bin/ 
    # cd -
    # sudo rm -r dnsx
    # # HTTPX
    # echo -e "${cyan}[+] Instalando HTTPX ${end}"
    # git clone https://github.com/projectdiscovery/httpx.git
    # cd httpx/cmd/httpx
    # go build
    # mv httpx /usr/local/bin/
    # cd -
    # sudo rm -r httpx

    # gf patterns
    #git clone https://github.com/1ndianl33t/Gf-Patterns
    #mkdir /home/shockz/.gf
    #mv /home/shockz/Gf-Patterns/*.json /home/shockz/.gf

    # anew
    #echo -e "${cyan}[+] Descargando anew ${end}"
    #git clone https://github.com/tomnomnom/anew.git
    #cd anew
    #go build
    #chmod +x anew
    # sudo mv anew /usr/local/bin/ 
    # cd -
    # sudo rm -r anew

    # # gau
    # echo -e "${cyan}[+] Descargando gau ${end}"
    # git clone https://github.com/lc/gau.git
    # cd gau/cmd/gau
    # go build
    # chmod +x gau
    # sudo mv gau /usr/local/bin/ 
    # cd -
    # sudo rm -r gau

    ############################

    # uro
    echo -e "${cyan}[+] Instalando uro ${end}"
    sudo pip3 install uro

    # nuclei burp
    echo -e "${cyan}[+] Descargando nuclei burp ${end}"
    wget https://github.com/projectdiscovery/nuclei-burp-plugin/releases/download/v1.0.0-rc1/nuclei-burp-plugin-1.0.0-rc1.jar
    sudo mv nuclei-burp-plugin-1.0.0-rc1.jar /opt/BurpPro/nuclei_burp.jar

    # zsteg
    echo -e "${cyan}[+] Descargando zsteg ${end}"
    gem install zsteg

    # exiftool
    echo -e "${cyan}[+] Descargando exiftool ${end}"
    sudo apt install exiftool -y

    # stegoveritas
    echo -e "${cyan}[+] Descargando stegoveritas ${end}"
    sudo pip3 install stegoveritas
    stegoveritas_install_deps

    # stegseek
    echo -e "${cyan}[+] Descargando stegseek ${end}"
    wget https://github.com/RickdeJager/stegseek/releases/download/v0.6/stegseek_0.6-1.deb
    sudo apt install ./stegseek_0.6-1.deb -y
    rm stegseek_0.6-1.deb

    # naabu
    echo -e "${cyan}[+] Descargando naabu ${end}"
    wget https://github.com/projectdiscovery/naabu/releases/download/v2.0.5/naabu_2.0.5_linux_amd64.zip
    unzip naabu_2.0.5_linux_amd64.zip
    chmod +x naabu
    sudo mv naabu /usr/local/bin/ 
    sudo rm naabu_2.0.5_linux_amd64.zip

    # findomain
    echo -e "${cyan}[+] Descargando findomain ${end}"
    wget https://github.com/findomain/findomain/releases/latest/download/findomain-linux
    chmod +x findomain-linux
    mv findomain-linux findomain
    sudo mv findomain /usr/local/bin/

    # proFTPd
    echo -e "${cyan}[+] Descargando proFTPd ${end}"
    sudo apt install proftpd -y


    # hyperfine
    echo -e "${cyan}[+] Descargando hyperfine ${end}"
    wget https://github.com/sharkdp/hyperfine/releases/download/v1.13.0/hyperfine_1.13.0_amd64.deb
    sudo dpkg -i hyperfine_1.13.0_amd64.deb
    rm hyperfine_1.13.0_amd64.deb

    # Udork
    echo -e "${cyan}[+] Descargando uDork ${end}"
    git clone https://github.com/m3n0sd0n4ld/uDork
    chmod +x uDork/uDork.sh
    filename=$(cat Data/apis/uDork)
    sed -ie "s/cookies=\"c_user=HEREYOUCOOKIE; xs=HEREYOUCOOKIE;\"/${filename}/g" uDork/uDork.sh


    # fix locate
    sudo updatedb

	# Devolviendo permisos a Shockz
	sudo chown -R shockz:shockz /home/shockz/*
	sudo chmod +x -R  /home/shockz/*
    sudo chmod +x -R  /home/shockz/.config
	
    echo -e "${cyan}[+] Limpiando... ${end}"
    # Limpieza de directorios
    sudo rm -r $userPath/Descargas/*
    rm -r Data*
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
