set nocompatible
filetype off
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#begin(expand('~/.vim/bundle/'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  call neobundle#end()
endif

" ========================================
" Plugin setting
" ========================================
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'msanders/snipmate.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'unite.vim'

NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-haml'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'othree/html5.vim'
NeoBundle 'elzr/vim-json'
NeoBundle 'kchmck/vim-coffee-script'

" 無限undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" ========================================
" Unite setting
" ========================================
" 入力モードで開始する
let g:unite_enable_start_insert=1
noremap <C-J> :Unite file buffer file_mru<CR>
noremap <C-K> :Unite tab<CR>

"最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 20
"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>


filetype plugin indent on

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

"" Infinity Undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

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


