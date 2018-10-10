#!/bin/bash
#  $Id: .bash_profile 83a680a214d1 2017/05/24 18:56:26 dave $
#
# This file is read each time a login shell is started.
# It holds all of our aliases, functions, and environment variables
#
##### First Steps #####  {{{
#
# do nothing if not an interactive shell
[ -z "$PS1" ] && return

# remove any current prompt settings
unset PROMPT_COMMAND

##### end First Steps ##### }}}

##### Color Definitions (commands to set text colors) ##### {{{
ResetColours="$(tput sgr0)"

Black="$(tput setaf 0)"
DarkGrey="$(tput bold ; tput setaf 0)"

BlackBG="$(tput setab 0)"
BrightBlackBG="$(tput bold; tput setab 0)"

Red="$(tput setaf 1)"
LightRed="$(tput bold ; tput setaf 1)"

RedBG="$(tput setab 1)"
LightRedBG="$(tput bold; tput setab 1)"

Green="$(tput setaf 2)"
LightGreen="$(tput bold ; tput setaf 2)"

GreenBG="$(tput setab 2)"
LightGreenBG="$(tput bold; tput setab 2)"

Brown="$(tput setaf 3)"
Yellow="$(tput bold ; tput setaf 3)"

BrownBG="$(tput setab 3)"
YellowBG="$(tput bold; tput setab 3)"

Blue="$(tput setaf 4)"
BrightBlue="$(tput bold ; tput setaf 4)"

BlueBG="$(tput setab 4)"
BrightBlueBG="$(tput bold; tput setab 4)"

Purple="$(tput setaf 5)"
PurpleBG="$(tput setab 5)"

Pink="$(tput bold ; tput setaf 5)"
PinkBG="$(tput bold ; tput setab 5)"

Cyan="$(tput setaf 6)"
BrightCyan="$(tput bold ; tput setaf 6)"

CyanBG="$(tput setab 6)"
BrightCyanBG="$(tput bold ; tput setab 6)"

LightGrey="$(tput setaf 7)"
White="$(tput bold ; tput setaf 7)"

LightGreyBG="$(tput setab 7)"
WhiteBG="$(tput bold ; tput setab 7)"
##### end Color Definitions ##### }}}

##### Set User Chosen Colours Here ##### {{{

# Prompt Characters Color
PCC="${DarkGrey}"

# color of current working directory
PWDC="${Blue}"

# prompt timestamp color
TSTAMPC="${DarkGrey}"

# hostname color
HNC="${Brown}"

# display username in this colour
UNC="${Blue}"

# display prompt in this color
PromptColor="${DarkGrey}"

# Warning colour for low load
WC1="${Green}"

# Medium Load
WC2="${Yellow}"

# High Load
WC3="${Red}"
##### End of Color Definitions ##### }}}

##### Shell Options ##### {{{
#correct spelling errors in cd pathnames
shopt -s cdspell
shopt -s dirspell
#multi-line commands appended to history as single-line, for ease of editing
shopt -s cmdhist
#extended file-globbing
shopt -s extglob
#appends history entries rather than overwriting them.
shopt -s histappend
# includes dotfiles in tab-completion
shopt -s dotglob
# always update windowsize after each command
shopt -s checkwinsize
# if a bare directory is typed as a command, cd to it instead
shopt -s autocd
# ls -F style markers for tab-completed items
set visible-stats on
##### End of Shell-Specific Options ##### }}}
#
#####  Aliases ##### {{{

# I cannot type
alias lear='clear'

# shows only directories, in alphabetical order
alias lsd='ls -alF --color | grep \/ | sort'

# always list in color, tagged for type, human readable sizes
alias ls='ls -h --color -F --time-style long-iso'

# convert permissions to octal - http://www.shell-fu.org/lister.php?id=205
alias lo='ls -l | sed -e 's/--x/1/g' -e 's/-w-/2/g' -e 's/-wx/3/g' -e 's/r--/4/g' -e 's/r-x/5/g' -e 's/rw-/6/g' -e 's/rwx/7/g' -e 's/---/0/g' | column -t'

# get an ordered list of subdirectory sizes - http://www.shell-fu.org/lister.php?id=275
alias dux='du -sk ./* | sort -n | awk '\''BEGIN{ pref[1]="K"; pref[2]="M"; pref[3]="G";} { total = total + $1; x = $1; y = 1; while( x > 1024 ) { x = (x + 1023)/1024; y++; } printf("%g%s\t%s\n",int(x*10)/10,pref[y],$2); } END { y = 1; while( total > 1024 ) { total = (total + 1023)/1024; y++; } printf("Total: %g%s\n",int(total*10)/10,pref[y]); }'\'''

# tree!
which tree &>/dev/null || alias tree="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"

# assign value of less to our $PAGER
alias less='${PAGER}'

# syntax-highlighted cat, if pygmentize is installed
[ -x $(which pygmentize) ] && alias dog='pygmentize -O style=native -f trac -g'

# use vim (invoked as view) as our man file pager - See MANPAGER env var
alias man='man -P "$MANPAGER"'

# make sure we get fortunes from all cookie files
alias fortune='fortune -a'

# grab a random word from the "4000 words" vocab list and define it
alias word="dict -d gcide \$(cut -d: -f1 ~/owncloud/4000words.txt | shuf -n1)"

# turn on compression and forward X by default
alias ssh='ssh -C'

# we have a dual core processor, don't we? let's run concurrent make jobs...
alias make='make -j3'

# one-stop installation of source packages
alias build='./configure && make && sudo make install'

# one stop iso burning
alias burn='cdrecord -tao dev=/dev/scd0 driveropts=burnfree'

# colorize grep
alias grep='grep --color'

# generate changelog from RCS logs
alias cl="LC_ALL=C rcs2log -R -v -h \${HOSTNAME} | fmt > ChangeLog"

# history file - popular commands, for future aliases
alias histpop='cut -f1 -d" " .bash_history | sort | uniq -c | sort -nr | head -n 30'

# tmux detact/attach
alias tmda="tmux det; tmux att"

# taskwarrior
alias t="task"
alias tw="task project:Work"
alias th="task project:Home"
alias ts="task sync"
alias tl="task list"
td() { local ID="${1}"
	task "${ID}" "done"
	unset ID
}
alias ta="task add"

# weather
alias weather="curl --silent 'http://xml.weather.yahoo.com/forecastrss?p=98030&u=f' | grep -E '(Current Conditions:|F<BR)' | tail -n 1 | cut -d'<' -f 1|sed 's/ F$/°F/'"
#	alias forecast="curl --silent 'http://xml.weather.yahoo.com/forecastrss?p=96707&u=f' | grep 'Current Conditions:' -A7 | sed -e 's/<[^>]\+>/ /g' -e 's/^\s\+//'"
alias forecast='curl --silent http://wttr.in/Seattle | grep -v ^[A-Z]'

# if using telnet, set term to xterm because old systems don't have screen-256color terminfo
alias telnet='TERM=xterm telnet'

# seems logical
alias untar="tar xvf"

# public IP
alias pubip="wget http://ipinfo.io/ip -qO -"

# public dig
alias pubdig="dig @4.2.2.2"
#
##### End alias definitions ##### }}}
#
##### Function Definitons ##### {{{
#
# surround text with a # box #
box() {
	local width=72
	printf -v line "%*s" "$width"
	printf -v center "%s %$(( $(( (width - 1 ) / 2 )) + $(( ${#1} / 2 )) ))s %$(( (width - 1 ) - ( $(( ( width - 1 ) / 2 )) + $(( ${#1} / 2 )) ) ))s" \# "$1" \#
	printf '%s\n' "#${line// /=}#" "$center" "#${line// /=}#"
}

smartresize() {
	local size=$1
	local infile="$2"
	echo $size
	mogrify -filter Triangle -define filter:support=2 -thumbnail $size -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB "${infile}"
}

# show only nonempty, noncommented lines from a file
trim() {
	local file="${1}"
	egrep -v "^#" "${file}" | grep -v ^$
}

# Calculates and sets up Load
function load_info {
	#load average
	local avg="$(\cat /proc/loadavg)"
	local load="${avg%% *}"

	#convert to percentage
	local load100=$(echo -e "scale=0 \n ${load}/0.01 \n quit \n" | bc)
	local output # ='\253\273'

	#visual indication of load, by color and symbol
	if [ "$load100" -gt "200" ]; then
		# very high load: show the numeric value in WC3
		DC="${WC3}"
		output="${load}"
	elif [ "$load100" -gt "150" ]; then
		# high load - WC3
		DC="${WC3}"
		output=${load}
	elif [ "$load100" -gt "100" ]; then
		# medium load - WC2
		DC="${WC2}"
		output=${load}
	else
		DC="${WC1}"
		output=${load}
	fi

	#  print the output:
	echo -en "${DC}${output}"
	echo -en "${ResetColours}"
}

function _prompt_command() {
	LASTEXIT=$?
	# functrace disabled as it breaks bash math in strange ways
	set +o functrace
	local LASTEXITLEN=${#LASTEXIT}
	local PATTERN="─";
	local tstamp="$(TZ="US/Pacific" date +%T)"
	tput sc
	echo -n "${PCC}"
	local BRANCHLEN=2
	if git status -s &>/dev/null; then
		local BRANCH="$(git branch | grep ^\* | awk '{ print $NF }')"
		BRANCHLEN=${#BRANCH}
		BRANCHLEN=$(($BRANCHLEN+14))
	elif find_hg_root; then
		BRANCHLEN=$(hg prompt " ☿ {branch}:{rev}:{status|modified}{status|unknown}{update}"| wc -c)
	fi
	local REPEATLEN=$((COLUMNS-$BRANCHLEN))
	REPEATLEN=$((REPEATLEN-9))
	for ((x=0; x<REPEATLEN; x++)); do echo -n "${PATTERN}"; done
	repo_prompt_info
	echo -n "${ResetColours}${PCC}${PATTERN}${PATTERN}"
	echo -n " ${TSTAMPC}$tstamp${ResetColours}"
	tput rc
	[[ "$LASTEXIT" -eq "0" ]] && echo -n "${ResetColours}${Green}‼$LASTEXIT${ResetColours} " || echo -n "${ResetColours}${Red}‼$LASTEXIT${ResetColours} "
	history -a; history -n
}

# calling hg root is too slow
function find_hg_root() {
	local dir="${PWD}"
	while [ "${dir}" != "/" ]; do
		[ -f "${dir}/.hg/dirstate" ] && export HG_ROOT="${dir}/.hg"  && return 0
		dir="$(dirname "${dir}")"
	done
	export HG_ROOT=""
	return 1
}

function repo_prompt_info {
	if git status -s &>/dev/null; then
		echo -n " ${Brown}${ResetColours}"
		BRANCH="$(git branch | grep ^\* | awk '{ print $NF }')"
		if $(git status | grep -q "modified:"); then
			echo -n " ${Red}${BRANCH}${ResetColours}"
		else
			echo -n " ${Green}${BRANCH}${ResetColours}"
		fi
		REV="$(git rev-parse --short HEAD)"
		echo -n "${PCC}:${Yellow}${REV}${ResetColours} "
	elif find_hg_root; then
		hg_branch=$(cat "$HG_ROOT/branch" 2>/dev/null || hg branch)
		echo -n " ${Purple}☿${ResetColours} "
		hg prompt "${Blue}{branch}${ResetColours}${DarkGrey}:${ResetColours}${Green}{rev}${Pink}{status|modified}${ResetColours}${Cyan}{status|unknown}${ResetColours}${Yellow}{update}${ResetColours} " 2>/dev/null
	fi
}

update_vim() {
	[ -d "${HOME}/repos/github/vim" ] && \
		sudo -v && cd "${HOME}/repos/github/vim" && patch -p0 < gitcommit.vim.patch && ./configure --enable-cscope --enable-multibyte && make && sudo make install && git reset --hard HEAD && cd -
}

cdrr() {
    if git status -s &>/dev/null; then
        cd "$(git rev-parse --show-toplevel)" || return 1
        return 0
    elif find_hg_root; then
        cd "$(dirname "${HG_ROOT}")" || return 1
        return 0
    else
        echo "$PWD is not part of a repository"
        return 1
    fi
}

mkcd() {
	local DIR="${1}"
	# make a directory and cd into it
	mkdir -p "${DIR}" && cd "${DIR}" || return
}

# random alphanumeric password
randpass() {
	local chars=$1
	strings /dev/urandom | grep -o '[[:alnum:]]' | head -n "$chars" | tr -d '\n'; echo
	unset chars
}

# adds source ip to input chain and drops all packes
block() {
	local IP="${1}"
	sudo /sbin/iptables -A INPUT -s $IP -j DROP
}

# from http://www.everythingsysadmin.com/archives/000054.html#more, finds machines sending abnormal amounts of arp requests
lARPing() {
	sudo /usr/sbin/tcpdump -l -n arp | egrep 'arp who-has' | head -100 | awk '{ print $NF }' |sort | uniq -c | sort -n
}

# googone - rm's files previously extracted from a tarball
googone() {
	local TARB="${1}"
	tar -tf ${TARB} | xargs rm -r &>/dev/null
}

# frequency of words in a stream of text/file
freq() {
	awk '{for (x=1;x<=NF;x++) print $x}' $1 | sed -e 's/,//g' -e 's/;//g' -e 's/"//g' -e 's/://g' -e s/\'//g | sort | uniq -c | sort -nr
}


title() {
	if [[ "$TERM" =~ xterm ]]; then
		set -o functrace
		trap '[ -n "PS1" ] && echo -ne "\e]1;${BASH_COMMAND%% *}\a"' DEBUG
	elif [[ "$TERM" =~ tmux ]]; then
		set -o functrace
		trap '[ -n "$PS1" ] && echo -ne "\033k${BASH_COMMAND%% *}\033\\"' DEBUG
	fi
}

keyrm() {
	local host=$1
	shorthost=$(echo $host | cut -d'.' -f1)
	ip=$(dig $host +short)
	ssh-keygen -R $host
	ssh-keygen -R $shorthost
	ssh-keygen -R $ip
}

ghclone() {
	local repo="$1"
	local dest="${HOME}/repos/github/${repo##*/}"
	git clone "https://github.com/${repo}" "${dest}"
	cd "${dest}"
}

mclean() {
	for container in $(docker ps -a | grep -v IMAGE | awk '{ print $NF }'); do echo -n "Deleting container: "; docker rm "${container}"; done
	for image in $(docker images | grep -v REPOSITORY | awk '{ print $1 }'); do echo -n "Deleting image: ";docker rmi ${image}; done
}

connections() { # https://www.commandlinefu.com/commands/view/2012/
	netstat -4tn | awk -F'[\t :]+' '/ESTABLISHED/{hosts[$6]++} END{for(h in hosts){printf("%s\t%s\t",h,hosts[h]);for(i=0;i<hosts[h];i++){printf("*")};print ""}}' | sort --key=2 -nr
}
#
##### End of functions ##### }}}

##### Environment Variables ##### {{{
# safe tmpdir
#	export TMPDIR=/${HOME}/tmp/
#	export TMP=${TMPDIR}

# inputrc
export INPUTRC=~/.inputrc

# Latitude and Longitude of machine - used by remind
export LatDeg=21
export LatMin=17
export LatSec=1303
export LongDeg=-157
export LongMin=49
export LongSec=2095

# it's 20XX - time to use UTF-8 locales.
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# LS_COLORS - handy table
#   FG Color     BG  Color     Other FG Color     Other BG Colors
#   30  Black    40  BlackBG   90   Dark Grey     100  Dark GreyBG
#   31  Red      41  RedBG     91   Light Red     101  Light RedBG
#   32  Green    42  GreenBG   92   Light Green   102  Light GreenBG
#   33  Orange   43  OrangeBG  93   Yellow        103  YellowBG
#   34  Blue     44  BlueBG    94   Light Blue    104  Light BlueBG
#   35  Purple   45  PurpleBG  95   Light Purple  105  Light PurpleBG
#   36  Cyan     46  CyanBG    96   Turquoise
#   37  Grey     47  GreyBG    97   White
#
export LS_COLORS="di=34;40:ln=36;40;4:so=35;40:pi=1;35;40:ex=1;32;40:bd=1;33;41:cd=1;33;40:su=37;41:sg=0;41:or=93;4:tw=32;44:ow=0;44"
#              dir┘        │          │        │          │          │          │          │        │       │       │        │
#                   symlink┘          │        │          │          │          │          │        │       │       │        │
#                               socket┘        │          │          │          │          │        │       │       │        │
#                               named pipe/FIFO┘          │          │          │          │        │       │       │        │
#                                               executable┘          │          │          │        │       │       │        │
#                                                        block device┘          │          │        │       │       │        │
#                                                               character device┘          │        │       │       │        │
#                                                                               setuid file┘        │       │       │        │
#                                                                                        setgid file┘       │       │        │
#                                                                                             broken symlink┘       │        │
#                                                                                 dir other writeable, no sticky bit┘        │
#                                                                                          dir other writeable, no sticky bit┘

# set highlight color for GREP
export GREP_COLOR='1;30;43'

# export History options, to ignore certain repetitive commands
export HISTIGNORE="&:[bf]g:exit:fortune:clear:cl:history:cat *:file *:dict *:which *:rm *:rmdir *:shred *:sudo rm *:sudo cat *:mplayer *:source *:. *:gojo *:mutt:hg st:hg up:hg pull:ifconfig:identify *:kill *:killall *:last:lastlog:ls:make:lpass *:mount:cd"

# keep only one copy of any given command in our history, ignoring duplicates and lines beginning with a space
export HISTCONTROL=erasedups:ignoreboth

# give me timestamps in my history
#export HISTTIMEFORMAT='%F %T '

# HISTSIZE is the number of history lines to keep in RAM - I'll take a million.
unset HISTFILESIZE
export HISTSIZE=1000000

# fix PATH
PATH=/usr/local/java/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin:/opt/aws/bin

# Default windowmanager for startx command
#	export WINDOWMANAGER='/usr/bin/xmonad'

# Use vi as our normal file PAGER.
export PAGER="${HOME}/bin/vimpager"

# use vim (invoked as view) as our Man file Pager - see alias section above
export MANPAGER="${HOME}/bin/vimpager"

# Preferred text editor.  vim, of course.  Emacs is for heathens.
export EDITOR='vim'

# env for VIM templates
export VIMTEMPLATES="${HOME}/.vim/templates/"

# mail notification (disable)
#	export MAIL=${HOME}/mail/inbox
unset MAILCHECK
##### End of Environment Variables ##### }}}

##### Other environment settings ##### {{{
# no core files
ulimit -S -c 0
##### Other environment settings ##### }}}

##### START bash completion -- do not remove this line ##### {{{
[ -f /etc/bash_completion ] && source /etc/bash_completion
##### END bash completion -- do not remove this line ##### }}}

##### Export Prompt ##### {{{

# Priviliged User Prompt
case $USER in
	root)
		UNC="${Red}"
		PCC="${Red}"
		PromptColor="${Red}"
		;;
esac
#
export PROMPT_COMMAND="_prompt_command"

# set auto titling of windows and tmux buffers
title
if [[ "$TERM" =~ tmux ]]; then
	PS1="\[${ResetColours}\]\[${PCC}\]── \[${ResetColours}${UNC}\]\u\[${ResetColours}\]\[${PCC}\]@\[${ResetColours}\]\[${HNC}\]\h\[${ResetColours}\]\[${PCC}\]:\[${ResetColours}\]\[${PWDC}\]\w \[${PCC}\]────\[${ResetColours}\]\n\[${PromptColor}\]\\\$\[$(echo -ne "\033kbash\033\\")${ResetColours}\] "
else
	PS1="\[${ResetColours}\]\[${PCC}\]── \[${ResetColours}${UNC}\]\u\[${ResetColours}\]\[${PCC}\]@\[${ResetColours}\]\[${HNC}\]\h\[${ResetColours}\]\[${PCC}\]:\[${ResetColours}\]\[${PWDC}\]\w \[${PCC}\]────\[${ResetColours}\]\n\[${PromptColor}\]\\\$\[$(echo -ne "\033]0;${USER}@$HOSTNAME\007")${ResetColours}\] "
fi
PS2="\[${PCC}\]⎯⎯\[${ResetColours}\]"

##### End of Export Prompt ##### }}}

##### Local customizations ##### {{{
# source any local customizations, based on hostname. ensure we always exit 0
[ -f ${HOME}/.bash_profile.$HOSTNAME ] && set +o functrace && source ${HOME}/.bash_profile.$HOSTNAME || (echo > /dev/null)
##### end local customizations ##### }}}

##### End of .bash_profile #####
