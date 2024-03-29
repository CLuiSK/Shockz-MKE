
# Archivo para habilitar copy paste en vmware
#/home/shockz/.config/bin/copy_paste.sh &
# Fix resdimensionalizacion de vmware
#wmname LG3D 1> /dev/null &

# Eliminar pitido
#sudo rmmod pcspkr

# Fix cursor
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word


# Fix the Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1
export ROCKYOU='/usr/share/wordlists/rockyou.txt'

# Enable Powerlevel10k instant prompt. Should stay at the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
HISTFILE=~/.zsh_history 
SAVEHIST=10000

setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed



# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
source /home/shockz/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Manual configuration

PATH=/root/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

# Manual aliases
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias cat='/bin/bat'
alias catn='/bin/cat'
alias catnl='/bin/bat --paging=never'
alias airgeddon='/usr/bin/airgeddon/airgeddon.sh'
alias vm='/home/shockz/.config/bin/copy_paste.sh'
alias tty='/home/shockz/.config/bin/tty.sh'
alias ch='/usr/bin/chmod +x'
alias wg='wget -H -r --level=1 -k -p'
alias autorecon='python3 /usr/bin/AutoRecon/autorecon.py'
alias nports='nmap -p- --open -sS --min-rate 2000 -vvv -n -Pn -oG allPorts'
alias nserv='nmap -sS -A --min-rate 2000 -vvv -n -Pn -oG targetered'
alias burpro='java -javaagent:/opt/BurpPro/BurpSuiteLoader_v2021.12.1.jar -noverify -jar /opt/BurpPro/burpsuite_pro_v2021.12.1.jar'
alias cme='/usr/bin/cme'
alias server='python3 -m http.server 80 -d'
alias servert='/usr/local/bin/wwwtree.py -r'
alias spiderfoot='cd /opt/spiderfoot/ && python3 ./sf.py -l 127.0.0.1:5001'
alias smb='impacket-smbserver -smb2support shared $(pwd)'
alias ffufz='f() { ffuf -mc all -fc 404 -ac -sf -s -c -ic -r -u $1FUZZ -w /usr/share/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-medium.txt -t 100 -e .php,.html,.txt -recursion };f'
#allffufz http://testphp.vulnweb.com/ micro/short/nada
alias allffufz='f() { ffuf  -mc all -fc 404 -ac -sf -s -c -ic -r -t 100 -u $1FUZZ -w /usr/share/OneListForAll/onelistforall$2.txt };f'
alias j='OMP_NUM_THREADS=8 john --wordlist=$ROCKYOU $1'
alias jk='OMP_NUM_THREADS=8 john --wordlist=/usr/share/wordlists/kaonashi/kaonashi14M.txt $1'
alias recon='/home/shockz/.config/bin/recon.sh'
alias shell='rlwrap -cAr nc -lvp $1'
alias sel='xclip -i -sel p -f | xclip -i -sel c'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Plugins
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-plugins/sudo.plugin.zsh

# Functions
function mkt(){
	mkdir {nmap,content,exploits,scripts}
}

# Extract nmap information
function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

# Set 'man' colors
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

# fzf improvement
function fzf-lovely(){

	if [ "$1" = "h" ]; then
		fzf -m --reverse --preview-window down:20 --preview '[[ $(file --mime {}) =~ binary ]] &&
 	                echo {} is a binary file ||
	                 (bat --style=numbers --color=always {} ||
	                  highlight -O ansi -l {} ||
	                  coderay {} ||
	                  rougify {} ||
	                  cat {}) 2> /dev/null | head -500'

	else
	        fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
	                         echo {} is a binary file ||
	                         (bat --style=numbers --color=always {} ||
	                          highlight -O ansi -l {} ||
	                          coderay {} ||
	                          rougify {} ||
	                          cat {}) 2> /dev/null | head -500'
	fi
}

function rmk(){
	scrub -p dod $1
	shred -zun 10 -v $1
}

function settarget(){
    target=$1
    echo "$target" > /home/shockz/.config/polybar/scripts/target
}

function cleartarget(){
    echo '' > /home/shockz/.config/polybar/scripts/target
}

function transfer() {
        curl --progress-bar --upload-file "$1" https://transfer.sh/$(basename $1) | xclip -i -sel p -f | xclip -i -sel c
}

function nuclei_ips() {
	cat "$1" | grep "$2" | cut -d ' ' -f4 | sort | uniq
}

# Finalize Powerlevel10k instant prompt. Should stay at the bottom of ~/.zshrc.
(( ! ${+functions[p10k-instant-prompt-finalize]} )) || p10k-instant-prompt-finalize

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# Golang vars
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH
