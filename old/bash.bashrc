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

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto -a'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -la'
alias l='ls $LS_OPTIONS -l'
alias lt='ls $LS_OPTIONS -ltr'

alias permAlias='sudo vi /etc/bash.bashrc'


#USER DEFINED
#alias shay='printf "There is only one Shay this Christmas\n\ndef CountShays():\n\tThere is only one Shay\n\n"'

echo -e "\n\n\n"

figlet "FP-2"


echo -e "Freddie Poser's VPS - 188.166.158.93"
echo -e "\n\n\n"

#echo "Welcome to BluePost1"
echo "This server is maintained by Freddie Poser and hosted by Digital Ocean"

echo -e  "#========================================================#"
echo -e  "> Uptime      : \c"; uptime # Has extra space before uprime so one back :(
echo -e  "> Free Memory :  \c"; free | awk 'FNR == 3 {print $4/($3+$4)*100}' | tr -d '\n'; echo "%"
echo -e  "#========================================================#"


echo -e "\nIf you are accessing this server without permission you are breaking the law\n\nWe don't like people who break the law"


alias cls="clear;ls"
alias freemem="free | awk 'FNR == 3 {print $4/($3+$4)*100}'"
alias usedmem="free | awk 'FNR == 3 {print $3/($3+$4)*100}'"
alias meminfo='echo "FreeMemory : ";freemem; echo " UsedMemory : "; usedmem'

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
