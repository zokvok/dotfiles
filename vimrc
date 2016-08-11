" G" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'tmhedberg/matchit'
Plugin 'vim-scripts/indentpython.vim'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-sensible'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'shougo/neocomplete.vim'
Plugin 'klen/python-mode'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" End Vundle

" Setting some decent VIM settings for programming

set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set background=dark             " Use colours that work well on a dark background (Console is usually black)
set showmode                    " show the current mode
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
syntax on                       " turn syntax highlighting on by default

" Show EOL type and last modified timestamp, right after the filename
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P

"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
	"Set UTF-8 as the default encoding for commit messages
	autocmd BufReadPre COMMIT_EDITMSG,git-rebase-todo setlocal fileencodings=utf-8

	"Remember the positions in files with some git-specific exceptions"
	autocmd BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$")
				\           && expand("%") !~ "COMMIT_EDITMSG"
				\           && expand("%") !~ "ADD_EDIT.patch"
				\           && expand("%") !~ "addp-hunk-edit.diff"
				\           && expand("%") !~ "git-rebase-todo" |
				\   exe "normal g`\"" |
				\ endif

	autocmd BufNewFile,BufRead *.patch set filetype=diff
	autocmd BufNewFile,BufRead *.diff set filetype=diff

	autocmd Syntax diff
				\ highlight WhiteSpaceEOL ctermbg=red |
				\ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

	autocmd Syntax gitcommit setlocal textwidth=74
endif " has("autocmd")

inoremap jk <Esc>
set number
set shortmess+=I
set backspace=indent,eol,start
set wildmode=longest,list
nnoremap Y y$
nnoremap <Return> o<Esc>
nnoremap <S-Return> O<Esc>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

if has('gui_running')
	set background=dark
	colorscheme solarized
else
	colorscheme zenburn
endif

" Python
set foldmethod=indent
set foldlevel=99
set encoding=utf-8
highlight BadWhitespace ctermbg=red guibg=darkred
let python_highlight_all=1
syntax on

au BufNewFile,BufRead *.py
			\ set tabstop=4 |
			\ set softtabstop=4 |
			\ set shiftwidth=4 |
			\ set textwidth=79 |
			\ set expandtab |
			\ set autoindent |
			\ set fileformat=unix |

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

au BufNewFile,BufRead *.js, *.html, *.css
			\ set tabstop=2 |
			\ set softtabstop=2 |
			\ set shiftwidth=2 |

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF

if has("user_commands")
    command! -bang -nargs=? -complete=file E e<bang> <args>
    command! -bang -nargs=? -complete=file W w<bang> <args>
    command! -bang -nargs=? -complete=file Wq wq<bang> <args>
    command! -bang -nargs=? -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif

set hlsearch

autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
nnoremap J mzJ`z
set wildmode=longest:list
