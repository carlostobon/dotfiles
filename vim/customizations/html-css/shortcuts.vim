" ***********************************************
" *              HTML-CSS SHORTCUTS             *
" ***********************************************

autocmd FileType html nnoremap t. 0/<\/<CR>i
autocmd FileType html nnoremap c. f<cT>
autocmd FileType html inoremap kkd <div></div><Esc>F>a
autocmd FileType html inoremap kkin <input type=""/><Esc>F"i
autocmd FileType html inoremap kk1 <h1></h1><Esc>FhT>i
autocmd FileType html inoremap kk2 <h2></h2><Esc>FhT>i
autocmd FileType html inoremap kk3 <h3></h3><Esc>FhT>i
autocmd FileType html inoremap kk4 <h4></h4><Esc>FhT>i
autocmd FileType html inoremap kkm <main></main><Esc>FmT>i
autocmd FileType html inoremap kksp <span></span><esc>FsT>i
autocmd FileType html inoremap kkse <section></section><esc>FsT>i
autocmd FileType html inoremap kkp <p></p><Esc>FpT>i
autocmd FileType html inoremap kku <ul><CR></ul><Esc>O
autocmd FileType html inoremap kkli <li></li><Esc>FlT>i
autocmd FileType html inoremap kkla <label></label><esc>FlT>i
autocmd FileType html inoremap kkn <nav></nav><esc>FnT>i
autocmd FileType html inoremap ' ""<Esc>i
autocmd FileType html inoremap " ''<Esc>i
autocmd FileType html inoremap kkan <a href=""></a><Esc>Fhf"a
autocmd FileType html inoremap kkim <img src="" alt=""/><esc>fsf"a
autocmd FileType html inoremap kkcn class=""<esc>i
autocmd FileType html inoremap kkb <button></button><esc>F{a


" ============ CSS ============
autocmd FileType css inoremap kkgcs grid-column-start:<space>
autocmd FileType css inoremap kkgce grid-column-end:<space>

" Adds display class and its corresponded aligns with Flex
autocmd FileType css inoremap kkdf display:<space>flex;<CR>
                  \justify-content:<space>center;<CR>
                  \align-items:<space>center;

" Adds display class and its corresponded aligns with Grid
autocmd FileType css inoremap kkdg display:<space>grid;<CR>
                  \grid-template-columns: repeat(, 1fr);<CR>
                  \grid-template-rows: repeat(, 1fr);<CR>
                  \align-items:<space>center;<esc>kkf,i

autocmd FileType css inoremap kkbg background-color:<space>
autocmd FileType css inoremap kkff font-family:<space>
autocmd FileType css inoremap kkfs font-size:<space>
autocmd FileType css inoremap kkfw font-weight:<space>
autocmd FileType css inoremap kkcc color:<space>
autocmd FileType css inoremap kkmg margin:<space>
autocmd FileType css inoremap kkpd padding:<space>
