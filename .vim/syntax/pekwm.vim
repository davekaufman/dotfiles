" PekWM syntax file
" Language:     Vim 6.1 script
" Author:       Alexandra Walford <chroma@delusion.de>
" Last Change:  14 January, 2003
" Version:      182

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NOTE: this version is compatible with CVS as at 14 Jan 2003!  I will        "
" probably be updating it again towards the end of February 2003 - feel free  "
" to mail me with bugs and changes.                                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" The latest version can be found at http://nova.hn.org/files/pekwm.vim

" Check out http://nova.hn.org/config.html for an example of a highlighted
" file.

" Known bugs:
" · keywords are recognised in places they shouldn't be (e.g., boolean in an
"   option that isn't boolean)
" · automatically quits if you're not using version 6 or higher; get with the
"   program, 5.x people!
" · probably doesn't have all the theme keywords/blocks - especially the
"   actions

" First copy this file into ~/.vim/syntax/, then add something like these
" lines to ~/.vim/filetype.vim to get your files recognised automatically:
"   augroup filetypedetect
"     au! BufNewFile,BufRead */\(.\|\)pekwm/\(autoprops\|config\|keys\|menu\|mouse\|themes/*/theme\) setfiletype pekwm
"   augroup END

if version < 600
  syntax clear
  finish " bailing here because it's all just waaay tooo haaard
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

" Generic objects {{{1

syn match   pekBoolean  /"\(True\|False\)"/hs=s+1,he=e-1
syn match   pekNumber   /"\<[0-9]*\>"/hs=s+1,he=e-1
syn region  pekComment  start=/#/             end=/$/ containedin=ALLBUT,pekThemeString
syn match   pekCoords   /"\<[0-9]*x[0-9]*\>"/hs=s+1,he=e-1
syn match   pekEnvVar   /\$\<\a\+\>/
syn match   pekEscape   /[\[\](|)?*+\.]/     containedin=pekAutopropWinclass,pekAutopropString

" Highlighting {{{1

hi link pekRegion       Statement
hi link pekKeywords     Type
hi link pekIdentifier   Identifier
hi link pekConst        String
hi link pekEscape       Special

hi link pekComment      Comment
hi link pekNumber       pekConst
hi link pekEnvVar       pekIdentifier
hi link pekBoolean      pekIdentifier
hi link pekCoords       pekIdentifier

if (expand("%:t") == "autoprops") " {{{1

  syn region  pekAutopropBlock            start=/{/ end=/}/                                                                         contained contains=ALLBUT,pekMouseRegion,pekMenuRegion,pekConfigFilesRegion,pekConfigScreenRegion,pekConfigHarbourRegion,pekConfigMoveResizeRegion,pekKeysRegion
  syn keyword pekAutopropProperty         Property                                                                                                  nextgroup=pekAutopropWinclass
  syn match   pekAutopropWinclass         /".*,.*"/hs=s+1,he=e-1                                                                                    nextgroup=pekAutopropBlock
  syn keyword pekAutopropKeywords         Shaded GroupBehind MaximizedVertical MaximizedHorizontal Sticky Border Titlebar Iconified                 nextgroup=pekBoolean
  syn keyword pekAutopropKeywords         Workspace AutoGroup Layer                                                                                 nextgroup=pekNumber
  syn keyword pekAutopropKeywords         ApplyOn                                                                                                   nextgroup=pekAutopropApplyOnKeywords
  syn match   pekAutopropApplyOnKeywords  /"\(Start\s*\|New\s*\|ReLoad\s*\|Workspace\s*\|Transient\s*\)\+"/hs=s+1,he=e-1
  syn keyword pekAutopropKeywords         Group Title                                                                                               nextgroup=pekAutopropString
  syn keyword pekAutopropKeywords         Position Size                                                                                             nextgroup=pekCoords
  syn match   pekAutopropString           /"\a*"/hs=s+1,he=e-1
  syn match   pekAutopropWinclassDel      /,/                                                                                       containedin=pekAutopropWinclass
  hi link pekAutopropWinclassDel pekEscape

  hi link pekAutopropWinclass             pekConst
  hi link pekAutopropString               pekConst
  hi link pekAutopropApplyOnKeywords      pekIdentifier
  hi link pekAutopropRegion               pekRegion
  hi link pekAutopropProperty             pekRegion
  hi link pekAutopropKeywords             pekKeywords

elseif (expand("%:t") == "config") " {{{1

  syn match   pekConfigFiles                        /Files\s*{/he=e-1                                                           contained         nextgroup=pekConfigFilesBlock
  syn region  pekConfigFilesBlock                   start=/Files\s*{/       end=/}/                                                       contains=pekConfigFiles,pekConfigFilesKeywords,pekConfigFilesString
  syn match   pekConfigFilesKeywords                /\(Keys\|Mouse\|Menu\|Start\|Theme\|AutoProps\)\s*=/he=e-1                  contained         nextgroup=pekConfigFilesString
  syn match   pekConfigFilesString                  /"[a-zA-Z0-9~\/._-]*"/hs=s+1,he=e-1                                         contained

  syn match   pekConfigMoveResize                   /MoveResize\s*{/he=e-1                                                                contained         nextgroup=pekConfigMoveResizeBlock
  syn region  pekConfigMoveResizeBlock              start=/MoveResize\s*{/  end=/}/                                                       contains=pekConfigMoveResize,pekConfigMoveResizeKeywords,pekNumber,pekBoolean
  syn match   pekConfigMoveResizeKeywords           /\(EdgeSnap\|FrameSnap\|WorkspaceWarp\)\s*=/he=e-1                          contained         nextgroup=pekNumber
  syn match   pekConfigMoveResizeKeywords           /\(OpaqueMove\|OpaqueResize\|GrabWhenResize\|WrapWorkspaceWarp\)\s*=/he=e-1 contained         nextgroup=pekBoolean

  syn match   pekConfigScreen                       /Screen\s*{/he=e-1                                                          contained         nextgroup=pekConfigScreenBlock
  syn region  pekConfigScreenBlock                  start=/Screen\s*{/      end=/}/                                                       contains=pekConfigScreen,pekConfigScreenKeywords,pekNumber,pekBoolean,pekConfigScreenFocusKeywords,pekConfigScreenFocus,pekConfigScreenPlacement
  syn match   pekConfigScreenKeywords               /\(Workspaces\|DoubleClickTime\)\s*=/he=e-1                                 contained         nextgroup=pekNumber
  syn match   pekConfigScreenKeywords               /ShowFrameList\s*=/he=e-1                                                   contained         nextgroup=pekBoolean
  syn match   pekConfigScreenFocus                  /Focus\s*{/he=e-1                                                           contained         nextgroup=pekConfigScreenFocusBlock
  syn region  pekConfigScreenFocusBlock             start=/Focus\s*{/       end=/}/                                                       contains=pekConfigScreenFocus,pekConfigScreenFocusKeywords,pekBoolean
  syn match   pekConfigScreenFocusKeywords          /\(Enter\|Leave\|Click\|New\)\s*=/he=e-1                                    contained         nextgroup=pekBoolean
  syn match   pekConfigScreenPlacement              /Placement\s*{/he=e-1                                                       contained         nextgroup=pekConfigScreenPlacementBlock
  syn region  pekConfigScreenPlacementBlock         start=/Placement\s*{/   end=/}/                                                       contains=pekConfigScreenPlacement,pekConfigScreenPlacementKeywords,pekConfigScreenPlacementSmart,pekScreenPlacementSmartKeywords,pekScreenPlacementSmartBlock,pekBoolean,pekConfigScreenPlacementModelKeywords,pekConfigScreenPlacementSmartKeywords
  syn match   pekConfigScreenPlacementKeywords      /Model\s*=/he=e-1                                                           contained         nextgroup=pekConfigScreenPlacementModelKeywords
  syn match   pekConfigScreenPlacementKeywords      /Row\s*=/he=e-1                                                             contained         nextgroup=pekBoolean
  syn match   pekConfigScreenPlacementModelKeywords /"\(Smart\s*\|MouseCentered\s*\|MouseTopLeft\s*\)\+"/hs=s+1,he=e-1          contained
  syn match   pekConfigScreenPlacementSmart         /Smart\s*{/he=e-1                                                           contained         nextgroup=pekConfigScreenPlacementSmartBlock
  syn region  pekConfigScreenPlacementSmartBlock    start=/Smart\s*{/       end=/}/                                                       contains=pekConfigScreenPlacementSmartKeywords,pekBoolean,pekConfigScreenPlacementSmart
  syn match   pekConfigScreenPlacementSmartKeywords /\(TopToBottom\|LeftToRight\|BottomToTop\|RightToLeft\)\s*=/he=e-1          contained         nextgroup=pekBoolean

  syn match   pekConfigHarbour                      /Harbour\s*{/he=e-1                                                         contained         nextgroup=pekConfigHarbourBlock
  syn region  pekConfigHarbourBlock                 start=/Harbour\s*{/     end=/}/                                                       contains=pekConfigHarbour,pekConfigHarbourKeywords,pekBoolean,pekConfigHarbourPlacement,pekConfigHarbourOrientation
  syn match   pekConfigHarbourKeywords              /\(OnTop\|MaximizeOver\)\s*=/he=e-1                                         contained         nextgroup=pekBoolean
  syn match   pekConfigHarbourKeywords              /Placement\s*=/he=e-1                                                       contained         nextgroup=pekConfigHarbourPlacement
  syn match   pekConfigHarbourPlacement             /"\(Right\|Left\|Bottom\|Top\)"/hs=s+1,he=e-1                               contained
  syn match   pekConfigHarbourKeywords              /Orientation\s*=/he=e-1                                                     contained         nextgroup=pekConfigHarbourOrientation
  syn match   pekConfigHarbourOrientation           /"\(TopToBottom\|LeftToRight\)"/hs=s+1,he=e-1                               contained

  hi link pekConfigFiles                            pekRegion
  hi link pekConfigFilesKeywords                    pekKeywords
  hi link pekConfigFilesRegion                      pekRegion
  hi link pekConfigFilesString                      pekConst
  hi link pekConfigMoveResize                       pekRegion
  hi link pekConfigMoveResizeKeywords               pekKeywords
  hi link pekConfigMoveResizeRegion                 pekRegion
  hi link pekConfigScreen                           pekRegion
  hi link pekConfigScreenFocus                      pekRegion
  hi link pekConfigScreenFocusKeywords              pekKeywords
  hi link pekConfigScreenFocusRegion                pekRegion
  hi link pekConfigScreenKeywords                   pekKeywords
  hi link pekConfigScreenPlacement                  pekRegion
  hi link pekConfigScreenPlacementKeywords          pekKeywords
  hi link pekConfigScreenPlacementModelKeywords     pekIdentifier
  hi link pekConfigScreenPlacementRegion            pekRegion
  hi link pekConfigScreenPlacementSmart             pekRegion
  hi link pekConfigScreenPlacementSmartKeywords     pekKeywords
  hi link pekConfigScreenPlacementSmartRegion       pekRegion
  hi link pekConfigScreenRegion                     pekRegion
  hi link pekConfigHarbour                          pekRegion
  hi link pekConfigHarbourKeywords                  pekKeywords
  hi link pekConfigHarbourOrientation               pekIdentifier
  hi link pekConfigHarbourPlacement                 pekIdentifier
  hi link pekConfigHarbourRegion                    pekRegion

elseif (expand("%:t") == "keys") " {{{1

  syn keyword pekKeys         AlwaysBelow AlwaysOnTop Close Raise Iconify MaximizeHorizontal                              contained         nextgroup=pekKeysBlock
  syn keyword pekKeys         MaximizeVertical Maximize PrevInFrame PrevWorkspace NextInFrame                             contained         nextgroup=pekKeysBlock
  syn keyword pekKeys         NextWorkspace NextFrame PrevFrame LeftWorkspace RightWorkspace                                        contained         nextgroup=pekKeysBlock
  syn keyword pekKeys         Lower Shade Stick ToggleBorder ToggleDecor ToggleTitlebar                                   contained         nextgroup=pekKeysBlock
  syn keyword pekKeys         NudgeHorizontal NudgeVertical MoveToCorner GoToWorkspace                                    contained         nextgroup=pekKeysBlock
  syn keyword pekKeys         SendToWorkspace Exec Exit Restart Reload MoveClientPrev                                                   contained         nextgroup=pekKeysBlock
  syn keyword pekKeys         Kill RaiseAndActivate ActivateOrRaise MoveClientNext
  syn keyword pekKeys         ShowWindowMenu ShowRootMenu ShowIconMenu ShowGotoMenu HideAllMenus
  syn keyword pekKeys         ResizeVertical ResizeHorizontal RestartOther
  syn region  pekKeysBlock    start=/\(AlwaysBelow\|AlwaysOnTop\|Close\|Raise\|Iconify\|MaximizeHorizontal\)\s*{/ end=/}/           contains=pekKeys,pekKeysKey,pekKeysMod,pekKeysModArg,pekKeysGenArg,pekKeysParam
  syn region  pekKeysBlock    start=/\(MaximizeVertical\|Maximize\|PrevInFrame\|PrevWorkspace\|NextInFrame\)\s*{/ end=/}/           contains=pekKeys,pekKeysKey,pekKeysMod,pekKeysModArg,pekKeysGenArg,pekKeysParam
  syn region  pekKeysBlock    start=/\(NextWorkspace\|NextFrame\|PrevFrame\|LeftWorkspace\|RightWorkspace\)\s*{/  end=/}/           contains=pekKeys,pekKeysKey,pekKeysMod,pekKeysModArg,pekKeysGenArg,pekKeysParam
  syn region  pekKeysBlock    start=/\(Lower\|Shade\|Stick\|ToggleBorder\|ToggleDecor\|ToggleTitlebar\)\s*{/      end=/}/           contains=pekKeys,pekKeysKey,pekKeysMod,pekKeysModArg,pekKeysGenArg,pekKeysParam
  syn region  pekKeysBlock    start=/\(NudgeHorizontal\|NudgeVertical\|MoveToCorner\|GoToWorkspace\)\s*{/         end=/}/           contains=pekKeys,pekKeysKey,pekKeysMod,pekKeysModArg,pekKeysGenArg,pekKeysParam
  syn region  pekKeysBlock    start=/\(SendToWorkspace\|Exec\|Exit\|Restart\|Reload\|MoveClientPrev\)\s*{/        end=/}/           contains=pekKeys,pekKeysKey,pekKeysMod,pekKeysModArg,pekKeysGenArg,pekKeysParam
  syn region  pekKeysBlock    start=/\(Kill\|RaiseAndActivate\|ActivateOrRaise\|MoveClientNext\)/                 end=/}/           contains=pekKeys,pekKeysKey,pekKeysMod,pekKeysModArg,pekKeysGenArg,pekKeysParam
  syn region  pekKeysBlock    start=/\(ShowWindowMenu\|ShowRootMenu\|ShowIconMenu\|ShowGotoMenu\|HideAllMenus\)/  end=/}/           contains=pekKeys,pekKeysKey,pekKeysMod,pekKeysModArg,pekKeysGenArg,pekKeysParam
  syn region  pekKeysBlock    start=/\(ResizeVertical\|ResizeHorizontal\|RestartOther\)/                          end=/}/           contains=pekKeys,pekKeysKey,pekKeysMod,pekKeysModArg,pekKeysGenArg,pekKeysParam
  syn keyword pekKeysKey      Key                                                                                         contained         nextgroup=pekKeysGenArg
  syn keyword pekKeysMod      Mod                                                                                         contained         nextgroup=pekKeysModArg
  syn keyword pekKeysParam    Param                                                                                       contained         nextgroup=pekKeysGenArg
  syn match   pekKeysGenArg   /"[^"]*"/hs=s+1,he=e-1                                                                      contained
  syn match   pekKeysModArg   /"\(Alt\s*\|Shift\s*\|Ctrl\s*\|Mod[1-5]\s*\)\+"/hs=s+1,he=e-1                               contained

  hi link pekKeysGenArg       pekConst
  hi link pekKeysModArg       pekIdentifier
  hi link pekKeys             pekRegion
  hi link pekKeysKeywords     pekKeywords
  hi link pekKeysParam        pekKeywords
  hi link pekKeysMod          pekKeywords
  hi link pekKeysKey          pekKeywords

elseif (expand("%:t") == "menu") " {{{1

  syn keyword pekMenu             RootMenu                                                          contained         nextgroup=pekMenuBlock
  syn region  pekMenuBlock        start=/rootmenu\s*=\s*"[^"]*"\s*{/                        end=/}/           contains=pekMenu,pekSubmenu,pekSubmenuBlock,pekMenuItem,pekMenuItemBlock,pekMenuItemKeywords,pekMenuItemString
  syn keyword pekSubmenu          Submenu                                                           contained         nextgroup=pekSubmenuBlock
  syn region  pekSubmenuBlock     start=/Submenu\s*=\s*"[^"]*"\s*{/                         end=/}/           contains=pekSubmenu,pekSubmenuBlock,pekMenuItem,pekMenuItemBlock,pekMenuItemKeywords,pekMenuItemString
  syn keyword pekMenuItem         Exec Reload Restart RestartOther Exit                             contained         nextgroup=pekMenuItemBlock
  syn region  pekMenuItemBlock    start=/\(Exec\|Reload\|Restart\|RestartOther\|Exit\)\s*{/ end=/}/           contains=pekMenuItem,pekMenuItemKeywords,pekMenuItemString
  syn keyword pekMenuItemKeywords Name Param                                                        contained         nextgroup=pekMenuItemString
  syn match   pekMenuItemString   /"[^"]*"/hs=s+1,he=e-1                                            contained

  hi link pekMenuItemString       pekConst
  hi link pekMenu                 pekRegion
  hi link pekSubmenu              pekRegion
  hi link pekMenuItem             pekRegion
  hi link pekMenuItemKeywords     pekKeywords

elseif (expand("%:t") == "mouse") " {{{1

  syn keyword pekMouse            Frame Client Root                                                                       contained         nextgroup=pekMouseBlock
  syn region  pekMouseBlock       start=/\(Frame\|Client\|Root\)\s*{/        end=/}/                                                contains=pekMouse,pekMouseEvent,pekMouseButton,pekNumber,pekMouseAction,pekMouseMod,pekMouseModArg,pekMouseActionArg
  syn keyword pekMouseEvent       DoubleClick Click Motion                                                                contained
  syn region  pekMouseEventBlock  start=/\(DoubleClick\|Click\|Motion\)\s*{/ end=/}/                                                contains=pekMouseEvent,pekMouseButton,pekMouseAction,pekNumber,pekMouseMod,pekMouseModArg,pekMouseActionArg
  syn keyword pekMouseButton      Button                                                                                  contained         nextgroup=pekNumber
  syn keyword pekMouseAction      Action                                                                                  contained         nextgroup=pekMouseActionArg
  syn keyword pekMouseActionArg   Shade Raise ActivateClient Lower ShowWindowMenu NextInFrame PrevInFrame Move            contained
  syn keyword pekMouseActionArg   Resize GroupingDrag HideAllMenus ShowIconMenu ShowRootMenu LeftWorkspace RightWorkspace contained
  syn keyword pekMouseMod         Mod                                                                                     contained         nextgroup=pekMouseModArg
  syn match   pekMouseModArg      /"\(Alt\s*\|Shift\s*\|Ctrl\s*\|Mod[1-5]\s*\)\+"/hs=s+1,he=e-1                           contained

  hi link pekMouseActionArg       pekIdentifier
  hi link pekMouseModArg          pekIdentifier
  hi link pekMouse                pekRegion
  hi link pekMouseEvent           pekRegion
  hi link pekMouseButton          pekKeywords
  hi link pekMouseButton          pekKeywords
  hi link pekMouseAction          pekKeywords
  hi link pekMouseMod             pekKeywords

elseif (expand("%:t") == "theme") " {{{1

  syn keyword pekTheme                              Window                                                    contained         nextgroup=pekThemeWindowBlock
  syn region  pekThemeWindowBlock                   start=/Window\s*{/ end=/}/                                                            contains=pekTheme,pekThemeWindowKeywords,pekNumber,pekThemeWindowFont,pekThemeWindowFontKeywords,pekThemeWindowFontJustifyKeywords,pekThemeWindowFontBlock,pekThemeString,pekThemeWindowFocused,pekThemeWindowFocusedBlock,pekThemeWindowFocusedBorder,pekThemeWindowFocusedBorderBlock,pekThemeWindowFocusedBorderKeywords
  syn keyword pekThemeWindowKeywords                TitleHeight TitlePadding                                  contained         nextgroup=pekNumber
  syn keyword pekThemeWindowFont                    Font                                                      contained         nextgroup=pekThemeWindowFontBlock
  syn region  pekThemeWindowFontBlock               start=/Font\s*{/   end=/}/                                          contains=pekThemeWindowFont,pekThemeString,pekThemeJustifyKeywords,pekThemeWindowFontKeywords,pekThemeString
  syn keyword pekThemeWindowFontKeywords            Name
  syn match   pekThemeString                        /"[^"]*"/hs=s+1,he=e-1
  syn keyword pekThemeWindowFontKeywords            Justify                                                   contained         nextgroup=pekThemeJustifyKeywords
  syn match   pekThemeWindowFontJustifyKeywords     /"\(Center\|Left\|Right\)"/hs=s+1,he=e-1
  syn match   pekThemeWindowFocused                 /\<\(\(Un\|\)Focused\|Selected\)\s* {/he=e-1              contained         nextgroup=pekThemeWindowFocusedBlock
  syn region  pekThemeWindowFocusedBlock            start=/\(\(Un\|\)Focused\|Selected\)\s*{/ end=/}/                   contains=pekThemeWindowFocused,pekThemeWindowFocusedKeywords,pekThemeWindowFocusedImageString,pekThemeWindowFocusedImageSuffix,pekThemeString,pekThemeWindowFocusedBorder,pekThemeWindowFocusedBorderBlock,pekThemeWindowFocusedBorderKeywords
  syn keyword pekThemeWindowFocusedKeywords         Text                                                      contained         nextgroup=pekThemeString
  syn match   pekThemeWindowFocusedImageString      /"[^"]*\(:\(Tiled\|Fixed\|Scaled\)\)*"/hs=s+1,he=e-1                             contains=pekThemeWindowFocusedImageSuffix
  syn match   pekThemeWindowFocusedImageSuffix      /:\(Tiled\|Fixed\|Scaled\)/hs=s+1                                 contained
  syn keyword pekThemeWindowFocusedKeywords         Pixmap Separator                                                            nextgroup=pekThemeWindowFocusedImageString
  syn keyword pekThemeWindowFocusedBorder           Border                                                    contained
  syn region  pekThemeWindowFocusedBorderBlock      start=/Border\s*{/ end=/}/                                          contains=pekThemeWindowFocusedBorder,pekThemeWindowFocusedBorderKeywords
  syn keyword pekThemeWindowFocusedBorderKeywords   Top Side Bottom
  syn keyword pekThemeWindowButtons                 Buttons                                                   contained         nextgroup=pekThemeWindowButtonsBlock
  syn region  pekThemeWindowButtonsBlock            start=/Buttons\s*{/ end=/}/                                         contains=pekThemeWindowButtons,pekThemeWindowButtonsSideBlock,pekThemeWindowButtonsSide,pekThemeWindowButtonsSideActions,pekThemeWindowButtonsSideKeywords,pekThemeString
  syn keyword pekThemeWindowButtonsSide             Right Left
  syn region  pekThemeWindowButtonsSideBlock        start=/\(Right\|Left\)\s*{/ end=/}/                                         nextgroup=pekThemeWindowButtonsSide
  syn keyword pekThemeWindowButtonsSideKeywords     Actions                                                                     nextgroup=pekThemeWindowButtonsSideActions
  syn match   pekThemeWindowButtonsSideActions      /"\(\(None\|Close\|Iconify\|Maximize\(\|Vertical\|Horizontal\)\|Show\(Window\|Root\|Icon\)Menu\)\s*\)\+"/hs=s+1,he=e-1
  syn keyword pekThemeWindowButtonsSideKeywords     Pixmaps
  syn match   pekThemeHarbour                       /Harbour\s*{/he=e-1                                       contained         nextgroup=pekThemeHarbourBlock
  syn region  pekThemeHarbourBlock                  start=/Harbour\s*{/ end=/}/                                         contains=pekThemeHarbour,pekThemeWindowFocusedKeywords,pekThemeWindowFocusedImageString,pekThemeWindowFocusedImageSuffix
  syn keyword pekThemeRoot                          Root                                                      contained         nextgroup=pekThemeRootBlock
  syn region  pekThemeRootBlock                     start=/Root\s*{/ end=/}/                                            contains=pekThemeRoot,pekThemeRootKeywords,pekThemeString
  syn keyword pekThemeRootKeywords                  Command                                                   contained         nextgroup=pekThemeString
  syn keyword pekThemeMenu                          Menu                                                      contained         nextgroup=pekThemeMenuBlock
  syn region  pekThemeMenuBlock                     start=/Menu\s*{/ end=/}/                                            contains=pekThemeMenu,pekThemeString,pekThemeMenuKeywords,pekNumber,pekThemeWindowFontJustifyKeywords
  syn keyword pekThemeMenuKeywords                  Font TextColor Background BackgroundSelected BorderColor  contained         nextgroup=pekThemeString
  syn keyword pekThemeMenuKeywords                  Padding BorderWidth                                       contained         nextgroup=pekNumber
  syn keyword pekThemeMenuKeywords                  TextJustify                                               contained         nextgroup=pekThemeWindowFontJustifyKeywords

  hi link pekThemeWindowFontJustifyKeywords         pekIdentifier
  hi link pekThemeWindowFocusedImageSuffix          pekIdentifier
  hi link pekThemeWindowButtonsSideActions          pekIdentifier
  hi link pekThemeString                            pekConst
  hi link pekThemeWindowFocusedImageString          pekConst
  hi link pekThemeWindowFocused                     pekRegion
  hi link pekTheme                                  pekRegion
  hi link pekThemeWindowFont                        pekRegion
  hi link pekThemeWindowFocusedBorder               pekRegion
  hi link pekThemeWindowButtonsSide                 pekRegion
  hi link pekThemeWindowButtons                     pekRegion
  hi link pekThemeHarbour                           pekRegion
  hi link pekThemeRoot                              pekRegion
  hi link pekThemeMenu                              pekRegion
  hi link pekThemeWindowFocusedKeywords             pekKeywords
  hi link pekThemeWindowKeywords                    pekKeywords
  hi link pekThemeWindowFontKeywords                pekKeywords
  hi link pekThemeWindowFocusedBorderKeywords       pekKeywords
  hi link pekThemeWindowButtonsSideKeywords         pekKeywords
  hi link pekThemeRootKeywords                      pekKeywords
  hi link pekThemeMenuKeywords                      pekKeywords

endif " }}}1
