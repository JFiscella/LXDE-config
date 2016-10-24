execute pathogen#infect()
syntax on
filetype plugin indent on

" colorscheme joey
colorscheme Tomorrow-Night-Bright

" airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme='PaperColor-Dark'
" set colorcolumn=80

" gvim
set gfn=Ubuntu\ Mono\ 12
"set guifont=Monaco:h12
"set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar


" emoji 😄
silent! if emoji#available()
  " do something
endif

set number
set relativenumber

" change the behavior of c
:set cpoptions+=$



" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set hidden

set noswapfile
"set shiftwidth=3
"set tabstop=3
"set smartindent
"set expandtab

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

let mapleader = " "

map <S-Tab> :bprevious<CR>
map <Tab> :bnext<CR>

" enable / disable colorcolumn
" nnoremap <leader>cc :set colorcolumn=80<CR>
nnoremap <leader>cc :let &colorcolumn = join(range(&tw ? &tw+1 : 111, &columns), ',')<CR>
" ^ thanks mhi^

" for MatchTagAlways
nnoremap <leader>% :MtaJumpToOtherTag<cr>

" split line
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>$a

nnoremap <leader>cd :set colorcolumn=0<CR>

" set paste / unset paste
nnoremap <leader>pp :set paste!<CR>

" unfold everything
nnoremap <silent> <leader>zo mzggvGzO<CR>'z:echo('Unfolded all folds ')<Esc>
nnoremap <silent> <leader>zc mzggvGzC<CR>'z:echo('Folded all folds ')<Esc>

nnoremap <silent> <leader>zO mzggvGzO<CR>'z:echo('Unfolded all folds ')<Esc>
nnoremap <silent> <leader>zC mzggvGzC<CR>'z:echo('Folded all folds ')<Esc>

" jump to closed folds by default
nnoremap zj :call NextClosedFold('j')<cr>
nnoremap zk :call NextClosedFold('k')<cr>

" remap zj and zk to be prefaced by leader key
nnoremap <silent> <leader>zj zj
nnoremap <silent> <leader>zk zk

nnoremap <silent> <leader>zj zj
nnoremap <silent> <leader>zk zk

" show buffers
nnoremap <leader>bls :ls<cr>:b<space>

" show old
nnoremap <leader>bo :browse old<CR>

" delete all buffers
nnoremap <leader>bdd :%bdelete<CR>

" save buffers to session, write / quit too
nnoremap <silent> <leader>ss :set sessionoptions=buffers<CR>:mksession!<CR>:echo('Saved buffers to Session.vim')<Esc>
nnoremap <silent> <leader>ssw :set sessionoptions=buffers<CR>:mksession!<CR>:wa<CR>:echo('Saved all open buffers to disc')<CR>
nnoremap <silent> <leader>ssq :set sessionoptions=buffers<CR>:mksession!<CR>:q<CR>
nnoremap <silent> <leader>sswq :set sessionoptions=buffers<CR>:mksession!<CR>:wa<CR>:q<CR>

" restore buffers
let sessionmsg = "session restored from Session.vim" + "!!"
" let sessionmsg = "session restored from Session.vim" + emoji#for('sheep')
nnoremap <silent> <leader>rs :source Session.vim<CR>:echo("Session restored from Session.vim ")<Esc>

" spellcheck
:map <leader>sc :setlocal spell! spelllang=en_us<CR>

" xml expand
map <F5> :%s/<\([^>]\)*>/\r&\r/g<enter>:g/^$/d<enter>vat=

" edit after jumping to end of word
nnoremap <silent> <leader>e ea
nnoremap <silent> <leader>E Ea

" swap carrot and octothorp
nnoremap # ^
nnoremap ^ #

" clipboard
set clipboard=unnamed
nnoremap <leader>pb :r !pbpaste<CR>

function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim

" markdown
" autocmd BufNewFile,BufRead *.md set filetype=markdown
set cindent
autocmd FileType python setlocal foldmethod=indent smartindent shiftwidth=4 ts=4 et cinwords=if,elif,else,for,while,try,except,finally,def,class
