"" Looks
syntax on
colorscheme desert 
set number
set ruler
set showmatch

"" Tab
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smartindent
autocmd FileType make setlocal noexpandtab

"" Search
set history=100
set ignorecase
set smartcase
set wrapscan

"" Encoding
set encoding=utf-8
set fileencoding=utf-8

"" No Backup
set nobackup

"" Change the color of carsol in IME
if has('multi_byte_ime')
    highlight Cursor guifg=NONE guibg=Green
            highlight CursorIM guifg=NONE guibg=Purple
                    endif

"" Python
function! s:Exec()
    exe "!" . &ft . " %"        
            :endfunction         
                        command! Exec call <SID>Exec() 
                                        map <silent> <C-P> :call <SID>Exec()<CR>

"" Powerline
set laststatus=2
set guifont=Ricty-Regular-Powerline.ttf
let g:Powerline_symbols = 'fancy'

"" Neocomplchche config --------------------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_max_list = 20

"" Neocomplchche_snippets_expand -----------------------------
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

"" NeoBundle -------------------------------------------------
set nocompatible
filetype off
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
            call neobundle#rc(expand('~/.vim/bundle/'))
                    endif

NeoBundle 'Shougo/vimproc'
"" NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'msanders/snipmate.vim'
NeoBundle 'Lokaltog/vim-easymotion'

filetype plugin on
filetype indent on
