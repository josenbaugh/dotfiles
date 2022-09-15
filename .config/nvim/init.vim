call plug#begin('~/.vim/plugged')

Plug 'qpkorr/vim-bufkill' " closing buffer won't close window/split
Plug 'tomtom/tcomment_vim'
Plug 'jremmen/vim-ripgrep'
Plug 'ap/vim-buftabline'
Plug 'tpope/vim-fugitive'
Plug 'ekalinin/Dockerfile.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" telescope requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" theme
Plug 'vim-airline/vim-airline'
Plug 'romainl/Apprentice'
Plug 'gruvbox-community/gruvbox'

" php
Plug 'rican7/php-doc-modded'
Plug 'adoy/vim-php-refactoring-toolbox' "align assignments
Plug 'arnaud-lb/vim-php-namespace' "insert use statements
Plug 'craigemery/vim-autotag' "idk if this even works
Plug 'dense-analysis/ale' "code sniffer
Plug 'vim-vdebug/vdebug' "xdebug

" angular
Plug 'burnettk/vim-angular'
Plug 'pangloss/vim-javascript'
Plug 'othree/javascript-libraries-syntax.vim'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

call plug#end()
let g:mkdp_browser = 'surf'

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
set expandtab
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
set lazyredraw

set termguicolors
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" explorer stuff
nmap <leader>e :CocCommand explorer<CR>
nmap <leader>f :CocCommand explorer --preset floating<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" put filepath in the title
set title
set titlestring=nvim\ %F

" Make Y behave like C and D
nnoremap Y y$

" Keep centered when searching
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Undo breakpoints
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Move lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

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
"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

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

nmap <leader>a  <Plug>(coc-codeaction-selected)
nnoremap <leader>sw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>sf :CocSearch<SPACE>
" nnoremap <C-p> :GFiles<CR>
" nnoremap <Leader>pf :Files<CR>

" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>s <cmd>Telescope live_grep<cr>
nnoremap <leader>sb <cmd>Telescope buffers<cr>
nnoremap <leader>sh <cmd>Telescope help_tags<cr>

" nnoremap <leader>sp :set spell!<CR>
inoremap <C-c> <esc>
" nnoremap <leader>f :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
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

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" format xml selection
vnoremap <leader>fx :!xmllint --format -<CR>

" format json
nmap <leader>fj :%!python -m json.tool<CR>

" Use tab for trigger completion with characters ahead and navigate.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" CoC suggestion completion with <CR>
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

" xdebug
let g:vdebug_options = {}
let g:vdebug_options["port"] = 9003
let g:vdebug_options["server"] = '172.20.0.1'
let g:vdebug_options["timeout"] = 20
let g:vdebug_options["on_close"] = 'detach'
let g:vdebug_options["break_on_open"] = 0
let g:vdebug_options["ide_key"] = 'PHPSTORM'
let g:vdebug_options["debug_window_level"] = 1
let g:vdebug_options["debug_file_level"] = 0
let g:vdebug_options["debug_file"] = ""
let g:vdebug_options["watch_window_style"] = 'compact'
let g:vdebug_options["marker_default"    ] = '⬦'
let g:vdebug_options["marker_closed_tree"] = '▸'
let g:vdebug_options["marker_open_tree"] = '▾'
let g:vdebug_options["path_maps"] = {'/var/www/html': '/home/josh/workcode/salt'}


" vdebug colors
hi default DbgBreakptLine term=reverse ctermfg=White ctermbg=White  guifg=#000000 guibg=#b8bb26
hi default DbgBreakptSign term=reverse ctermfg=White ctermbg=White guifg=#000000 guibg=#b8bb26
hi default DbgCurrentLine term=reverse ctermfg=White ctermbg=White guifg=#000000 guibg=#8ec07c
hi default DbgCurrentSign term=reverse ctermfg=White ctermbg=White guifg=#000000 guibg=#8ec07c



inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

" auto compile dwmblocks when saving the config file
autocmd BufWritePost ~/code/dwmblocks/config.h !cd ~/code/dwmblocks/; sudo --askpass make install && { killall -q dwmblocks;setsid dwmblocks & }

