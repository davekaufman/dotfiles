" Vim color file
" Name:    gentooish.vim
" Author:  Brian Carper<brian@briancarper.net>
" Version: 0.4

set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let g:colors_name = "gentooish"

hi Boolean gui=NONE   guifg=#00ff00   guibg=NONE ctermfg=46 ctermfg=46
hi Comment gui=NONE   guifg=#666666   guibg=NONE term=bold ctermfg=241
hi Constant gui=NONE   guifg=#b8bb00   guibg=NONE term=underline ctermfg=142
hi CursorColumn gui=NONE   guifg=NONE      guibg=#222222 term=reverse ctermbg=235
hi Cursor gui=NONE   guifg=#000000   guibg=#8bff95 ctermfg=16 ctermbg=120
hi CursorLine gui=NONE   guifg=NONE      guibg=#222222 term=underline ctermbg=235
hi Directory gui=NONE   guifg=#8bff95   guibg=NONE term=bold ctermfg=120
hi Error gui=NONE   guifg=#990000   guibg=#000000 term=reverse ctermfg=88 ctermbg=16 term=reverse ctermfg=88 ctermbg=16
hi ErrorMsg gui=NONE   guifg=#cccccc   guibg=#863132 term=standout ctermfg=252 ctermbg=95
hi FoldColumn gui=NONE   guifg=#cccccc   guibg=#000000 term=standout ctermfg=252 ctermbg=16
hi Folded gui=NONE   guifg=#aaa400   guibg=#000000 term=standout ctermfg=142 ctermbg=16
hi Identifier gui=NONE   guifg=#4cbbd1   guibg=NONE term=underline ctermfg=74 term=underline ctermfg=74
hi Ignore gui=NONE   guifg=#555555 ctermfg=240 ctermfg=240
hi IncSearch gui=NONE   guifg=#000000   guibg=#8bff95 term=reverse ctermfg=16 ctermbg=120
hi lCursor  ctermfg=234 ctermbg=252
hi LineNr gui=NONE   guifg=#bbbbbb   guibg=#222222 term=underline ctermfg=250 ctermbg=235
hi lispList gui=NONE   guifg=#555555
hi MatchParen gui=NONE      guifg=#ffffff   guibg=#005500 term=reverse ctermfg=231 ctermbg=22
hi ModeMsg gui=NONE   guifg=#cccccc   guibg=NONE term=bold ctermfg=252
hi MoreMsg gui=NONE   guifg=#cccccc   guibg=NONE term=bold ctermfg=252
hi NonText gui=NONE   guifg=#555555   guibg=NONE term=bold ctermfg=240
hi Normal gui=NONE   guifg=#cccccc   guibg=#191919 ctermfg=252 ctermbg=234
hi Number gui=NONE   guifg=#ddaa66   guibg=NONE ctermfg=179 ctermfg=179
hi Pmenu gui=NONE   guifg=#cccccc   guibg=#222222 ctermfg=252 ctermbg=235
hi PmenuSbar gui=NONE   guifg=#cccccc   guibg=#000000 ctermfg=252 ctermbg=16
hi PMenuSel gui=BOLD   guifg=#c476f1   guibg=#000000
hi PmenuThumb gui=NONE   guifg=#cccccc   guibg=#333333 ctermfg=252 ctermbg=236
hi PreProc gui=NONE   guifg=#9a383a   guibg=NONE term=underline ctermfg=95 term=underline ctermfg=95
hi Question gui=NONE   guifg=#cccccc   guibg=NONE term=standout ctermfg=252
hi Search gui=NONE   guifg=#cccccc   guibg=#863132 term=reverse ctermfg=252 ctermbg=95
hi SignColumn  term=standout ctermfg=51 ctermbg=250
hi Special gui=NONE   guifg=#ffcd8b   guibg=NONE term=bold ctermfg=222 term=bold ctermfg=222
hi SpecialKey gui=NONE   guifg=#6f6f2f   guibg=NONE term=bold ctermfg=58
hi SpellBad gui=undercurl guisp=#cc6666 term=reverse cterm=undercurl ctermfg=167
hi SpellCap gui=undercurl guisp=#66cccc term=reverse cterm=undercurl ctermfg=80
hi SpellLocal gui=undercurl guisp=#cccc66 term=underline cterm=undercurl ctermfg=185
hi SpellRare gui=undercurl guisp=#cc66cc term=reverse cterm=undercurl ctermfg=170
hi Statement gui=NONE   guifg=#4cd169   guibg=NONE term=bold ctermfg=77 term=bold ctermfg=77
hi StatusLine gui=BOLD   guifg=#cccccc   guibg=#333333 term=bold,reverse cterm=bold ctermfg=252 ctermbg=236
hi StatusLineNC gui=NONE   guifg=#999999   guibg=#333333 term=reverse cterm=bold ctermfg=240 ctermbg=236
hi String gui=NONE   guifg=#5dff9e   guibg=#0f291a ctermfg=85 ctermbg=16 ctermfg=85 ctermbg=16
hi TabLineFill  term=reverse ctermfg=234 ctermbg=252
hi TabLineSel  term=bold cterm=bold
hi TabLine  term=underline cterm=underline ctermbg=248
hi Title gui=NONE   guifg=#9a383a   guibg=NONE term=bold ctermfg=95
hi Todo gui=NONE   guifg=#cccccc   guibg=#863132 term=standout ctermfg=252 ctermbg=95 term=standout ctermfg=252 ctermbg=95
hi Type gui=NONE   guifg=#c476f1   guibg=NONE term=underline ctermfg=177 term=underline ctermfg=177
hi Underlined gui=UNDERLINE   guifg=#cccccc   guibg=NONE term=underline cterm=underline ctermfg=252
hi Underlined gui=UNDERLINE   guifg=#cccccc   guibg=NONE term=underline cterm=underline ctermfg=252 term=underline cterm=underline ctermfg=252
hi User1 gui=BOLD   guifg=#999999   guibg=#333333 cterm=bold ctermfg=246 ctermbg=236
hi User2 gui=BOLD   guifg=#8bff95   guibg=#333333 cterm=bold ctermfg=120 ctermbg=236
hi VertSplit gui=NONE   guifg=#cccccc   guibg=#333333 term=reverse ctermfg=252 ctermbg=236
hi Visual gui=reverse guifg=#6e4287   guibg=#ffffff term=reverse ctermfg=231 ctermbg=60
hi VisualNOS gui=NONE   guifg=#cccccc   guibg=#000000 term=bold,underline ctermfg=252 ctermbg=16
hi WarningMsg gui=NONE   guifg=#cccccc   guibg=#863132 term=standout ctermfg=252 ctermbg=95
hi WildMenu gui=BOLD   guifg=#cf7dff   guibg=#1F0F29 term=standout cterm=bold ctermfg=177 ctermbg=16
if v:version >= 700
    hi SpellBad gui=undercurl guisp=#cc6666 term=reverse cterm=undercurl ctermfg=167
    hi SpellCap gui=undercurl guisp=#66cccc term=reverse cterm=undercurl ctermfg=80
    hi SpellRare gui=undercurl guisp=#cc66cc term=reverse cterm=undercurl ctermfg=170
    hi SpellLocal gui=undercurl guisp=#cccc66 term=underline cterm=undercurl ctermfg=185
    hi Pmenu gui=NONE   guifg=#cccccc   guibg=#222222 ctermfg=252 ctermbg=235
    hi PmenuSel  cterm=bold ctermfg=177 ctermbg=16
    hi PmenuSel  cterm=bold ctermfg=177 ctermbg=16
    hi PmenuSbar gui=NONE   guifg=#cccccc   guibg=#000000 ctermfg=252 ctermbg=16
    hi PmenuThumb gui=NONE   guifg=#cccccc   guibg=#333333 ctermfg=252 ctermbg=236
    hi MatchParen gui=NONE      guifg=#ffffff   guibg=#005500 term=reverse ctermfg=231 ctermbg=22
endif

" Diff
hi DiffAdd          guifg=#80a090           guibg=#313c36           gui=none
hi DiffAdd          ctermfg=108             ctermbg=22              cterm=none
hi DiffChange       guifg=#080808           guibg=#d7d700           gui=none
hi DiffChange       ctermfg=232             ctermbg=178             cterm=none
hi DiffDelete       guifg=#6c6661           guibg=#3c3631           gui=none
hi DiffDelete       ctermfg=59              ctermbg=52              cterm=none
hi DiffText         guifg=#444444           guibg=#d7af00           gui=bold
hi DiffText         ctermfg=238             ctermbg=184             cterm=bold
