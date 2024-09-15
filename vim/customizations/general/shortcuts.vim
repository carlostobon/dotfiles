" vim/customizations/general/shorcuts.vim

" ==== Custom keyboard (colemak-dh) ==== "
vnoremap n j
vnoremap m h
vnoremap e k
vnoremap i l

nnoremap n j
nnoremap m h
nnoremap e k
nnoremap i l

vnoremap j n
vnoremap h m
vnoremap k e
vnoremap l i

nnoremap j n
nnoremap h m
nnoremap k e
nnoremap l i

nmap gn gj
nmap ge gk

nmap r <C-r>



" ==== Scape keys ====
nnoremap a i
vnoremap aa <esc>
inoremap aa <esc>


" ==== Capitalize and de-capitalize ====
nnoremap fu <right>bvU
nnoremap fl <right>bvu


" ==== Comments ====
nmap tt \cc
nmap tg \cu
vmap tt \cc
vmap tg \cu

"" Switch alternative commenters
nmap ta \ca

" ==== Jump from word to word ====
nnoremap w W
nnoremap b B


" ==== Copy and paste ====
vmap <S-y> "+y
nmap <S-p> "+p


" ==== Save current buffer ====
nmap vv :w<cr>


" ==== Missc ====
nnoremap ft :NERDTree<cr>
nnoremap ff :FZF $ROOT<cr>
nnoremap XX ZZ
nnoremap XQ ZQ
nnoremap ,h :Goyo 75%+90%x100%<cr>
nnoremap yp mt{v}y`t
nnoremap Q <esc>
nnoremap > >>
nnoremap < <<



" ==== Switch tabs and buffers ====
nnoremap fw :tabprevious<cr>
nnoremap fp :tabnext<cr>
nnoremap gt <C-6>


" ==== Custom remaps ====
inoremap ' ""<Esc>i
inoremap " ''<Esc>i
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap [ []<Esc>i
inoremap ;b ``<Esc>i
inoremap ;s ~<Esc>a

nnoremap cu ci(
nnoremap cl ci[
nnoremap cy ci{

nnoremap vu vi(
nnoremap vl vi[
nnoremap vy vi{

nnoremap c" ci'
nnoremap c' ci"
nnoremap cw ciw
nnoremap cW ciW
nnoremap vw vaw
nnoremap v' vi"
nnoremap v" vi'
vnoremap // :s/

nnoremap dp {<down>V}d
nnoremap vp {<down>V}
nnoremap gg msgg

" ==== Custom selectors ==== "
nnoremap cn c^
nnoremap co C
nnoremap ce cb
nnoremap ci ce

nnoremap vn v^
nnoremap vo v$

nnoremap M ^
nnoremap E $

nnoremap tl ct]
nnoremap tu ct)
nnoremap ty ct}

nnoremap Tl cT[
nnoremap Tu cT(
nnoremap Ty cT{

" ==== Markers ==== "
nnoremap ,t `t
nnoremap ,s `s
nnoremap ,r `r
nnoremap .t mt

" ==== General shorcuts ==== "
nnoremap hht :Command<space>
nnoremap ht :G
nnoremap hd :ALEDetail<cr>
