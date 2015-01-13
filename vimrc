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
NeoBundle 'scrooloose/nerdtree'

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
set listchars=tab:>-,trail:-

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
" その他
" ========================================
" コマンドをステータス行に表示
set showcmd
" 現在のモードを表示
set showmode
" OSのクリップボードを使用する
set clipboard+=unnamedplus,unnamed

" ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2
" 挿入モードでCtrl+kを押すとクリップボードの内容を貼り付けられるようにする
imap <C-K> <ESC>"*pa
