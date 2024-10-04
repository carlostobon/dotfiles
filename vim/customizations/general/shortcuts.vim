" vim/customizations/general/shorcuts.vim

" ==> Custom keyboard (colemak-dh) <== "
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


" ==> Scape keys <==
nnoremap a i
vnoremap aa <esc>
inoremap aa <esc>


" ==> Toggle capitalization: Capitalize and decapitalize <==
nnoremap fu <right>bvU
nnoremap fl <right>bvu


" ==> Commenter <==
nmap tt \cc
nmap tg \cu
vmap tt \cc
vmap tg \cu

" -> Toggle between alternate comment modes <-
nmap ta \ca


" ==> Move from word to word <==
nnoremap w W
nnoremap b B


" ==> Copy and paste <==
vmap <S-y> "+y
nmap <S-p> "+p


" ==> Save current buffer <==
nmap vv :w<cr>


" ==> Miscellaneous <==
nnoremap Q :ToggleNerdTree<cr>
nnoremap W :ToggleGoyo<cr>
nnoremap ff :FZF $ROOT<cr>
nnoremap XX ZZ
nnoremap XQ ZQ
nnoremap yp mt{v}y`t
nnoremap > >>
nnoremap < <<


" ==> Toggle tabs and buffers <==
nnoremap fw :tabprevious<cr>
nnoremap fp :tabnext<cr>
nnoremap gt <C-6>


" ==> Custom remaps <==
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


" ==> Custom selectors <== "
nnoremap ci C
nnoremap cm c^
nnoremap cn cb

nnoremap vi v$
nnoremap vm v^

nnoremap E $
nnoremap I ^

nnoremap R A
nnoremap A I

nnoremap tl ct]
nnoremap tu ct)
nnoremap ty ct}

nnoremap Tl cT[
nnoremap Tu cT(
nnoremap Ty cT{


" ==> Markers <== "
nnoremap ,t `t
nnoremap ,s `s
nnoremap ,r `r
nnoremap ,,t mt
nnoremap ,,s ms
nnoremap ,,r mr

" ==> General shortcuts <== "
nnoremap hht :Command<space>
nnoremap ht :G
nnoremap hd :ALEDetail<cr>
