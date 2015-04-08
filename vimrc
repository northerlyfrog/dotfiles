" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Add runtime path manipulation for pathogen
execute pathogen#infect()

set background=dark " set the background to dark

" Disable nerdtree on startup
let g:nerdtree_tabs_open_on_gui_startup = 0

" Close vim if NERDTreee is the only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Shortcut for opening NERDTree
map <C-m> : NERDTreeToggle<CR>
map <C-CR> : NERDTreeMapActivateNode<CR>

" Set up syntastic Checkers

let g:syntastic_cpp_check_header = 1 " C++
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_css_checkers = ["csslint","phpcs"] "CSS
let g:syntastic_go_checkers = ["go","golint"] " Go
let g:syntastic_html_checkers = ["jshint"] " Html
let g:syntastic_java_checkers = ["javac"] " Java
let g:syntastic_javascript_checkers = ["jshint"] " JavaScript
let g:syntastic_json_checkers = ["jsonval"] " JSON
let g:syntastic_markdown_checkers = ["mdl"] " Markdown
let g:syntastic_perl_checkers = ["perl"] " Perl
let g:syntastic_php_checkers = ["php","phplint"] " PHP
let g:syntastic_xHTML_checkers = ["jshint"] " xHTML
let g:syntastic_xml_checkers = ["xmllint"] " XML

" Set color scheme!
colorscheme spacegray

" Use the OS clipboard by default (when available)
set clipboard=unnamed

" Set syntax on
syntax enable 

" Turn on the manual pages
runtime ftplugin/man.vim

set autoindent " Turn autoindent on

set wrap
set linebreak
set nolist "list disables linebreak
set textwidth=0
set wrapmargin=0
set formatoptions+=1

set showmatch " Show matches for braces, parens, etc.

set sessionoptions-=options " Turn default capturing global options off

" Enable syntax highlighting with unknown extensions
au BufNewFile,BufRead *.xyz setf c

" Enhance command-line completion
set wildmenu


set spelllang=en_us " English spellchecking

" Allow cursor keys in insert mode
set esckeys

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Optimize for fast terminal connections
set ttyfast

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
  set undodir=~/.vim/undo
endif

set viminfo+=! " make sure vim history works

set secure " disable unsafe commands

" Highlight current line
set cursorline

" Make tabs 4 spaces
set tabstop=2

set shiftwidth=2 " 2 char indention

set shiftround " Indent/Dedent to nearest 4-char boundary

set autoindent " Automatically indent when adding a new line.

" Enable line numbers
set number

" Show invisible characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_,precedes:«,extends:»
set list

" Highlight searches
set hlsearch

" Highlight dynamically as pattern is typed
set incsearch

" Always show status line
set laststatus=2

" Don't reset cursor to start of line when moving around
set nostartofline

" Show cursor position
set ruler

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

" Show the (partial) command as it's being typed
set showcmd

" Set ignorecase and smartcase for smart searching
" all lower case ignores cases, Any Caps uses smart searching
set ignorecase
set smartcase

" Set scrolloff options
set scrolloff=10

" Set wildmode up
set wildmode=longest,list

" Don’t show the intro message when starting Vim
set shortmess=atI

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=500		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  autocmd BufNewFile,BufRead *.json set ft=javascript

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=100

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
