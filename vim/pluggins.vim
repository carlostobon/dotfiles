" ==== Plugins ====
call plug#begin('~/.vim/plugged')
Plug 'frazrepo/vim-rainbow',
Plug 'scrooloose/nerdcommenter',
Plug 'itchyny/lightline.vim',
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' },
Plug 'scrooloose/nerdtree',
Plug 'vim-scripts/loremipsum',
Plug 'junegunn/goyo.vim',
Plug 'w0rp/ale',
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'sheerun/vim-polyglot',
Plug 'itchyny/vim-gitbranch',
Plug 'othree/html5.vim',
Plug 'NoahTheDuke/vim-just',
Plug 'jpalardy/vim-slime',
Plug 'makerj/vim-pdf',
Plug 'prisma/vim-prisma',
Plug 'morhetz/gruvbox',
Plug 'ryanoasis/vim-devicons',
call plug#end()


" ==== ALE confgs ====
let g:ale_linters = {
      \ 'rust': ['analyzer'],
      \ 'python': ['pyright', 'ruff'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint'],
      \ 'typescriptreact': ['eslint', 'tsserver', 'tslint'],
      \ }

let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'rust': ['rustfmt'],
      \ 'python': ['black'],
      \ 'typescript': ['prettier'],
      \ 'javascript': ['prettier'],
      \ 'typescriptreact': ['prettier'],
      \ }


let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }


let g:ale_rust_rustfmt_options = '--edition 2021'
let g:ale_lint_delay=0


" Makes Tab the switcher in ALE
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"

" Set colors in Ale
function! s:tweak_colors()
    " ALE menu selection colors
    hi Pmenu          ctermfg=white ctermbg=black
    " ALE menu colors
    hi PmenuSel       ctermfg=white ctermbg=cyan
    " Selection color
    hi Visual         ctermfg=white ctermbg=blue
endfunction

" Makes Goyo keep syntax colors
autocmd! ColorScheme default call s:tweak_colors()


let g:rainbow_active = 1

let g:ale_set_highlights = 0
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_set_balloons = 1
let g:ale_sign_error = '👹'
let g:ale_sign_warning = '👽'

let g:slime_target = "tmux"

let g:livepreview_previewer = 'zathura'

let NERDTreeMenuDown='n'
let NERDTreeMenuUp='e'
let NERDTreeMapOpenExpl='B'
