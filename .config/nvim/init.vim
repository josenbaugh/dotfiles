call plug#begin('~/.vim/plugged')

Plug 'qpkorr/vim-bufkill' " closing buffer won't close window/split
Plug 'neoclide/coc.nvim', {'do': { -> 'yarn install --frozen-lockfile'}}
Plug 'jremmen/vim-ripgrep'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ap/vim-buftabline'
Plug 'tpope/vim-fugitive'
Plug 'ekalinin/Dockerfile.vim'

" theme
Plug 'vim-airline/vim-airline'
Plug 'romainl/Apprentice'
Plug 'gruvbox-community/gruvbox'

" php
Plug 'rican7/php-doc-modded'
Plug 'adoy/vim-php-refactoring-toolbox' "align assignments
Plug 'arnaud-lb/vim-php-namespace' "insert use statements
Plug 'craigemery/vim-autotag'

" angular
Plug 'burnettk/vim-angular'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'

call plug#end()

syntax on
set noerrorbells
set visualbell
set nocompatible
set backspace=indent,eol,start
set hidden
set incsearch
set nohlsearch
set noswapfile
set nowrap
set noerrorbells
set encoding=utf8
set spell spelllang=en_us
let mapleader = "'"
set path=.,**
set number relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set smartcase
set ignorecase
set smarttab
set smartindent
set cursorline
set scrolloff=8
set nobackup
set undodir=~/.vim/undodir
set undofile
set clipboard=unnamedplus
set signcolumn=yes
set colorcolumn=80

set termguicolors
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" manual filetype stuff
au BufNewFile,BufRead *.groff set filetype=groff

" javascript settings
let g:used_javascript_libs = 'underscore,angularjs,angularui,angularuirouter'

" Tags settings
set tags+=tags
let g:autotagCtagsCmd="ctags -R --PHP-kinds=cfi --languages=php"

" hide netrw
autocmd FileType netrw setl bufhidden=wipe
let g:netrw_fastbrowse = 0

" PHP stuff
autocmd FileType php nnoremap <Leader>d :call PhpDocSingle()<CR>
autocmd FileType php nnoremap <Leader>u :call PhpInsertUse()<CR>
autocmd FileType php vnoremap <Leader>a :call PhpAlignAssigns()<CR>

" exclude some files from ctrlp for preformance
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" enable rg
if executable('rg')
    let g:rg_derive_root='true'
endif

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

" Use K for show documentation in preview window
set keywordprg=:call\ CocActionAsync('doHover')
augroup VimHelp
  autocmd!
  autocmd Filetype vim,help setlocal keywordprg=:help
augroup END

nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>pw :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>

nnoremap <leader>s :set spell!<CR>
nnoremap <leader>f :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Space> i<Space><Right><ESC>
nnoremap <silent>   <tab>  :bnext<CR>
nnoremap <silent> <s-tab>  :bprevious<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <Up>    :resize -2<CR>
nnoremap <Down>  :resize +2<CR>
nnoremap <Left>  :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>cf :e <cfile><cr>

" format xml selection
vnoremap <leader>fx :!xmllint --format -<CR>

" format json
nmap <leader>fj :%!python -m json.tool<CR>

" Use tab for trigger completion with characters ahead and navigate.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

" auto compile dwmblocks when saving the config file
autocmd BufWritePost ~/code/dwmblocks/config.h !cd ~/code/dwmblocks/; sudo --askpass make install && { killall -q dwmblocks;setsid dwmblocks & }

