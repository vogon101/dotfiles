# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# SU hardening
alias su="echo \"Always use '/bin/su –' for security reasons\""

# Useful aliases
alias h='history'
alias j='jobs -l'
alias c='clear'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='colordiff'
alias bc='bc -l'
alias sha1sum='openssl sha1'
alias wget='wget -c'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T'
alias nowtime='now'
alias nowdate='date +"%d-%m-%Y"'
alias svi='sudo vi'
alias vis='vim "+set si"'
alias edit='vim'
alias ups='ps axj | egrep -v "[0-9] \[.*\]"'
alias kps='ps axj | head -1; ps axj | egrep --color=never "[0-9] \[.*\]"'

alias proc='ps axj | tail -n +2 | egrep -v egrep | egrep -i'
alias cmd='history | egrep -i'
alias log='edit /var/log/syslog'
alias follow='tail -f'
alias ports='netstat -tulpn | egrep -ve "127.0.0.1" -e "p6"'
alias port='ports | egrep -i '

alias service='sudo service'
alias cdhtml='cd /var/www/html'
alias cdapache='cd /etc/apache2'
# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto -a'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -la'
alias l='ls $LS_OPTIONS -l'
alias lt='ls $LS_OPTIONS -ltr'

alias permAlias='sudo vi /etc/bash.bashrc'


alias freemem="free | awk 'FNR == 3 {print $4/($3+$4)*100}'"
alias usedmem="free | awk 'FNR == 3 {print $3/($3+$4)*100}'"
alias meminfo='echo "FreeMemory : ";freemem; echo " UsedMemory : "; usedmem'

alias :q='exit'

alias docker='sudo docker'

alias version='lsb_release -a'

transfer() { 
    # check arguments
    if [ $# -eq 0 ]; 
    then 
        echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
        return 1
    fi

    # get temporarily filename, output is written to this file show progress can be showed
    tmpfile=$( mktemp -t transferXXX )
    
    # upload stdin or file
    file=$1

    if tty -s; 
    then 
        basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g') 

        if [ ! -e $file ];
        then
            echo "File $file doesn't exists."
            return 1
        fi
        
        if [ -d $file ];
        then
            # zip directory and transfer
            zipfile=$( mktemp -t transferXXX.zip )
            cd $(dirname $file) && zip -r -q - $(basename $file) >> $zipfile
            curl --progress-bar --upload-file "$zipfile" "https://transfer.sh/$basefile.zip" >> $tmpfile
            rm -f $zipfile
        else
            # transfer file
            curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" >> $tmpfile
        fi
    else 
        # transfer pipe
        curl --progress-bar --upload-file "-" "https://transfer.sh/$file" >> $tmpfile
    fi
   
    # cat output link
    cat $tmpfile

    # cleanup
    rm -f $tmpfile
}

build_prompt () {
    BASE="\[\e["
    #HEAD="m[\u@\h, load: `cat /proc/loadavg | awk '{ print $1; }'`%]\e[0;97m \w \$ "
    HEAD="m\][\u@\h]\[\e[97m\] \w \$ "
    FINAL=$BASE$1$HEAD
    PS1=$FINAL
}


where () {
    find "$1" -xdev -name "$2"
}

smallPrompt(){
    PS1="\w>"
}

alias cl="c;l;"
alias cls="c;ls;"
if [ "$WIN_INSTALL" = true ] ; then 
    alias cdc="cd $WIN_C_DRIVE"
    alias cdgdrive='cd "$WIN_GOOGLE_DRIVE"'
fi
