set number
set nocompatible
set relativenumber
set encoding=UTF-8
set laststatus=2
set noshowmode
set autoindent expandtab tabstop=2 shiftwidth=2
set hidden
set autoread
set background=light
colorscheme default

" never persist buffers, useful
" when working with encrypted files.
set nobackup
set nowritebackup
set noswapfile
set viminfo=
if has('persistent_undo')
      set noundofile
endif

syntax enable
syntax on
filetype on
filetype plugin on
filetype indent on


" ==== Cursor color ====
if &term =~ "xterm\\|kitty"
  let &t_EI = "\<Esc>]12;magenta\x7"
  silent !echo -ne "\033]12;magenta\007"
endif


" ==== Cursor size ====
let &t_SI = "\e[5 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[3 q"
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"


" ==== Makes it keeps sintax on ====
" Due to a compatibility error with Goyo
function! SintaxOn()
      tabprevious
      syntax on
endfunction

function! SintaxOnSave()
      w
      syntax on
endfunction


autocmd FileType svelte syntax on
autocmd FileType svelte nnoremap fw :call SintaxOn()<cr>
autocmd FileType svelte nnoremap vv :call SintaxOnSave()<cr>

autocmd FileType css syntax on
autocmd FileType css nnoremap fw :call SintaxOn()<cr>
autocmd FileType css nnoremap vv :call SintaxOnSave()<cr>

autocmd FileType html syntax on
autocmd FileType html nnoremap fw :call SintaxOn()<cr>
autocmd FileType html nnoremap vv :call SintaxOnSave()<cr>
