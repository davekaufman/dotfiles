##### ZSH Settings #####
#
### Oh My Zsh! ### {{{
#
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# remove default prompt for vi-mode when using spaceship theme - must be before oh-my-zsh source in .zshrc
export RPS1="%{$reset_color%}"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# See also https://denysdovhan.com/spaceship-prompt/
ZSH_THEME="spaceship"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git pass taskwarrior safe-paste terraform zsh-autosuggestions fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
# export DISABLE_AUTO_TITLE="true"
# precmd_functions=(spaceship_exec_time_precmd_hook)
# preexec_functions=(spaceship_exec_time_preexec_hook)

### End Oh My Zsh! ### }}}

### Spaceship theme stuff ### {{{
#
# not customizing anything right now
#
##### Spaceship theme stuff ##### }}}

### Aliases ### {{{
#

# xclip to clipboard
alias xclip="xclip -selection clipboard"

# I come from a land called Bash
alias type='whence -f'

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
which tree &>/dev/null || alias tree="ls -R | grep \":$\" | sed -e 's/:$//' -e 's/[^-][^\/]*\//──/g' -e 's/^/ /' -e 's/-/┃/'"

unset PAGER MANPAGER
export LESSCHARSET='utf-8';
# export nlcmd='nl -n rz -b a -s"┃ " -w 3 --'

# use pygmentize to preprocess with less (much faster than vimpager)
export LESSOPEN='|/usr/local/bin/pygmentize -O style=native -f console256 -g %s'
export LESS='-m -g -i -W --tab=4 -FR'

# less termcap colors - should convert these to tput
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;34m'     # begin bold
export LESS_TERMCAP_us=$'\E[4;33m'     # begin underline
export LESS_TERMCAP_so=$'\E[7;40;33m'  # begin reverse video
export LESS_TERMCAP_se="$(tput sgr0)"  # reset reverse video
export LESS_TERMCAP_ue="$(tput sgr0)"  # reset underline
export LESS_TERMCAP_me="$(tput sgr0)"  # reset bold/blink

# make sure we get fortunes from all cookie files
alias fortune='fortune -a'

# defaults I like
alias cp='cp -v'
alias mv='mv -v'

# turn on compression and forward X by default
alias ssh='ssh -C -Y'

# one-stop installation of source packages
alias build='./configure && make && sudo make install'

# colorize grep
alias grep='grep --color'
# ripgrep! https://github.com/BurntSushi/ripgrep
alias rg='rg --colors "match:bg:yellow" --colors "match:fg:black" --colors "match:style:nobold" --colors "line:fg:black" --colors "line:style:bold"'

# generate changelog
#alias cl="LC_ALL=C rcs2log -R -v -h \${HOSTNAME} | fmt > ChangeLog"
alias cl="hg log --style changelog > ChangeLog"

# history file - popular commands, for future aliases
#alias histpop='cut -f1 -d" " .bash_history | sort | uniq -c | sort -nr | head -n 30'
#alias histpop='sort .bash_history | uniq -c | sort -nr | head -n 50'

# subversion - add all unignored new files to the repo
#        alias aa="for x in $(svn st | grep ^? | awk '{ print $NF }'); do svn add $x; done"

# tmux detact/attach
alias tmda="tmux det; tmux att"

# taskwarrior
# alias t="task"
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
alias forecast="curl --silent http://wttr.in/Seattle | grep -v '^[A-Z]'"

# if using telnet, set term to xterm because old systems don't have screen-256color terminfo
alias telnet='TERM=xterm telnet'

# seems logical
alias untar="tar xvf"

# public IP
alias pubip="wget http://ipinfo.io/ip -qO -"

# public dig
alias pubdig="dig @4.2.2.2"

# build new version of neomutt
alias build_mutt='./prepare && ./configure --with-tokyocabinet --enable-imap --with-curses --with-regex --with-sasl --with-ssl --enable-sidebar && make && sudo make install'

# rsync to windows
alias rsyncwin='rsync -rlmv --stats --progress --modify-window=10'

### End Aliases ### }}}

### Function Definitons ### {{{

# surround text with a # box #
box() {
	local width=72
	printf -v line "%*s" "$width"
	printf -v center "%s %$(( $(( (width - 1 ) / 2 )) + $(( ${#1} / 2 )) ))s %$(( (width - 1 ) - ( $(( ( width - 1 ) / 2 )) + $(( ${#1} / 2 )) ) ))s" \# "$1" \#
	printf '%s\n' "#${line// /=}#" "$center" "#${line// /=}#"
}

# use imagemagick to intelligently resize an image
smartresize() {
	local size=$1
	local infile="$2"
	echo $size
	mogrify -filter Triangle -define filter:support=2 -thumbnail $size -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB "${infile}"
}

# hugely useful - show only nonempty, uncommented lines from a file
trim() {
	local file="${1}"
	sed 's/^[ \t]*#/#/' "${file}" | egrep -v "^#" | egrep -v "^$" | pygmentize -O style=native -f terminal256 -g
}

# builds latest version of vim with my git commit message syntax highlight patch
update_vim() {
	[ -d "${HOME}/repos/github/vim" ] && \
		sudo -v && cd "${HOME}/repos/github/vim" && patch -p0 < gitcommit.vim.patch && ./configure --enable-cscope --enable-multibyte && make -j3 && sudo make install && git reset --hard HEAD && cd -
}


# calling hg root is too slow
find_hg_root() {
	local dir="${PWD}"
	while [ "${dir}" != "/" ]; do
		[ -f "${dir}/.hg/dirstate" ] && export HG_ROOT="${dir}/.hg"  && return 0
		dir="$(dirname "${dir}")"
	done
	export HG_ROOT=""
	return 1
}


cdrr() {
	[[ $PWD == ${HOME} ]] && cd ${HOME}/repos/dotfiles && return 0
	if git status -s &>/dev/null; then
		cd $(git rev-parse --show-toplevel)
		return 0
	elif find_hg_root; then
		cd $(dirname "${HG_ROOT}")
		return 0
	else
		echo "$PWD is not part of a repository"
		return 1
	fi
}

# calculator!  requires bc
c() { echo "$*" | bc -l; }

# random alphanumeric password
randpass() {
	local chars=$1
	LC_CTYPE=C tr -dc A-Za-z0-9_\!\@\#\$\%\^\&\*\(\)-+= < /dev/urandom | head -c $chars | xargs
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

# ugly hack to remove entries from ssh known_hosts
keyrm() {
	local host=$1
	shorthost=$(echo $host | cut -d'.' -f1)
	ip=$(dig $host +short)
	ssh-keygen -R $host
	ssh-keygen -R $shorthost
	ssh-keygen -R $ip
}

# clone from github to my preferred destination
ghclone() {
	local repo="$1"
	local dest="${HOME}/repos/github/${repo##*/}"
	git clone "https://github.com/${repo}" "${dest}"
	cd "${dest}"
}

connections() { # https://www.commandlinefu.com/commands/view/2012/
	netstat -4tn | awk -F'[\t :]+' '/ESTABLISHED/{hosts[$6]++} END{for(h in hosts){printf("%s\t%s\t",h,hosts[h]);for(i=0;i<hosts[h];i++){printf("*")};print ""}}' | sort --key=2 -nr
}

#
### End of functions ### }}}

##### Environment Variables ##### {{{
# safe tmpdir
export TMPDIR=/${HOME}/tmp/
export TMP=${TMPDIR}

# inputrc
export INPUTRC=~/.inputrc

# IRC defaults
export IRCNICK=$USER

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
export LS_COLORS="di=94;40:ln=36;40;4:so=35;40:pi=1;35;40:ex=1;32;40:bd=1;33;41:cd=1;33;40:su=37;41:sg=0;41:or=93;4:or=31;1:tw=32;44:ow=0;44"
#              dir┘        │          │        │          │          │          │          │        │       │        │       │       │
#                   symlink┘          │        │          │          │          │          │        │       │        │       │       │
#                               socket┘        │          │          │          │          │        │       │        │       │       │
#                               named pipe/FIFO┘          │          │          │          │        │       │        │       │       │
#                                               executable┘          │          │          │        │       │        │       │       │
#                                                        block device┘          │          │        │       │        │       │       │
#                                                               character device┘          │        │       │        │       │       │
#                                                                               setuid file┘        │       │        │       │       │
#                                                                                        setgid file┘       │        │       │       │
#                                                                                             broken symlink┘        │       │       │
#                                                                                              missing symlink target┘       │       │
#                                                                                          dir other writeable, no sticky bit┘       │
#                                                                                                  dir other writeable, no sticky bit┘

# ZSH uses the "ma" LS_COLOR to color the menu highlight. combine with LS_COLORS and use with zstyle down below
ZSH_MENU_COLORS="${LS_COLORS}:ma=30;43"

# set highlight color for GREP
export GREP_COLOR='1;30;43'


# ZSH history settings
HISTFILE=$HOME/.zhistory       # enable history saving on shell exit
setopt APPEND_HISTORY          # append rather than overwrite history file.
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information
setopt HIST_IGNORE_DUPS        # ignore duplicate commands
setopt HIST_SAVE_NO_DUPS       # save no duplicated commands in the history file
setopt HIST_REDUCE_BLANKS      # trim unnecessary blanks from history file
setopt HIST_BEEP               # beep when nonexistent history entry
setopt HIST_IGNORE_SPACE       # ignore commands prepended with space
unsetopt INC_APPEND_HISTORY    # append at exit, not ongoing
unsetopt SHARE_HISTORY
HISTSIZE=1000000               # lines of history to maintain memory.  unsetting does not work like bash.
SAVEHIST=1000000               # lines of history to maintain in history file.
# ignore these commands when writing out the history file
HISTORY_IGNORE="(type *|cd|cd *|&|[bf]g|exit|fortune|clear|cl|history|cat *|file *|dict *|which *|rm *|rmdir *|shred *|sudo rm *|sudo cat *|mplayer *|source *|. *|gojo *|mutt|hg st|hg up|hg pull|ifconfig|identify *|kill *|killall *|last|lastlog|ls|make|lpass *|mount)"

# pkgconfig fix
export PKG_CONFIG_PATH=/opt/gnome/lib/pkgconfig:/usr/lib/pkgconfig:/usr/local/lib/pkgconfig

# fix PATH
PATH=/usr/local/java/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin

# Default windowmanager for startx command
#	export WINDOWMANAGER='/usr/bin/xmonad'

# Preferred text editor.  vim, of course.  Emacs is for heathens.
export EDITOR='vim'

# env for VIM templates
export VIMTEMPLATES="${HOME}/.vim/templates/"
#
##### End of Environment Variables ##### }}}

### Zsh shell options ### {{{
#
unsetopt MAIL_WARN
setopt AUTO_CD
setopt AUTO_LIST
setopt AUTO_PARAM_SLASH
setopt AUTO_REMOVE_SLASH
setopt COMPLETE_ALIASES

zstyle ':completion:*:default' list-colors ${(s.:.)ZSH_MENU_COLORS}
#
### Zsh shell options ### }}}

# found via http://www.strcat.de/dotfiles/dot.zshstyle
[ -f "${HOME}/.zsh.zstyle" ] && source "${HOME}/.zsh.zstyle"

# autojump
which autojump &>/dev/null && . "${HOME}/.zsh.autojump"

# source any hostname specific customizations
[ -f "${HOME}/.zshrc.$(hostname -s)" ] && source "${HOME}/.zshrc.$(hostname -s)"
true
