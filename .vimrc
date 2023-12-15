" designed for vim 8+

if has("eval")                               " vim-tiny lacks 'eval'
  let skip_defaults_vim = 1
endif

set nocompatible

"####################### Vi Compatible (~/.exrc) #######################

" automatically indent new lines
set autoindent

" automatically write files when changing when multiple files open
set autowrite

" deactivate line numbers
" set nonumber
set number

" turn col and row position on in bottom right
set ruler " see ruf for formatting

" show command and insert mode
set showmode

set tabstop=4

set splitright

"#######################################################################

" disable visual bell (also disable in .inputrc)
set t_vb=

let mapleader=" "

set softtabstop=4

" mostly used with >> and <<
set shiftwidth=4

set smartindent

set smarttab

if v:version >= 800
  " stop vim from silently messing with files that it shouldn't
  set nofixendofline

  " better ascii friendly listchars
  set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>

  " i hate automatic folding
  set foldmethod=manual
  set nofoldenable
endif

" mark trailing spaces as errors
" match IncSearch '\s\+$'

"
set termguicolors
colorscheme ghdark

"

" enough for line numbers + gutter within 80 standard
set textwidth=72
"set colorcolumn=73

" replace tabs with spaces automatically
set expandtab

" enable relative line numbers
set relativenumber

" disable signcolumn
set signcolumn=no

" makes ~ effectively invisible
"highlight NonText guifg=bg

" turn on default spell checking
"set spell

" disable spellcapcheck
set spc=

" more risky, but cleaner
set nobackup
set noswapfile
set nowritebackup

set icon

" center the cursor always on the screen
"set scrolloff=999

" highlight search hits
set hlsearch
set incsearch
set linebreak

" avoid most of the 'Hit Enter ...' messages
set shortmess=aoOtTI

" prevents truncated yanks, deletes, etc.
set viminfo='20,<1000,s1000

set backspace=indent,eol,start

" wrap around when searching
set wrapscan
set nowrap

set fo-=t   " don't auto-wrap text using text width
set fo+=c   " autowrap comments using textwidth with leader
set fo-=r   " don't auto-insert comment leader on enter in insert
set fo-=o   " don't auto-insert comment leader on o/O in normal
set fo+=q   " allow formatting of comments with gq
set fo-=w   " don't use trailing whitespace for paragraphs
set fo-=a   " disable auto-formatting of paragraph changes
set fo-=n   " don't recognized numbered lists
set fo+=j   " delete comment prefix when joining
set fo-=2   " don't use the indent of second paragraph line
set fo-=v   " don't use broken 'vi-compatible auto-wrapping'
set fo-=b   " don't use broken 'vi-compatible auto-wrapping'
set fo+=l   " long lines not broken in insert mode
set fo+=m   " multi-byte character line break support
set fo+=M   " don't add space before or after multi-byte char
set fo-=B   " don't add space between two multi-byte chars
set fo+=1   " don't break a line after a one-letter word

" stop complaints about switching buffer with changes
set hidden

" command history
set history=100

" faster scrolling
set ttyfast

" allow sensing the filetype
filetype plugin on

" high contrast for streaming, etc.
set background=dark

" base default color changes (gruvbox dark friendly)
hi StatusLine ctermfg=black ctermbg=NONE
hi StatusLineNC ctermfg=black ctermbg=NONE
hi Normal ctermbg=NONE
hi Special ctermfg=cyan
hi LineNr ctermfg=black ctermbg=NONE
hi SpecialKey ctermfg=black ctermbg=NONE
hi ModeMsg ctermfg=black cterm=NONE ctermbg=NONE
hi MoreMsg ctermfg=black ctermbg=NONE
hi NonText ctermfg=black ctermbg=NONE
hi vimGlobal ctermfg=black ctermbg=NONE
hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
hi Error ctermbg=234 ctermfg=darkred cterm=NONE
hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
hi Search ctermbg=236 ctermfg=darkred
hi vimTodo ctermbg=236 ctermfg=darkred
hi Todo ctermbg=236 ctermfg=darkred
hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
hi MatchParen ctermbg=236 ctermfg=darkred

" color overrides
"au FileType * hi StatusLine ctermfg=black ctermbg=NONE
"au FileType * hi StatusLineNC ctermfg=black ctermbg=NONE
"au FileType * hi Normal ctermbg=NONE
"au FileType * hi Special ctermfg=cyan
"au FileType * hi LineNr ctermfg=black ctermbg=NONE
"au FileType * hi SpecialKey ctermfg=black ctermbg=NONE
"au FileType * hi ModeMsg ctermfg=black cterm=NONE ctermbg=NONE
"au FileType * hi MoreMsg ctermfg=black ctermbg=NONE
"au FileType * hi NonText ctermfg=black ctermbg=NONE
"au FileType * hi vimGlobal ctermfg=black ctermbg=NONE
"au FileType * hi goComment ctermfg=black ctermbg=NONE
"au FileType * hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
"au FileType * hi Error ctermbg=234 ctermfg=darkred cterm=NONE
"au FileType * hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
"au FileType * hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
"au FileType * hi Search ctermbg=236 ctermfg=darkred
"au FileType * hi vimTodo ctermbg=236 ctermfg=darkred
"au FileType * hi Todo ctermbg=236 ctermfg=darkred
"au FileType * hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
"au FileType * hi MatchParen ctermbg=236 ctermfg=darkred
"au FileType markdown,pandoc hi Title ctermfg=yellow ctermbg=NONE
"au FileType markdown,pandoc hi Operator ctermfg=yellow ctermbg=NONE
"au FileType markdown,pandoc set tw=0
"au FileType yaml hi yamlBlockMappingKey ctermfg=NONE
"au FileType yaml set sw=2
"au FileType bash set sw=2
"au FileType c set sw=8
"au FileType markdown,pandoc noremap j gj
"au FileType markdown,pandoc noremap k gk
au Syntax c source $HOME/vimfiles/syntax/c.vim
au Syntax cpp source $HOME/vimfiles/syntax/c.vim
syntax enable
set cinoptions+=:0

filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Edit/Reload vimrc configuration file
nnoremap confe :e $HOME/.vimrc<CR>
nnoremap confr :source $HOME/.vimrc<CR>

set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

" only load plugins if Plug detected
" if filereadable(expand("~/.vim/autoload/plug.vim"))
if filereadable(expand("$HOME/vimfiles/autoload/plug.vim"))

  " github.com/junegunn/vim-plug

  call plug#begin('~/.local/share/vim/plugins')
  Plug 'zah/nim.vim'
  Plug 'conradirwin/vim-bracketed-paste'
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'rwxrob/vim-pandoc-syntax-simple'
  Plug 'preservim/nerdtree'
  call plug#end()

  "
  call plug#begin('~/.vim/plugged')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'mattn/emmet-vim'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'mmai/vim-zenmode'
  "Plug 'SirVer/ultisnips'
  "Plug 'honza/vim-snippets'
  Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
  Plug 'junegunn/fzf.vim'
  Plug 'bfrg/vim-cpp-modern'
  Plug 'ervandew/supertab'
  Plug 'zackhsi/fzf-tags'
  call plug#end()

else
  autocmd vimleavepre *.go !gofmt -w % " backup if fatih fails
endif

" make Y consitent with D and C (yank til end)
map Y y$

" better command-line completion
set wildmenu

" disable search highlighting with <C-L> when refreshing screen
nnoremap <C-L> :nohl<CR><C-L>

" enable omni-completion
set omnifunc=syntaxcomplete#Complete

" force some files to be specific file type
au bufnewfile,bufRead $SNIPPETS/md/* set ft=pandoc
au bufnewfile,bufRead $SNIPPETS/sh/* set ft=sh
au bufnewfile,bufRead $SNIPPETS/bash/* set ft=bash
au bufnewfile,bufRead $SNIPPETS/go/* set ft=go
au bufnewfile,bufRead $SNIPPETS/c/* set ft=c
au bufnewfile,bufRead $SNIPPETS/html/* set ft=html
au bufnewfile,bufRead $SNIPPETS/css/* set ft=css
au bufnewfile,bufRead $SNIPPETS/js/* set ft=javascript
au bufnewfile,bufRead $SNIPPETS/python/* set ft=python
au bufnewfile,bufRead $SNIPPETS/perl/* set ft=perl
au bufnewfile,bufRead user-data set ft=yaml
au bufnewfile,bufRead meta-data set ft=yaml
au bufnewfile,bufRead keg set ft=yaml
au bufnewfile,bufRead *.bash* set ft=bash
au bufnewfile,bufRead *.{peg,pegn} set ft=config
au bufnewfile,bufRead *.gotmpl set ft=go
au bufnewfile,bufRead *.profile set filetype=sh
au bufnewfile,bufRead *.crontab set filetype=crontab
au bufnewfile,bufRead *ssh/config set filetype=sshconfig
au bufnewfile,bufRead .dockerignore set filetype=gitignore
au bufnewfile,bufRead *gitconfig set filetype=gitconfig
au bufnewfile,bufRead /tmp/psql.edit.* set syntax=sql
au bufnewfile,bufRead *.go set spell spellcapcheck=0
au bufnewfile,bufRead commands.yaml set spell
au bufnewfile,bufRead *.txt set spell

" displays all the syntax rules for current position, useful
" when writing vimscript syntax plugins
if has("syntax")
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
endif

" Colors
let g:colors = getcompletion('', 'color')
func! NextColor()
    let idx = index(g:colors, g:colors_name)
    return (idx + 1 >= len(g:colors) ? g:colors[0] : g:colors[idx + 1])
endfunc

func! PrevColor()
    let idx = index(g:colors, g:colors_name)
    return (idx - 1 < 0 ? g:colors[-1] : g:colors[idx - 1])
endfunc

" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" functions keys
map <F1> :set number!<CR> :set relativenumber!<CR>
nmap <F2> :call <SID>SynStack()<CR>
set pastetoggle=<F3>
map <F4> :set list!<CR>
map <F5> :set cursorline!<CR>
map <F7> :set spell!<CR>
noremap <F9> :exe "colo " .. NextColor()<CR>:colorscheme<CR>
noremap <F10> :exe "colo " .. PrevColor()<CR>:colorscheme<CR>
map <F12> :set fdm=indent<CR>

if has('win32')
    " noremap <silent> <A-b> :echo system(findfile('build.bat', ';'))<CR>
    :let g:asyncrun_open = 8
    noremap <silent> <A-b> :AsyncRun Build.bat<CR>
    noremap <silent> <A-t> :AsyncRun GenerateTags.bat<CR>
endif

nmap <leader>2 :set paste<CR>i

" Better page down and page up
noremap <C-n> <C-d>
noremap <C-p> <C-b>

" Fuzzy finder
map <leader>sf :FZF<CR>
"map <leader>sg :Rg<CR>
map <leader>sg :Tags<CR>
map <leader>/ :BTags<CR>

" Coc Goto
" nmap gd <Plug>(coc-definition)
" nmap gr <Plug>(coc-references)
"inoremap <Tab> <Plug>(coc-completion)
"inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
let g:coc_enabled = 0

" CTags
" nnoremap gd <C-]>
function! FollowTag()
    if !exists("w:tagbrowse")
        vsplit
        let w:tagbrowse=1
    endif
    execute "tag " . expand("<cword>")
endfunction

nnoremap gd :call FollowTag()<CR>
