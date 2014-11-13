" ----------------------------------------------------------------------------
" VIMRC
" ----------------------------------------------------------------------------

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"" Use comma instead of backslash
let mapleader=","
let maplocalleader=","

"" Load Pathogen
call pathogen#infect()

"" MacVim settings
if has("gui_macvim")
  let macvim_skip_cmd_opt_movement=1
  set fuoptions=maxvert,maxhorz
endif

"" commandline
if has('cmdline_info')
   set ruler                   " show the ruler
   set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
   set showcmd                 " show partial commands in status line
endif

"" gui
if has("gui_running")
  set guioptions-=T
  set guioptions-=m
  set guioptions-=L
  "set guioptions-=r
  set guifont=Monaco:h15
  " set guifont=Courier:h15
  "colorscheme desertEx
  "colorscheme github
  colorscheme solarized
  set background=light
end

" ----------------------------------------------------------------------------
" SETTINGS
" ----------------------------------------------------------------------------

syntax on

set expandtab               " expand tabs to spaces
set tabstop=4               " 4 Spaces for tabs
set shiftwidth=4            " number of spaces use for each step of indent
set softtabstop=4           " backspace removes tabs
set autoindent              " copy indent from current line when starting a new line
set visualbell              " don't beep
set autoread                " automatically re-read changed files
set showmatch               " briefly jump to a matching bracket
set incsearch               " show matching searchterm while typing
set number                  " show line numbers
set numberwidth=1           " width for numbers
set antialias               " font smoothing
set foldmethod=manual       " manually fold lines
set nowrap                  " no line wrapping
set showtabline=2           " Always show tab bar
set scrolloff=3             " Keep more context when scrolling off the end of a buffer
set wildmenu                " Make tab completion for files/buffers act like bash
set wildmode=longest,list   " use emacs-style tab completion when selecting files, etc
set hlsearch                " highlight search term
"set ignorecase              " case sensitive search
set smartcase               " only case sensitiv if they contain upper case characters
set mousehide               " Hide the mouse pointer while typing
set list                    " show white space characters and tabs
set listchars=trail:·,extends:>,precedes:<,tab:»·
"set autochdir               " Auto change working directory
set autoread               " Auto read changed files
set ofu=syntaxcomplete#Complete

" ----------------------------------------------------------------------------
" MAPPINGS
" ----------------------------------------------------------------------------

nmap cd :lcd %:p:h <cr>

" write the file
nmap <f1> :w <cr>
nmap <f2> :w <cr>

" call make
nmap <c-f2> :make % <cr>

" Close the Buffer
" nmap <f4> :bdel <cr>
nmap <f4> :q <cr>

" Previous Buffer
nmap <f5> :bp <cr>

" Next Buffer
nmap <f6> :bn <cr>

" move in split windows with ctrl key
nmap <c-up> <up>
nmap <c-down> <down>
nmap <c-right> <right>
nmap <c-left> <left>
nmap <c-s-up> <up> _
nmap <c-s-down> <down> _

" move in split windows for mac with apple key
nmap <D-Up> <Up>
nmap <D-Down> <Down>
nmap <D-Right> <Right>
nmap <D-Left> <Left>
nmap <D-S-Up> <Up>_
nmap <D-S-Down> <Down>_

" go to next / previous tab
map  <d-left>  :tabp <cr>
imap <d-left>  <esc> :tabp <cr> i
map  <d-right> :tabn <cr>
imap <d-right> <esc> :tabn <cr> i

" clear the search buffer when hitting return
:nnoremap <cr> :nohlsearch<cr>/<bs>

" find whitespace
map <leader>ws :%s/ *$//g<cr><c-o><cr>

" highligths all from import statements
com! FindLastImport :execute'normal G<cr>' | :execute':normal ?^\(from\|import\)\><cr>'
map <leader>fi :FindLastImport<cr>

" Map ,e to open files in the same directory as the current file
map <leader>e :e <C-R>=expand("%:h")<cr>/

" ----------------------------------------------------------------------------
" BACKUP
" ----------------------------------------------------------------------------

" backup, swap, views
set backup                       " backups are nice ...
set backupdir=$HOME/.vimbackup// " but not when they clog .
set directory=$HOME/.vimswap//   " Same for swap files
"set viewdir=$HOME/.vimviews//    " same for view files

" Creating directories if they don't exist
silent execute '!mkdir -p $HOME/.vimbackup'
silent execute '!mkdir -p $HOME/.vimswap'

"silent execute '!mkdir -p $HOME/.vimviews'
"au BufWinLeave * silent! mkview   " make vim save view (state) (folds, cursor, etc)
"au BufWinEnter * silent! loadview " make vim load view (state) (folds, cursor, etc)

" ----------------------------------------------------------------------------
" PLUGIN CONFIGS
" ----------------------------------------------------------------------------

"" nerdtree plugin
map <silent><c-tab> :NERDTreeToggle <cr>
map <silent><c-f> :NERDTreeFind <cr>
let g:NERDTreeMapActivateNode="<cr>"
let g:NERDTreeMapOpenSplit="<s-cr>"
let g:NERDTreeMapOpenVSplit="<c-cr>"
let g:NERDTreeIgnore=['\.pyc$', '\.pyo$', '\~$', '\$py.class']
let g:NERDTreeChDirMode=2

"" python syntax file
let python_highlight_all=1
let python_slow_sync=1

"" EasyGrep
let g:EasyGrepRecursive=1

"" Vim Session https://github.com/xolox/vim-session
let g:session_autosave = 1
"let g:session_autoload = 1
let g:session_command_aliases = 1
"" Don't persist options and mappings because it can corrupt sessions.
"set sessionoptions-=options
"" Always persist Vim's window size.
"set sessionoptions+=resize
" Persist the value of the global option 'tags'.
" let g:session_persist_globals = ['&tags']

" ----------------------------------------------------------------------------
" AUTOCOMMANDS
" ----------------------------------------------------------------------------

if has("autocmd") && !exists("autocommands_loaded")
  let autocommands_loaded=1

  "" https://github.com/godlygeek/vim-files/blob/master/plugin/SwapExistsDiff.vim
  function! s:HandleRecover()
    echo system('diff - ' . shellescape(expand('%:p')), join(getline(1, '$'), "\n") . "\n")
    if v:shell_error
      call s:DiffOrig()
    else
      echohl WarningMsg
      echomsg "No differences; deleting the old swap file."
      echohl NONE
      call delete(b:swapname)
    endif
  endfunction

  function! s:DiffOrig()
    vert new
    set bt=nofile
    r #
    0d_
    diffthis
    wincmd p
    diffthis
  endfunction

  autocmd SwapExists  * let b:swapchoice = '?' | let b:swapname = v:swapname
  autocmd BufReadPost * let b:swapchoice_likely = (&l:ro ? 'o' : 'r')
  autocmd BufEnter    * let b:swapchoice_likely = (&l:ro ? 'o' : 'e')
  autocmd BufWinEnter * if exists('b:swapchoice') && exists('b:swapchoice_likely') | let b:swapchoice = b:swapchoice_likely | unlet b:swapchoice_likely | endif
  autocmd BufWinEnter * if exists('b:swapchoice') && b:swapchoice == 'r' | call s:HandleRecover() | endif
  "" // https://github.com/godlygeek/vim-files/blob/master/plugin/SwapExistsDiff.vim

  function InsertTabWrapper()
      let col = col('.') - 1 
      if !col || getline('.')[col - 1] !~ '\k'
          return "\<tab>"
      else
          return "\<c-p>"
      endif
  endfunction
  inoremap <tab> <c-r>=InsertTabWrapper()<CR>


  " Enable file type detection.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    " Remove ALL autocommands for the current group.
    autocmd!

    " For all text files set 'textwidth' to 78 characters.
    "autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    autocmd FileType javascript set ts=4 sw=4
    autocmd FileType html set ts=2 sw=2 expandtab
    autocmd FileType CHANGELOG set ts=4 sw=4 expandtab
    autocmd FileType cfg set ts=4 sw=4 expandtab
    autocmd FileType coffee set ts=4 sw=4 expandtab
    autocmd FileType jsp set ts=4 sw=4 expandtab
    autocmd FileType python set omnifunc=pythoncomplete#Complete

    " add cusstom commentstring for nginx
    autocmd FileType nginx let &l:commentstring='#%s'
    autocmd FileType eco let &l:commentstring='<!-- %s -->'

    autocmd BufNewFile,BufRead *.js setfiletype javascript
    autocmd BufNewFile,BufRead *.dtml setfiletype css
    autocmd BufNewFile,BufRead *.pt setfiletype html
    autocmd BufNewFile,BufRead *.zcml setfiletype xml
    autocmd BufNewFile,BufRead *.cpy setfiletype python
    autocmd BufNewFile,BufRead *.rst setfiletype rest
    autocmd BufNewFile,BufRead *.txt setfiletype rest
    autocmd BufNewFile,BufRead *.cfg setfiletype cfg
    autocmd BufNewFile,BufRead *.kss setfiletype css
    autocmd BufNewFile,BufRead error.log setfiletype apachelogs
    autocmd BufNewFile,BufRead access.log setfiletype apachelogs
    autocmd BufRead,BufNewFile *.vcl setfiletype vcl

    " abbrevations
    autocmd FileType python abbr kpdb import pdb; pdb.set_trace()
    autocmd FileType python abbr kipdb from ipdb import set_trace; set_trace()

    " VIM footers
    autocmd FileType css abbr kvim /* vim: set ft=css ts=4 sw=4 expandtab : */
    autocmd FileType javascript abbr kvim /* vim: set ft=javscript ts=4 sw=4 expandtab : */
    autocmd FileType rst abbr kvim .. vim: set ft=rst ts=4 sw=4 expandtab tw=78 :
    autocmd FileType python abbr kvim # vim: set ft=python ts=4 sw=4 expandtab :
    autocmd FileType xml abbr kvim <!-- vim: set ft=xml ts=2 sw=2 expandtab : -->
    autocmd FileType html abbr kvim <!-- vim: set ft=html ts=2 sw=2 expandtab : -->
    autocmd FileType changelog abbr kvim vim: set ft=changelog ts=4 sw=4 expandtab :
    autocmd FileType cfg abbr kvim # vim: set ft=cfg ts=4 sw=4 expandtab :
    autocmd FileType config abbr kvim # vim: set ft=config ts=4 sw=4 expandtab :
    autocmd FileType coffee abbr kvim # vim: set ft=coffee ts=4 sw=4 expandtab :

    autocmd FileType * abbr ddate <C-R>=strftime("%Y-%m-%d")<CR>
    autocmd FileType * abbr nname Ramon Bartl<CR>
    autocmd FileType * abbr mmail ramon.bartl@nexiles.com<CR>

    autocmd BufNewFile *daily/*.rst 0r ~/.vim/skeletons/daily.rst

  augroup END

  " TEMPLATE Autocommands
  augroup template_autocmd
    autocmd!
    autocmd FileType coffee abbr kmod :r ~/.vim/skeletons/skeleton.coffee
    autocmd FileType coffee map <F5> :CoffeeCompile
    autocmd FileType python abbr kmod :r ~/.vim/skeletons/skeleton.py
    autocmd FileType python abbr khead :r ~/.vim/skeletons/skeleton.head
    autocmd FileType rst abbr kmod :r ~/.vim/skeletons/skeleton.rst
    autocmd FileType zpt abbr kmod :r ~/.vim/skeletons/skeleton.pt
    autocmd FileType html abbr kmod :r ~/.vim/skeletons/skeleton.html
    autocmd FileType changelog abbr kmod :r ~/.vim/skeletons/skeleton.changelog
    autocmd FileType xml abbr kmod :r ~/.vim/skeletons/skeleton.zcml
  augroup END

endif
