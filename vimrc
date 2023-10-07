set number
set nocompatible
set relativenumber
set encoding=UTF-8
set laststatus=2
set noshowmode
set autoindent expandtab tabstop=2 shiftwidth=2
set hidden
set autoread
syntax enable
syntax on
filetype on
filetype plugin on
filetype indent on

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"

set background="dark"

let &t_SI = "\e[5 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[3 q"
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" ====> arrow keys <====
vnoremap n j
vnoremap m h
vnoremap e k
vnoremap i l

vnoremap j n
vnoremap h m
vnoremap k e
vnoremap l i

nnoremap n j
nnoremap m h
nnoremap e k
nnoremap i l

nnoremap j n
nnoremap h m
nnoremap k e
nnoremap l i
nnoremap M ^

" ====> remapping some selectors <==== "
nnoremap vl v^
nnoremap vu v$

" ====> scape keys <====
nnoremap a i
vnoremap aa <esc>
inoremap aa <esc>

nmap gn gj
nmap ge gk

nmap gU gU
nmap gu gu

nnoremap fu bvU
nnoremap fl bvu
nnoremap ru lbi_<esc>


" ====> comment keys <====
nmap tt \cc
nmap tu \cu
vmap tt \cc
vmap tu \cu

nnoremap b F<space>
nnoremap w f<space>

" ====> copy-paste keys <====
vmap <S-y> "+y
nmap <S-p> "+p
nmap vv :w<cr>
nnoremap rr :NERDTree<cr>
nnoremap ff :FZF $FOLDER<cr>
nnoremap XX ZZ
nnoremap XQ ZQ
nnoremap Q <esc>
nnoremap ,h :Goyo 70%+70%x100%<cr>


" ====> other keys <====
nnoremap fw :tabprevious<cr>
nnoremap fp :tabnext<cr>
nmap r <C-r>
nmap gt <C-6>
nmap <space> \


inoremap ' ""<Esc>i
inoremap " ''<Esc>i
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap [ []<Esc>i
inoremap ;b ``<Esc>i
inoremap ;s ~<Esc>a
nnoremap cw ciw
nnoremap c( ci(
nnoremap c[ ci[
nnoremap c{ ci{

nnoremap c7 ci[
nnoremap c8 ci(
nnoremap c9 ci{

nnoremap v7 vi[
nnoremap v8 vi(
nnoremap v9 vi{

nnoremap c" ci'
nnoremap c' ci"
nnoremap cW ciW
nnoremap vw vaw
nnoremap v' vi"
nnoremap v" vi'
vnoremap // :s/
nnoremap co C
nnoremap ci c^

" ====> plugins <====
call plug#begin('~/.vim/plugged')
Plug 'frazrepo/vim-rainbow',
Plug 'scrooloose/nerdcommenter',
Plug 'itchyny/lightline.vim',
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' },
Plug 'scrooloose/nerdtree',
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'vim-scripts/loremipsum',
Plug 'junegunn/goyo.vim',
Plug 'w0rp/ale',
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'sheerun/vim-polyglot',
Plug 'itchyny/vim-gitbranch',
call plug#end()

"" ALE configurations
let g:ale_linters = {'rust': ['analyzer'], 'python': ['ruff'], 'javascript': ['eslint'], 'typescript': ['eslint'], 'typescriptreact': ['eslint']}

let g:ale_fixers = { '*': ['remove_trailing_lines', 'trim_whitespace'], 'javascript': [ 'prettier' ], 'rust': ['rustfmt'], 'python': ['black'], 'typescript': ['prettier'], 'typescriptreact': ['prettier'] }


let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }


let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1

let g:slime_target = "tmux"
let g:livepreview_previewer = 'zathura'

 let g:rainbow_active = 1

let NERDTreeMenuDown='n'
let NERDTreeMenuUp='e'
let NERDTreeMapOpenExpl='B'

xmap k <Plug>SlimeRegionSend
nmap kk <Plug>SlimeParagraphSend


"======= Qwik && NextJs =======
autocmd FileType typescriptreact,html inoremap ,d <div></div><Esc>F>a
autocmd FileType typescriptreact,html inoremap ,in <input type=""/><Esc>F"i
autocmd FileType typescriptreact,html inoremap ,1 <h1></h1><Esc>FhT>i
autocmd FileType typescriptreact,html inoremap ,2 <h2></h2><Esc>FhT>i
autocmd FileType typescriptreact,html inoremap ,3 <h3></h3><Esc>FhT>i
autocmd FileType typescriptreact,html inoremap ,4 <h4></h4><Esc>FhT>i
autocmd FileType typescriptreact,html inoremap ,m <main></main><Esc>FmT>i
autocmd FileType typescriptreact,html inoremap ,sp <span></span><esc>FsT>i
autocmd FileType typescriptreact,html inoremap ,se <section></section><esc>FsT>i
autocmd FileType typescriptreact,html inoremap ,p <p></p><Esc>FpT>i
autocmd FileType typescriptreact,html inoremap ,u <ul><CR></ul><Esc>O
autocmd FileType typescriptreact,html inoremap ,li <li></li><Esc>FlT>i
autocmd FileType typescriptreact,html inoremap ,fo <form></form><esc>FfT>i
autocmd FileType typescriptreact,html inoremap ,la <label></label><esc>FlT>i
autocmd FileType typescriptreact,html inoremap ,na <nav></nav><esc>FnT>i
autocmd FileType typescriptreact,html nnoremap tg I{/*<esc>A*/}<esc>
autocmd FileType typescriptreact,html nnoremap tk I<esc>f*l<esc>c^<esc>f*<esc>C<esc>I<esc>
autocmd FileType typescriptreact,html nnoremap c. F>cf<><<left>
autocmd FileType typescriptreact,html inoremap ' ""<Esc>i
autocmd FileType typescriptreact,html inoremap " ''<Esc>i
autocmd FileType typescriptreact,html nnoremap <space>p :Prettier<cr>

autocmd FileType typescriptreact inoremap ,lo console.log()<esc>i

autocmd FileType typescriptreact inoremap ,im <img src={} alt=""} /><esc>Frf}i
autocmd FileType typescriptreact inoremap cn class=""<esc>i
autocmd FileType typescriptreact inoremap ,b <button onClick$={() => {}}></button><esc>F/hi
autocmd FileType typescriptreact inoremap ,an <a href=""></a><Esc>Fhf"a
autocmd FileType typescriptreact nnoremap <space>mm :!pnpm dev
autocmd FileType typescriptreact nnoremap <space>hh :!pnpm preview

autocmd FileType typescriptreact inoremap ,q import { component$ } from "@builder.io/qwik";<esc>F}hi
autocmd FileType typescriptreact inoremap ,c import { } from "@builder.io/qwik-city";<esc>F}i
autocmd FileType typescriptreact inoremap ,x export default component$(() => {<cr>return <></><cr>})<esc>kf/hi

autocmd FileType html inoremap ,sc <script></script><esc>F>li<cr><esc>O
autocmd FileType html inoremap ,st <style></style><esc>F>li<cr><esc>O
autocmd FileType html inoremap ,an <a href=""></a><Esc>Fhf"a
autocmd FileType html inoremap ,im <img src="" alt=""/><esc>fsf"a
autocmd FileType html inoremap cn class=""<esc>i
autocmd FileType html inoremap ,b <button></button><esc>F{a

"======= TYPESCRIPT
autocmd FileType typescript inoremap ,v import {  } from "~/components/index";<esc>F{lli
autocmd FileType typescript inoremap ,z export { default as  } from "./";<esc>F}hi
autocmd FileType typescript nnoremap <space>mm :!clear; pnpm run index.ts


"======= RUST
autocmd FileType rust inoremap kp println!("{}", );<esc>hi
autocmd FileType rust inoremap kq assert_eq!(, );<esc>T(i
autocmd FileType rust inoremap kf fn () {}<esc>F(i
autocmd FileType rust inoremap ka async fn () {}<esc>F(i
autocmd FileType rust inoremap kd #[derive()]<esc>F(a
autocmd FileType rust inoremap km #[cfg(test)]<esc>
autocmd FileType rust inoremap kt #[test]<esc>
autocmd FileType rust nnoremap k# <esc>ggO<esc>O#![allow(dead_code, unused_variables, unused_imports)]<esc>``
autocmd FileType rust inoremap " '
autocmd FileType rust inoremap ' "
autocmd FileType rust nnoremap <space>mm :!clear; cargo-fmt; cargo run
autocmd FileType rust nnoremap <space>hh :!clear; cargo-fmt; cargo test -- --nocapture


"====== PYTHON
autocmd FileType python nnoremap <space>mm :!python main.py

"======= CSS
autocmd FileType css inoremap gcs grid-column-start:<space>
autocmd FileType css inoremap gce grid-column-end:<space>
autocmd FileType css inoremap df display:<space>flex;<CR>justify-content:<space>center;<CR>align-items:<space>center;
autocmd FileType css inoremap dg display:<space>grid;<CR>grid-template-columns: repeat(, 1fr);<CR>grid-template-rows: repeat(, 1fr);<CR>align-items:<space>center;<esc>kkf,i
autocmd FileType css inoremap bg background-color:<space>
autocmd FileType css inoremap ff font-family:<space>
autocmd FileType css inoremap fs font-size:<space>
autocmd FileType css inoremap fw font-weight:<space>
autocmd FileType css inoremap cc color:<space>
autocmd FileType css inoremap mg margin:<space>
autocmd FileType css inoremap pd padding:<space>
autocmd FileType css inoremap ,mq @media only screen and (max-width: xx) {}<esc>Fxciw
