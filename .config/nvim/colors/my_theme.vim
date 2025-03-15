" Vim color scheme based on provided Emacs config and color palette

set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "emacs_custom"

" Color definitions (from your provided list)
let s:bg           = "#052329"
let s:default_fg   = "#D0C0A0"
let s:comment      = "#40C040"
let s:string       = "#0FDFAF"
" let s:keyword      = "#80F0E0"
let s:keyword      = "#C8D4EC"
let s:function     = "#80F0E0"
" let s:function     = "#C8D4EC"
let s:variable     = "#C8D4EC"
let s:warning      = "#504038"
let s:visual_bg    = "#0010FF"
let s:cursor       = "#90C090"
let s:mode_line    = "#FFFFFF" " Bar color from list

" Basic highlighting
exec "hi Normal guifg=" . s:default_fg . " guibg=" . s:bg
exec "hi Comment guifg=" . s:comment . " gui=NONE"

" Syntax highlighting
exec "hi! link Keyword Statement"
exec "hi Statement guifg="  . s:keyword . " gui=NONE"
exec "hi Function guifg="   . s:function . " gui=NONE"
exec "hi String guifg="     . s:string . " gui=NONE"
exec "hi Identifier guifg=" . s:variable . " gui=NONE"
exec "hi WarningMsg guifg=" . s:warning . " gui=NONE"
" hi Type      guifg=#80F0E0 gui=NONE
" hi cUserType guifg=#80F0E0 gui=NONE
hi Type      guifg=#C8D4EC gui=NONE
hi cUserType guifg=#C8D4EC gui=NONE

" Interface elements
exec "hi Visual guibg=" . s:visual_bg
exec "hi Cursor guifg=" . s:cursor
exec "hi StatusLine guifg=" . s:mode_line . " guibg=" . s:bg . " gui=reverse"
exec "hi! link ModeMsg StatusLine" 

" Optional extras from your list
exec "hi Constant guifg=#80F0E0"
exec "hi PreProc guifg=#B0FFB0"
exec "hi Special guifg=#20D0E0"

set cursorline
hi CursorLine guibg=#183848        " Margin color
hi CursorColumn guibg=#183848

" Custom mappings
nnoremap <C-CR> :w<CR>
inoremap <C-CR> <Esc>:w<CR>a
