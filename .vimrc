if has("eval")
  let skip_defaults_vim = 1
endif

set nocompatible

set autoindent

set autowrite
set autoread

set number

set ruler

" show command and insert mode
set showmode

set tabstop=4

set splitright

set ignorecase

" disable visual bell (also disable in .inputrc)
set t_vb=

let mapleader=" "

set softtabstop=4

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
match IncSearch '\s\+$'

set termguicolors
colorscheme hybrid

set textwidth=72

set expandtab

set norelativenumber

set signcolumn=no

set spc=

" more risky, but cleaner
set nobackup
set noswapfile
set nowritebackup

set icon

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

set background=dark

if has('win32')
    au Syntax c source $HOME/vimfiles/syntax/c.vim
    au Syntax cpp source $HOME/vimfiles/syntax/cpp.vim
else
    au Syntax c source ~/.vim/syntax/c.vim
    au Syntax cpp source ~/.vim/syntax/cpp.vim
endif

syntax enable
set cinoptions+=:0

filetype plugin on

set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

" only load plugins if Plug detected
"if filereadable(expand("$HOME/vimfiles/autoload/plug.vim"))
if filereadable(expand("~/.vim/autoload/plug.vim"))

  call plug#begin('~/.vim/plugged')
  "Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'skywind3000/asyncrun.vim'
  Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
  Plug 'junegunn/fzf.vim'
  Plug 'zackhsi/fzf-tags'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'mnishz/colorscheme-preview.vim'
  Plug 'ervandew/supertab'
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  Plug 'tikhomirov/vim-glsl'
  "Plug 'psliwka/vim-smoothie'
  call plug#end()

endif

autocmd! BufNewFile,BufRead *.vs,*.fs,*.glsl set ft=glsl

" make Y consistent with D and C (yank til end)
map Y y$

" better command-line completion
set wildmenu

" disable search highlighting with <C-L> when refreshing screen
nnoremap <C-L> :nohl<CR><C-L>

" enable omni-completion
set omnifunc=syntaxcomplete#Complete
set omnifunc=ccomplete#Complete

" get the parameters of a function and put it in a popup using ctags
func GetFuncParamsFromTag()
    silent write
    " jump to tag under cursor
    silent execute "normal \<c-]>"
    " if there is '(' on the same line, it may be a function
    if search('(', "n") == winsaveview()["lnum"]
        " yank the function's name and parameters
        silent execute "normal v/)\<cr>y\<c-t>"
        " remove any previouslypresent popup
        call popup_clear()
        " make the popup spawn above/below the cursor
        call popup_atcursor(getreg('0'), #{moved: [0, 80], highlight: 'WildMenu'})
    endif
endfunc

nnoremap <silent> <leader>? :call GetFuncParamsFromTag()<cr>

" Quickfix
let g:quickfix_open = 0
function! ToggleQuickFix()
    if g:quickfix_open
        let g:quickfix_open = 0
        :cclose
    else
        let g:quickfix_open = 1
        :copen
    endif
endfunction
noremap <silent> <Leader>q :call ToggleQuickFix()<CR>
noremap <silent> <A-n> :cn<CR>
noremap <silent> <A-N> :cp<CR>

" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" function keys
map <F1> :set number!<CR>
"map <F1> :set number!<CR> :set relativenumber!<CR>
set pastetoggle=<F3>
map <F4> :set list!<CR>
map <F5> :set cursorline!<CR>
map <F5> :!cscope -Rb<CR>:cs reset<CR><CR>
map <F7> :set spell!<CR>

noremap <C-y> "+y
set clipboard=unnamed

if has('win32')
    noremap <silent> <A-b> :AsyncRun Build.bat<CR>
    noremap <silent> <A-t> :AsyncRun GenerateTags.bat<CR>
else
    noremap <silent> <A-b> :ASyncRun build.sh<CR>
    noremap <silent> <A-t> :echom "Generating tags.."<CR> :!ctags -R .<CR>
endif

nmap <leader>2 :set paste<CR>i

" Fuzzy finder
map <leader>sf :FZF<CR>
"map <leader>sg :Rg<CR>
map <leader>sg :Tags<CR>
map <leader>/ :BTags<CR>
map <leader><Space> :Buffers<CR>

" Coc Goto
" nmap gd <Plug>(coc-definition)
" nmap gr <Plug>(coc-references)
"inoremap <Tab> <Plug>(coc-completion)
"inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" CTags
nnoremap gd <C-]>

" Move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
