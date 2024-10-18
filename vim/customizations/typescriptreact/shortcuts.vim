" ***********************************************
" *          TYPESCRIPTREACT SHORTCUTS          *
" ***********************************************

autocmd FileType typescriptreact inoremap kkd <div></div><Esc>F>a
autocmd FileType typescriptreact inoremap kkin <input type=""/><Esc>F"i
autocmd FileType typescriptreact inoremap kk1 <h1></h1><Esc>FhT>i
autocmd FileType typescriptreact inoremap kk2 <h2></h2><Esc>FhT>i
autocmd FileType typescriptreact inoremap kk3 <h3></h3><Esc>FhT>i
autocmd FileType typescriptreact inoremap kk4 <h4></h4><Esc>FhT>i
autocmd FileType typescriptreact inoremap kkm <main></main><Esc>FmT>i
autocmd FileType typescriptreact inoremap kksp <span></span><esc>FsT>i
autocmd FileType typescriptreact inoremap kkse <section></section><esc>FsT>i
autocmd FileType typescriptreact inoremap kkp <p></p><Esc>FpT>i
autocmd FileType typescriptreact inoremap kku <ul><CR></ul><Esc>O
autocmd FileType typescriptreact inoremap kkli <li></li><Esc>T>i
autocmd FileType typescriptreact inoremap kkla <label></label><esc>FlT>i
autocmd FileType typescriptreact inoremap kkn <nav></nav><esc>FnT>i
autocmd FileType typescriptreact inoremap kka <a href=""></a><esc>Fhf"a
autocmd FileType typescriptreact inoremap kklo console.log()<esc>i
autocmd FileType typescriptreact inoremap kkim <img src={} alt="" /><esc>Frf}i
autocmd FileType typescriptreact inoremap kkc className=""<esc>i
autocmd FileType typescriptreact inoremap kkb <button type="button" onClick={() => {}}></button><esc>F/hi
autocmd FileType typescriptreact inoremap kkf function x() {}<esc>Fxcw
autocmd FileType typescriptreact inoremap ' ""<Esc>i
autocmd FileType typescriptreact inoremap " ''<Esc>i

autocmd FileType typescriptreact nnoremap hhc :ReactComp<space>
autocmd FileType typescriptreact nnoremap hhp :ReactRoute<space>
autocmd FileType typescriptreact nnoremap hhl :NextLayout<space>
autocmd FileType typescriptreact nnoremap hhf :CreateEntry<space>

autocmd FileType typescriptreact nnoremap hha :AddPkg<space>
autocmd FileType typescriptreact nnoremap hhx :Command<space>

autocmd FileType typescriptreact nnoremap t. 0/<\/<cr>i
autocmd FileType typescriptreact nnoremap tn :AddClassName<cr>
autocmd FileType typescriptreact nnoremap t, 0/[^=]><cr>li<cr><esc>OclassName=""<esc>i<cr><esc>O
autocmd FileType typescriptreact nnoremap c. 0/[^=]><cr>llct<

" Adds a basic function component with
" structure function
autocmd FileType typescriptreact inoremap kkq function x()
                  \ {<cr><esc>O<tab>return<space>
                  \ (<cr><div>Hello function</div><cr>)
                  \<cr>}<esc>{<down>fxcw


" Adds a basic function component with
" structure const
autocmd FileType typescriptreact inoremap kkw const x = ()
                  \ => {<cr><tab>return
                  \ (<cr><div>Hello Component</div><cr>)
                  \<cr>}<esc>{<down>fxcw


" Adds props to first component finds upwards.
autocmd FileType typescriptreact nnoremap hp :Props<cr>

" Adds the sequence to import from react.
autocmd FileType typescriptreact nnoremap hr ms:ReactImporter react<cr>


" Adds the sequence to import from framework.
autocmd FileType typescriptreact nnoremap hf ms:ReactImporter next<cr><esc>fta/


" Adds the sequence to import from components
autocmd FileType typescriptreact nnoremap hc ms:ReactImporter @/components/index<cr>


" Adds the sequence to import from components/ui
" it's specifically used to import shadcn components
autocmd FileType typescriptreact nnoremap ha ms:ReactImporter @/components/ui/index<cr>


" Adds regular import statement
autocmd FileType typescriptreact nnoremap hi msgg}o
                  \import {  } from "";<esc>hi


" Adds use client declaration
autocmd FileType typescriptreact nnoremap hu msgg<down>i
                  \"use client"<cr><esc>`s

" Adds empty lines to the end of file
autocmd FileType typescriptreact nnoremap hs ms:Spaces<cr>

" Breaks {} statement
autocmd FileType typescriptreact nnoremap ti 0f}i<cr><esc>O
