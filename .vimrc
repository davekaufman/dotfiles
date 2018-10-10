" $Id: .vimrc 83a680a214d1 2017/05/24 18:56:26 dave $
"
" Necessary top of file settings {{{
"───────────────────────────────────────────────────────────────────────────────
" UTF-8 by default - at top because things below rely on it being set
if has('multi_byte')
	if &termencoding ==? ''
		let &termencoding = &encoding
	endif
	set encoding=utf-8
	setglobal fileencoding=utf-8
	scriptencoding utf-8
	"setglobal bomb
	set fileencodings=utf-8,latin1
endif
"
"───────────────────────────────────────────────────────────────────────────────
" }}}
"
" Plugin/Explicit sourcings {{{
"───────────────────────────────────────────────────────────────────────────────
"	runtime macros/matchit.vim        " better % matching
"	:source $HOME/.vim/plugin/rcs.vim " RCS plugin

" source any hostname-specific items
function! LoadFileNoError(filename)
	let l:FILE=expand(a:filename)
	if filereadable(l:FILE)
		exe  'source '  l:FILE
	endif
endfunction
let g:HOST = substitute ( hostname(), '\..*$', '', 'g' )
exec LoadFileNoError( '~/.vimrc.' . g:HOST )

"───────────────────────────────────────────────────────────────────────────────
"
" vim-plug (https://github.com/junegunn/vim-plug) settings
" Automatically install vim-plug and run PlugInstall if vim-plug not found
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	augroup PlugInitial
		autocmd!
		autocmd VimEnter * PlugInstall | source $MYVIMRC
	augroup END
endif
call plug#begin('~/.vim/plugged')
"───────────────────────────────────────────────────────────────────────────────
"                               Plugins
"───────────────────────────────────────────────────────────────────────────────
" Look/Feel Plugins
Plug 'ap/vim-buftabline'               " light bufferline
Plug 'itchyny/lightline.vim'           " light status line
Plug 'ryanoasis/vim-devicons'          " filetype icons for vim
Plug 'Yggdroot/indentline'             " faster indent guides
" ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
" Color Schemes
Plug 'ap/vim-css-color'                " preview colors when editing
Plug 'briancarper/gentooish.vim'       " gentooish
Plug 'jonathanfilip/vim-lucius'        " lucius color scheme
Plug 'josuegaleas/jay'                 " jay
Plug 'Lokaltog/vim-distinguished'      " distinguished
Plug 'nanotech/jellybeans.vim'         " jellybeans color scheme
Plug 'romainl/Apprentice'              " Apprentice
Plug 'scwood/vim-hybrid'
"───────────────────────────────────────────────────────────────────────────────
" Feature enhancements / Addons
Plug 'andymass/vim-matchup'            " better matchit.vim
Plug 'ConradIrwin/vim-bracketed-paste' " autodetect pastex text without set paste
Plug 'godlygeek/tabular'               " easily text alignment
Plug 'henrik/vim-indexed-search'       " show count of matched searches and position
Plug 'haya14busa/is.vim'               " incremental search matching
Plug 'jamessan/vim-gnupg'              " editing gpg-encrypted files
Plug 'lifepillar/vim-mucomplete'       " lightweight fast vim completion
Plug 'luochen1990/rainbow'             " better highlighting for nested {[()]}
" Plug 'maxbrunsfeld/vim-yankstack'      " better cut/paste :reg stuff
" Plug 'mhinz/vim-startify'              " recently used files
Plug 'mjbrownie/swapit'                " toggle things like true/false with C-A/C-X
Plug 'mzlogin/vim-markdown-toc'        " generate markdown table of contents
Plug 'reedes/vim-litecorrect'          " vim-litecorrect - autocorrect
Plug 'rickhowe/diffchar.vim'           " better diff
Plug 'tmhedberg/SimpylFold'            " properly fold python
Plug 'tpope/vim-abolish'               " Easier abbreviations
Plug 'tpope/vim-commentary'            " comment things out easily
Plug 'tpope/vim-repeat'                " Easily repeat with . plugin-based actions
Plug 'tpope/vim-speeddating'           " Easy increment/decrement of dates/times
Plug 'tpope/vim-surround'              " Easily surround text objects with '{[( etc
Plug 'vim-scripts/indentpython.vim'    " better python indentation
Plug 'vim-scripts/Vitality'            " fix vim autosave when inside tmux
Plug 'vim-utils/vim-troll-stopper'     " detect and remove unicode 'troll' characters
Plug 'vimwiki/vimwiki'                 " vimwiki
Plug 'w0rp/ale'                        " async lint checking
Plug 'zirrostig/vim-schlepp'           " visual mode block movement
" ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
" Syntax file additions
Plug 'hashivim/vim-terraform'          " terraform syntax
Plug 'pearofducks/ansible-vim'         " ansible syntax
Plug 'sunaku/vim-hicterm'              " console colors syntax highlighted to match the color they appear in console
Plug 'tmux-plugins/vim-tmux'           " tmux syntax
Plug 'vim-scripts/nginx.vim'           " nginx syntax
"───────────────────────────────────────────────────────────────────────────────
" Revision control enhancements
Plug 'ludovicchabant/vim-lawrencium'   " vim mercurial integration
Plug 'mhinz/vim-signify'               " marks changed lines of revision controlled files
" Plug 'tpope/vim-fugitive'              " vim git integration
"───────────────────────────────────────────────────────────────────────────────
call plug#end()
" }}}
"
" set Options {{{
"───────────────────────────────────────────────────────────────────────────────
color jellybeans                            " Color scheme
filetype on                                 " Enable file type detection.
syntax on                                   " turn on syntax highlighting
set autoindent                              " So useful.
set autowriteall                            " Save on any buffer change. Avoids crash loss
set background=dark                         " I'm always going to have a dark background
set backspace=2 whichwrap+=<,>,[,]          " backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start              " Allow backspacing over everything in insert mode
set fillchars+=vert:│                       " nicer looking vertical fill character
set hidden                                  " remembers marks and undo when switching buffers
set history=1000                            " Ex command history length
set hlsearch                                " highlight search
set ignorecase                              " Turn off ignorecase in a typed search if an uppercase char exists.
set incsearch                               " incremental search
set lazyredraw                              " speed up macros by not forcing redraw
set list                                    " make nonprinting chars visible
set listchars=tab:\│\ ,trail:·,nbsp:.,precedes:←,extends:→  " nonprinting characters to show
set modeline                                " enable processing of modelines
set modelines=1                             " either the first or last line is the modeline
set nobackup                                " I hate *~ files.
set noexpandtab                             " ASCII-9 chars when hitting tab
set noshowmode                              " mode is in my status line already
set number                                  " number all the lines...
set relativenumber                          " ...relatively
set ruler                                   " Ruler is useful
set scrolloff=5                             " minimum number of lines above and below cursor
set shiftround                              " round indent to multiple of shiftwidth
set shiftwidth=4                            " This is the >> << value.
set shortmess+=I                            " No start up message
set showcmd                                 " Usefull for select and visual modes.
set showmatch                               " Show me where the opening matches to closing ) } ] are.
set smartcase                               " override ignorecase when search has capitals
set smarttab                                " use shiftwidth to calculate tabs
set splitbelow                              " more natural split locations
set splitright
set synmaxcol=3000                          " highlight columns only up to col 3000 - speeds up loading when lines are long{{{}}}
set t_Co=256                                " set 256 color mode always
set tabstop=4                               " This is the tab key value.
set tags=./tags,~/.vim/tags                 " Tags
set timeout timeoutlen=300 ttimeoutlen=50   " remove delay when hitting o,O,etc..
set title                                   " changes xterm title automatically
set ttyfast                                 " ttyfast indicates a fast terminal connection. force this.
set visualbell
set wildmenu                                " better tab completion of hostnames - puts bar with names above
set wrap                                    " let's display nicely, shall we?
set viminfo=<800,'100,/50,:100,h,f0,s10
"            │    │   │   │    │ │  └ dunno, but this is the default. can't find documentation for it anywhere.
"            │    │   │   │    │ └ file marks 0-9,A-Z 0=NOT stored
"            │    │   │   │    └ disable 'hlsearch' loading viminfo
"            │    │   │   └ command-line history saved
"            │    │   └search history saved
"            │    └ files marks saved
"            └ lines saved each register (old name for <, vi6.2)
"
" persistent undo is really handy
if has('persistent_undo')
	if !isdirectory($HOME . "/.vim/undo")
		call mkdir($HOME . "/.vim/undo", "p", 0700)
	endif
	set undolevels=5000
	set undodir=$HOME/.vim/undo
	set undofile
	set updatecount=20
endif

" automatically wrap text to textwidth (t),
set formatoptions+=wjtcron
"                  ││││││└ better indentation of lists
"                  │││││└ insert comment char when inserting new lines
"                  ││││└ insert comment char when inserting new lines
"                  │││└ autowrap comments at textwidth
"                  ││└ wrap text to textwidth
"                  │└ delete comment char when joining lines
"                  └ space and end of line indicates paragraph continues

" DICTIONARY STUFF.
if filereadable($VIM . '/words')
	set dictionary+=$VIM/words
endif

if filereadable('/usr/share/dict/words')
	set dictionary+=/usr/share/dict/words
endif

" enable cursor line and column visual indicator
if &diff
	"color lodestone
	set nocursorline
	set nocursorcolumn
	let g:ale_enabled=0
else
	augroup CursorLineStuff
		autocmd!
		set cursorcolumn
		set colorcolumn=+1
		set cursorline
		autocmd InsertLeave,WinEnter * set cursorline cursorcolumn
		autocmd InsertEnter,WinLeave * set nocursorline cursorcolumn
	augroup END
endif

" fix delete
if &term ==? 'tmux'
	set t_kb=
	fixdel
endif

"Status Line
"	set statusline=%<\ %{mode()}\ \|\ %F%=\ %{&fileformat}\ \|\ %{&fileencoding}\ \|\ %{&filetype}\ \|\ %p%%\ \|\ LN\ %l:%c\
set laststatus=2 " always show the status line
"───────────────────────────────────────────────────────────────────────────────
" change cursor shape in insert mode -
" this only works in xterm and iterm currently --2014-05-07
" http://vim.wikia.com/wiki/Configuring_the_cursor
" 1 or 0 -> blinking block
" 2 solid block
" 3 -> blinking underscore
" 4 solid underscore
" Recent versions of xterm (282 or above) also support
" 5 -> blinking vertical bar
" 6 -> solid vertical bar
" solid underscore seems to work in xterm more frequently than blinking
" vertical bar
let &t_SI .= "\<Esc>[3 q"
let &t_EI .= "\<Esc>[4 q"
"───────────────────────────────────────────────────────────────────────────────
" }}}
"
" Mappings/Remappings {{{
"───────────────────────────────────────────────────────────────────────────────
" reformat paragraphs
nnoremap Q gwip

" move up and down by display lines, not actual lines.
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" comment line or visual selection with space
vmap <silent> <space> gc
nmap <silent> <space><space> gcc

" count words in visual selection more easily
vnoremap gw g<C-g>:<C-U>echo v:statusmsg<CR>

" better buffer movement
nnoremap <C-n> <c-w>l
nnoremap <C-p> <c-w>h

" make Y behave like D and C
nnoremap Y y$

" backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-Insert is Copy
vnoremap <C-Insert> "+y

" SHIFT-Insert is Paste
map <S-Insert>	"+gP
cmap <S-Insert>	 <C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.	They are pasted as if they
" were characterwise instead.
if has('virtualedit')
	nnoremap <silent> <SID>Paste :call <SID>Paste()<CR>
	func! <SID>Paste()
		let l:ove = &virtualedit
		set virtualedit=all
		normal `^"+gPi^[
		let &virtualedit = l:ove
	endfunc
	imap <C-V>	<Esc><SID>Pastegi
	vmap <C-V>	"-c<Esc><SID>Paste
else
	nnoremap <silent> <SID>Paste "=@+.'xy'<CR>gPFx"_2x
	imap <C-V>	x<Esc><SID>Paste"_s
	vmap <C-V>	"-c<Esc>gix<Esc><SID>Paste"_x
endif
imap <S-Insert> <C-V>
vmap <S-Insert> <C-V>

" automatically move cursor to end of pasted text
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" remap ` to '	for easier jumping to marks
nnoremap ' `
nnoremap ` '

" move the cursor back to where it was after repeating a change
nmap . .'[

" remap arrow keys
" make left and right arrow keys do indentation in normal mode
nnoremap <left> <<
nnoremap <right> >>
" make up and down move the entire line the cursor is on up or down
nnoremap <up>  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap <down>  :<c-u>execute 'move +'. v:count1<cr>

" fix loss of selection when shifting <>
xnoremap <  <gv
xnoremap >  >gv

" remap C-A/C-X (increment/decrement value under cursor by 1)
" superseded by plugins
" noremap + <C-A>
" noremap - <C-X>

" center search results!
nnoremap n nzz
nnoremap N Nzz

" remove trailing whitespace
nnoremap <silent> Ds :%s/\s\+$//<CR>
nnoremap <silent> DS :%s/^\s\+//<CR>

" remove whitespace which occurs prior to a tab character \t
nnoremap <silent> yt :%s/ \+\ze\t//g<CR>

" unfold everything
nnoremap zu zR
"───────────────────────────────────────────────────────────────────────────────
" Leader mappings
" can't map leader to space, since that breaks pasting any text that contains spaces and then the pastetoggle character.

" change the mapleader from \ to ,
let g:mapleader=','

" set paste
set pastetoggle=<Leader>.

" automatically toggle paste mode when pasting the system clipboard with
" control-v
"	set clipboard=unnamedplus
inoremap <S-Insert> <Leader>p<C-o>"+P<Leader>p
nnoremap <S-Insert> <Insert><Leader>p<C-o>"+P<Leader>p

" toggle cursor line and column marker
noremap <Leader>' :set cursorline!<CR> :set cursorcolumn!<CR>

" clear search highlights
noremap <leader><space> :noh<cr>
nnoremap <silent> <space> :nohlsearch<CR>

" write file
nnoremap <leader>w :w<cr>

" create underline
nmap <leader>_ yypVr─

" buffer nav
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

" Align text
nnoremap <leader>Al :left<cr>
nnoremap <leader>Ac :center<cr>
nnoremap <leader>Ar :right<cr>
vnoremap <leader>Al :left<cr>
vnoremap <leader>Ac :center<cr>
vnoremap <leader>Ar :right<cr>

" Tabularize mappings
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a" :Tabularize /"<CR>
vmap <Leader>a" :Tabularize /"<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,\zs<CR>
vmap <Leader>a- :Tabularize /-\zs<CR>
nmap <Leader>a- :Tabularize /-\zs<CR>
vmap <Leader>a, :Tabularize /,\zs<CR>

" toggle stuff off for mouse selection/copying
nnoremap <Leader>m  <ESC>:set list!<CR>:set number!<CR>:set relativenumber!<CR>:SignifyToggle<CR>:IndentLinesToggle<CR>

" copy to clipboard - I should really consider learning how to use registers
nnoremap <silent> <Leader>c <ESC>:w !xclip -selection clipboard<CR><CR>
vnoremap <silent> <Leader>c <ESC>:'<,'>w !xclip -selection clipboard<CR><CR>


" pipe buffer through pandoc and preview in elinks
nmap <Leader>x :!pandoc -f gfm % \| lynx -stdin<cr>:redraw!<cr>
"───────────────────────────────────────────────────────────────────────────────
" }}}
"
" Functions {{{
"───────────────────────────────────────────────────────────────────────────────
" Generates a frequency table of all words in the buffer or selection
" http://vim.wikia.com/wiki/VimTip1531
function! WordFrequency() range
	let l:all = split(join(getline(a:firstline, a:lastline)), '\A\+')
	let l:frequencies = {}
	for l:word in l:all
		let l:frequencies[l:word] = get(l:frequencies, l:word, 0) + 1
	endfor
	new
	setlocal buftype=nofile bufhidden=hide noswapfile tabstop=20
	for [l:key,l:value] in items(l:frequencies)
		call append('$', l:key."\t".l:value)
	endfor
	sort! in
endfunction
command! -range=% WordFrequency <line1>,<line2>call WordFrequency()

" Wordcount (for use in lightline/statusline)
function! WordCount()
	let s:old_status = v:statusmsg
	let position = getpos(".")
	exe ":silent normal g\<c-g>"
	let stat = v:statusmsg
	let s:word_count = 0
	if stat != '--No lines in buffer--'
		let s:word_count = str2nr(split(v:statusmsg)[11])
		let v:statusmsg = s:old_status
	end
	call setpos('.', position)
	return s:word_count
endfunction
command! -range=% WordCount <line1>,<line2>call WordCount()

" readnly status line function
function! ReadOnly()
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

" convert rows of numbers or text (as if pasted from excel column) to a tuple
function! ToTupleFunction() range
	silent execute a:firstline . "," . a:lastline . "s/^/'/"
	silent execute a:firstline . "," . a:lastline . "s/$/',/"
	silent execute a:firstline . "," . a:lastline . "join"
	silent execute "normal I("
	silent execute "normal $xa)"
endfunction
command! -range ToTuple <line1>,<line2> call ToTupleFunction()

" convert rows of numbers or text (as if pasted from excel column) to an array
function! ToArrayFunction() range
	silent execute a:firstline . "," . a:lastline . "s/^/\"/"
	silent execute a:firstline . "," . a:lastline . "s/$/\",/"
	silent execute a:firstline . "," . a:lastline . "join"
	silent execute "normal I["
	silent execute "normal $xa]"
endfunction
command! -range ToArray <line1>,<line2> call ToArrayFunction()
"
"───────────────────────────────────────────────────────────────────────────────
" }}}
"
" Autocommands {{{
"───────────────────────────────────────────────────────────────────────────────
if has('autocmd')
	" load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	augroup crontabs
		autocmd!
		autocmd filetype crontab setlocal nobackup nowritebackup
	augroup END

	augroup markdown
		autocmd!
		autocmd BufNewFile,BufRead *.md set ft=markdown
	augroup END

	augroup shellscripts
		autocmd!
		autocmd Filetype bash,sh,zsh syntax on
		autocmd Filetype bash,sh,zsh set foldmethod=marker
		autocmd Filetype bash,sh,zsh let g:is_sh=1
		autocmd Filetype bash,sh,zsh let g:sh_fold_enabled=5
	augroup END

	augroup Commits
		autocmd!
		autocmd FileType hgcommit,gitcommit set textwidth=72
		autocmd FileType hgcommit,gitcommit highlight OverLength ctermbg=238 guibg=#2d2d2d guifg=#000000 ctermfg=white
		autocmd FileType hgcommit,gitcommit match OverLength /\%>72v/
	augroup END

	augroup pythonstuff
		autocmd!
		autocmd BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
		autocmd FileType python silent! :MUcompleteAutoOff
	augroup END

	" disabled because it caused problems
	" augroup json_edit
	"	autocmd!
	"	autocmd FileType json imap <silent> i :set conceallevel=0<CR>i
	"	autocmd FileType json inoremap <silent> <ESC> <ESC>:set conceallevel=2<CR>
	" augroup END

	" restore cursor to previous position when opening file
	function! ResCur()
		if line("'\"") <= line('$')
			normal! g`"
			normal! zz
			return 1
		endif
	endfunction

	augroup resCur
		autocmd!
		autocmd BufWinEnter * call ResCur()
	augroup END
"───────────────────────────────────────────────────────────────────────────────

"───────────────────────────────────────────────────────────────────────────────
	" email editing
"───────────────────────────────────────────────────────────────────────────────
	let g:mail_erase_quoted_sig=1                        " removes quoted signatures automagically (via mail.vim ftplugin)
	let g:mail_delete_empty_quoted=1                     " removed empty quoted lines
"───────────────────────────────────────────────────────────────────────────────
	function! MailClean()
		" HACK HACK HACK regexes abound and Herein Be Dragons HACK HACK HACK
		"
		" delete any line that is quoted > > or more
		silent! exec ':g/^>\s*>/d'

		" Sent from my LATEST NOISY APP ATTRIBUTION!
		silent! exec ':g/^>\\=\\s*Sent from my/de'

		" delete any two or more empty quoted lines
		silent! exec ':g/\\(^>\\s*\\n\\)\\{2,}/de'

		" delete empty line in middle of quoted lines
		silent! exec ':g/^\\s*\\n>/de'

		" delete empty quoted line followed by empty lines
		silent! exec ':g/^>\\s*\\n\\n/de'

		" delete two or more empty lines
		silent! exec ':%s/\\n\\{3,}/\\r\\r/e'

		" move cursor and insert new blank line
		normal ggO

		" end in insert mode please
		startinsert
	endfunction
	" autocmd FileType mail call MailClean()
"───────────────────────────────────────────────────────────────────────────────
	" autoformat text and no autoformatting comment insertion when writing email.
	augroup email
		autocmd!
		autocmd FileType mail setlocal spell spelllang=en_us " spell checking!
		autocmd BufNewFile,BufRead /tmp/mutt-* set filetype=mail
		autocmd FileType mail set fo=tcrqaw tw=72 autoindent expandtab encoding=utf-8

		" select crap to delete/summarize with [...] and hit D to do so
		autocmd FileType mail vmap D dO> [...]<CR><BS><BS>

		" removes nested quotes, empty quoted lines, and any section of two or more blank lines
		autocmd FileType mail map <leader>f :call MailClean()<CR>
		autocmd FileType mail map <leader>g :%g/^> >/d<CR>:%s/^>\s\+$/ /g<CR>:%s/\s\+$//e<CR>:%s/\n\{3,}/\r\r/e<CR>:g/^> \(On\\|At\)\(Mon,\\|Tue,\\|Wed,\\|Thu,\\|Fri,\\|Sat,\\|Sun,\).*$/d<CR>/>.*Original Message<CR>dGxo<BS>--<Esc>:r ~/.signature<CR>ggG?^><CR>:noh<CR>o<CR><CR><BS>

		"	highlight all lines past a certain point  ***FIXME*** figure out a way to automatically set OverLength to textwidth
		autocmd FileType mail highlight OverLength ctermbg=236 guibg=#2d2d2d guifg=#000000 ctermfg=white
		autocmd FileType mail match OverLength /\%>72v/
		autocmd FileType mail silent! :MUcompleteAutoOff
	augroup END

	"	autocmd Filetype mail set comments=nb:>
"───────────────────────────────────────────────────────────────────────────────

	"terraform
	let g:terraform_align=1
	augroup tf
		autocmd!
		autocmd FileType terraform setlocal commentstring=#%s
		autocmd FileType terraform set expandtab tabstop=2 softtabstop=2 shiftwidth=2
	augroup END
"───────────────────────────────────────────────────────────────────────────────

endif
"───────────────────────────────────────────────────────────────────────────────
" }}}
"
" Highlighting overrides {{{
"───────────────────────────────────────────────────────────────────────────────
"           NAME           GUIFG             GUIBG            GUI ATTR          CTERMFG         CTERMBG        CTERM ATTR
highlight   Comment        guifg=#808080     guibg=#2d2d2d    gui=italic        ctermfg=239     ctermbg=none   cterm=italic
highlight   SpecialKey     guifg=#666666     guibg=#151515    gui=none          ctermfg=237     ctermbg=none
highlight   NonText        guifg=#808080     guibg=#090909    gui=none          ctermfg=235     ctermbg=none
highlight   Search         guifg=#000000     guibg=#e2d223    gui=none          ctermfg=232     ctermbg=190    cterm=bold
highlight   ColorColumn                      guibg=#2d2d2d                                      ctermbg=235
highlight   CursorColumn                     guibg=#2d2d2d                                      ctermbg=235
highlight   CursorLine                       guibg=#2d2d2d    gui=underline                     ctermbg=235    cterm=underline
highlight   Folded         guifg=#999999     guibg=#2d2d2d                      ctermbg=234     ctermfg=244
highlight   FoldColumn     guifg=#999999     guibg=#2d2d2d                      ctermbg=234     ctermfg=244
highlight   VertSplit                        guibg=#292929                                      ctermbg=NONE
highlight   SignColumn                       guibg=#1d1d1d                                      ctermbg=NONE
highlight   mailURL        guifg=#ffff60                      gui=underline     ctermfg=69                     cterm=underline
highlight   helpURL        guifg=#ffff60                      gui=underline     ctermfg=69                     cterm=underline

let g:jellybeans_overrides = {
\    'background': { 'guibg': '1d1d1d', 'ctermbg': '232' },
\    'Comment': { 'guifg': '444444', 'guibg': '1d1d1d', 'gui': 'italic', 'ctermfg': '238', 'cterm': 'NONE' },
\    'Search': { 'guifg': '000000', 'guibg': 'e2d223', 'gui': 'underline', 'ctermfg': '232', 'ctermbg': '190', 'cterm': 'bold' },
\    'VertSplit': { 'guibg': '292929', 'ctermbg': 'NONE' }
\}

match ErrorMsg '\s\+$'
"───────────────────────────────────────────────────────────────────────────────
" }}}
"
" Plugin-specific settings {{{
"───────────────────────────────────────────────────────────────────────────────
" lightline
let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ 'active': {
    \   'right': [ [ 'words', 'lineinfo' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ] ],
    \    'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'words': 'WordCount',
    \   'readonly': 'ReadOnly',
    \ },
    \ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
    \ 'subseparator': { 'left': '│', 'right': '' }
\}
"───────────────────────────────────────────────────────────────────────────────
" vim-speeddating
nmap + <Plug>SpeedDatingUp
nmap - <Plug>SpeedDatingDown
xmap + g<Plug>SpeedDatingUp
xmap - g<C-X>
xmap + g<C-A>
nmap d+ <Plug>SpeedDatingNowUTC
nmap d- <Plug>SpeedDatingNowLocal
"───────────────────────────────────────────────────────────────────────────────
" vimwiki
let g:vimwiki_list = [{'index': 'index',
	\ 'ext': '.md' ,
	\ 'path': '~/owncloud/txtfiles/',
	\ 'path_html': '/domains/hardcorp/htdocs/txtfiles',
	\ 'syntax': 'markdown',
	\ 'template_path': '~/owncloud/txtfiles/templates/',
	\ 'template_default': 'default',
	\ 'template_ext': '.html',
	\ 'auto_toc': 1}]

" only apply wiki syntax to dirs in vimwiki-list
let g:vimwiki_global_ext = 0

" nested syntax
" let wiki.nested_syntaxes = {'ruby': 'ruby', 'python': 'python', 'c++': 'cpp', 'sh': 'sh', 'racket': 'racket'}
" alternate header colors
let g:vimwiki_hl_headers = 1

" do not ignore newlines in list items
let g:vimwiki_list_ignore_newline=0
" map <F4> :VimwikiAll2HTML<cr>
"───────────────────────────────────────────────────────────────────────────────
" rainbow parentheses
let g:rainbow_active = 1
"───────────────────────────────────────────────────────────────────────────────
" when calling vimpager, disable X11
let g:vimpager = {}
let g:less     = {}
let g:vimpager.passthrough = 0
let g:less.scrolloff = 10
let g:vimpager.X11 = 0
" vimpager seems to be enabling mouse, which I HATE
if exists('g:vimpager.enabled')
  if exists('g:vimpager.ptree')
    set mouse-=a
  endif
endif
"───────────────────────────────────────────────────────────────────────────────
" vim-mucomplete
let g:mucomplete#enable_auto_at_startup = 1
set belloff+=ctrlg " If Vim beeps during completion
set completeopt=menuone,noinsert,preview,longest
set shortmess+=c   " Shut off completion messages
"───────────────────────────────────────────────────────────────────────────────
"	vim-signify
let g:signify_vcs_list = [ 'hg', 'git' ]
let g:signify_line_highlight = 0
let g:signify_sign_delete    = '-'
"───────────────────────────────────────────────────────────────────────────────
"	vim-indent-guides
let g:indentLine_enabled = 1
let g:indentLine_color_tty_dark = 1
let g:indentLine_color_term = 239
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
" let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_faster = 1
let g:indentLine_setConceal = 0
augroup indent-guides
	autocmd!
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=black    ctermbg=232
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=235
augroup END
"───────────────────────────────────────────────────────────────────────────────
" litecorrect
augroup litecorrect
	autocmd!
	autocmd FileType markdown,mkd call litecorrect#init()
	autocmd FileType textile      call litecorrect#init()
	autocmd FileType mail         call litecorrect#init()
augroup END
"───────────────────────────────────────────────────────────────────────────────
" vim ansible
let g:ansible_options = {'ignore_blank_lines': 0}
augroup ansible
	autocmd!
	autocmd BufEnter *.yml :set ft=yaml.ansible
augroup END
"───────────────────────────────────────────────────────────────────────────────
" keeping these commented out for now - I never use nerdtree, but may try again someday...
"
" augroup NERDTree
"	autocmd!
"	let g:NERDTreeDirArrowExpandable = '▸'
"	let g:NERDTreeDirArrowCollapsible = '▾'
"	let g:NERDTreeCaseSensitiveSort = '1'
"	let g:NERDTreeShowBookmarks = '1'
"	let NERDTreeShowLineNumbers=1
"	let NERDTreeShowHidden=1
"	map <silent> <Leader>n :NERDTreeToggle<CR>
"	nmap <silent> B :NERDTreeToggle<CR>
"	let g:nerdtree_tabs_open_on_gui_startup = 1
"	let g:nerdtree_tabs_open_on_console_startup = 2
"	autocmd FileType nerdtree setlocal nolist
"	autocmd FileType nerdtree silent! exec "normal :%s/\s\+$//<CR>"
"	set fillchars+=vert:│                       " nicer looking vertical fill character
"	set relativenumber
"	" prep for mouse selection
"	nnoremap <silent> <Leader>m  <ESC>:set nolist<CR>:set nonu<CR>:set norelativenumber<CR>:NERDTreeClose<CR>:SignifyDisable<CR>
" augroup END
"───────────────────────────────────────────────────────────────────────────────
augroup Swapit
	autocmd!
	autocmd BufEnter * if exists(":SwapList") | SwapList en_dis enabled disabled
	autocmd BufEnter * if exists(":SwapList") | SwapList up_down up down
	autocmd BufEnter * if exists(":SwapList") | SwapList cloud_local cloud local
	autocmd BufEnter * if exists(":SwapList") | SwapList n_s north south
	autocmd BufEnter * if exists(":SwapList") | SwapList e_w east west
augroup END
"───────────────────────────────────────────────────────────────────────────────
" " startify options
" let g:startify_files_number = 30
" let g:WebDevIconsUnicodeGlyphDoubleWidth = 0
" " startify colors
" highlight StartifyBracket ctermfg=240
" highlight StartifyFooter  ctermfg=240
" highlight StartifyHeader  ctermfg=114
" highlight StartifyNumber  ctermfg=215
" highlight StartifyPath    ctermfg=245
" highlight StartifySlash   ctermfg=240
" highlight StartifySpecial ctermfg=240
"───────────────────────────────────────────────────────────────────────────────
" jellybeans
let g:jellybeans_use_term_italics = 1
"───────────────────────────────────────────────────────────────────────────────
" ale is nice but slow
let g:ale_enabled=0
nnoremap <Leader>l :ALEToggle<CR>
"───────────────────────────────────────────────────────────────────────────────
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
"───────────────────────────────────────────────────────────────────────────────
let g:vmt_cycle_list_item_markers = 1
"───────────────────────────────────────────────────────────────────────────────
"
" }}}
"
" Abbreviations {{{
"───────────────────────────────────────────────────────────────────────────────
iab XA X-Attachment: none
iab DATE <C-R>=strftime("%a %b %d %T %Z %Y")<CR>
iab TD <C-R>=strftime("%m/%d/%Y")<CR>
iab br <br />
"───────────────────────────────────────────────────────────────────────────────
" }}}
"
" User Commands {{{
"───────────────────────────────────────────────────────────────────────────────
if has('user_commands')
	" fix common typos
	command! -bang -nargs=? -complete=file E e<bang> <args>
	command! -bang -nargs=? -complete=file W w<bang> <args>
	command! -bang -nargs=? -complete=file Wq wq<bang> <args>
	command! -bang -nargs=? -complete=file WQ wq<bang> <args>
	command! -bang Wa wa<bang>
	command! -bang WA wa<bang>
	command! -bang Q q<bang>
	command! -bang QA qa<bang>
	command! -bang Qa qa<bang>
	cnoremap q1 q!
	cnoremap qa1 qa!

	" forget to sudo? :ww!
	cnoremap ww! w !sudo tee % >/dev/null

	"diff with original file
	command!  DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

endif
"───────────────────────────────────────────────────────────────────────────────
" }}}
"
" experimental stuff {{{
"───────────────────────────────────────────────────────────────────────────────
" stuff to try out before making permanent goes here
"
function! StripWhitespace()
    " Don't strip on these filetypes
	if &ft =~ 'vimwiki\|ruby\|javascript\|perl\|markdown\|make'
        return
    endif
    %s/\s\+$//e
	%s/ \+\ze\t//ge
endfunction

augroup CleanUpWhiteSpace
	autocmd!
	autocmd BufWritePre * call StripWhitespace()
augroup END

"───────────────────────────────────────────────────────────────────────────────
nnoremap <silent> <C-k> :call append(line('.')-1, '')<CR>k
nnoremap <silent> <C-j> :call append(line('.'), '')<CR>j
"───────────────────────────────────────────────────────────────────────────────
vmap <unique> <up>    <Plug>SchleppUp
vmap <unique> <down>  <Plug>SchleppDown
vmap <unique> <left>  <Plug>SchleppLeft
vmap <unique> <right> <Plug>SchleppRight
vmap <unique> D       <Plug>SchleppDup
let g:Schlepp#dupTrimWS = 1
"───────────────────────────────────────────────────────────────────────────────
"
" }}}
"
" vim:foldmethod=marker:foldlevel=1:colorcolumn=0:nowrap
