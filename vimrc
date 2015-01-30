if !1 | finish | endif

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" ========================================
" Plugin Settings
" ========================================
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/vimproc'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'msanders/snipmate.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'scrooloose/nerdtree'

NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-haml'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'othree/html5.vim'
NeoBundle 'elzr/vim-json'
NeoBundle 'szw/vim-tags'
NeoBundle 'kchmck/vim-coffee-script'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

" 無限undo
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

au BufRead,BufNewFile *.coffee set filetype=coffee
au BufRead,BufNewFile *.jbuilder set filetype=ruby

filetype plugin indent on

" ========================================
" Unite Settings
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

" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>

" ========================================
" Unite Settings
" ========================================
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" ========================================
" NeoComplete Settings
" ========================================
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 4
let g:neocomplete#auto_completion_start_length = 4
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" 補完が止まった際に、スキップする長さを短くする
let g:neocomplete#skip_auto_completion_time = '0.2'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'ruby' : $HOME.'/.vim/dict/ruby.dict'
      \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" 補完候補の高さを指定
set pumheight=10

filetype plugin indent on

"" set backspace
set backspace=indent,eol,start

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

"" 空白可視化
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<

"" 80字以上ハイライト
set colorcolumn=80

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

" ========================================
" タブの設定
" ========================================
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]t :tablast <bar> tabnew<CR>
" tt 新しいタブを一番右に作る
map <silent> [Tag]w :tabclose<CR>
" tw タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

" ========================================
" vim-json設定
" ========================================
" ダブルクォートを隠す機能を無効化
let g:vim_json_syntax_conceal = 0

" ========================================
" vim-tags の設定
" ========================================
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>

" ========================================
" その他
" ========================================
" Vimを使ってくれてありがとうを非表示
set notitle
" ;でコマンド入力(;と:を入れ替え)
noremap ; :
" コマンドをステータス行に表示
set showcmd
" 現在のモードを表示
set showmode
" スワップファイル作成場所
set directory=~/.vim/tmp
" set noswapfile " スワップファイルを作成しない場合
" バックアップファイル作成場所
set backupdir=~/.vim/tmp
" OSのクリップボードを使用する
set clipboard+=unnamedplus,unnamed
" カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2
" 挿入モードでCtrl+kを押すとクリップボードの内容を貼り付けられるようにする
imap <C-K> <ESC>"*pa
