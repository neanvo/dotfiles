call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'bling/vim-airline'
Plug 'retorillo/airline-tablemode.vim'
Plug 'ryanoasis/vim-webdevicons'
Plug 'tpope/vim-commentary' 
Plug 'othree/html5.vim'
" Plug 'jordwalke/vim-reasonml'
Plug 'hail2u/vim-css3-syntax',            { 'for': 'css' }
Plug 'cakebaker/scss-syntax.vim'
Plug 'reedes/vim-pencil'   
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular',                 { 'for': 'markdown' } " Needed for vim-markdown
Plug 'plasticboy/vim-markdown',           { 'for': 'markdown' }
Plug 'vim-airline/vim-airline-themes'
Plug 'isRuslan/vim-es6'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-surround'
Plug 'skywind3000/asyncrun.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhinz/vim-grepper'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'
Plug 'dart-lang/dart-vim-plugin'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
call plug#end()
let g:python3_host_prog = '/usr/local/bin/python3'
set encoding=utf8
set regexpengine=1
set lazyredraw
set ttyfast
let NERDTreeMinimalUI = 1
hi Normal guibg=NONE ctermbg=NONE
syntax enable
map <C-n> :NERDTreeToggle<CR>

set timeoutlen=1000 ttimeoutlen=0

" if hidden is not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other
" plugin.
 inoremap <silent><expr> <TAB>
       \ pumvisible() ? "\<C-n>" :
             \ <SID>check_back_space() ? "\<TAB>" :
                   \ coc#refresh()
                   inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

                   function! s:check_back_space() abort
                     let col = col('.') - 1
                       return !col || getline('.')[col - 1]  =~# '\s'
                       endfunction

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs :call CocAction('jumpDefinition', 'vsplit')
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)


" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if &filetype == 'vim'
          execute 'h '.expand('<cword>')
            else
                  call CocAction('doHover')
                    endif
                  endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" " Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

let g:mapleader=' '
map <Leader> <Plug>(easymotion-prefix)
set updatetime=800
set nornu
set nowrap
set showcmd       " display incomplete commands
set laststatus=2  " Always display the status line
set tabstop=2 shiftwidth=2
set expandtab 
set backspace=indent,eol,start
set hlsearch  
set incsearch   
set ignorecase
set smartcase
set number
set numberwidth=5
set autoread
au FocusGained,BufEnter * :checktime

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set background=dark
colorscheme gruvbox
let g:airline_theme='gruvbox'

" Make it obvious where 80 characters is {{{2
" Lifted from StackOverflow user Jeremy W. Sherman
" http://stackoverflow.com/a/3765575/2250435
if exists('+colorcolumn')
  set textwidth=80
  set colorcolumn=+1
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1)
endif " }}}2
" Open new split panes to right and bottom, which feels more natural {{{2
set splitbelow
set splitright

let g:airline_powerline_fonts = 1 " Enable the patched Powerline fonts
let g:ctrlp_working_path_mode = '0'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|third-party\|ios\|android|'
let g:table_mode_corner='|'

let g:airline_section_warning = ''
let g:airline_section_error = ''
let g:airline_section_z = ''

let s:section_truncate_width = get(g:, 'airline#extensions#default#section_truncate_width', {
      \ 'b': 219,
      \ 'x': 2210,
      \ 'y': 2218,
      \ 'z': 2215,
      \ 'warning': 210,
      \ 'error': 210,
      \ })

hi CocErrorSign  ctermfg=Red ctermbg=Black guifg=#ff0000
hi CocWarningSign  ctermfg=Yellow ctermbg=Black guifg=#ff922b
highlight GitGutterAdd     ctermfg=Green ctermbg=Black
highlight GitGutterChange  ctermfg=Cyan ctermbg=Black
highlight GitGutterDelete  ctermfg=Red ctermbg=Black
hi SignColumn ctermbg=Black

nnoremap <silent><Leader><Leader> :CtrlP<CR>

nnoremap <silent><Leader>/ :Grepper<CR>
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)


" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)

nnoremap <silent><Leader>a :CocAction<CR>

let g:tsuquyomi_use_vimproc=1
:autocmd InsertEnter,InsertLeave * set cul!
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

tnoremap kj <C-\><C-n>

vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
