" ***********************************************
" *          FINE-GRAINED MAPPINGS              *
" * Custom mappings for commonly used languages *
" ***********************************************

" ============ RUST ============
autocmd FileType rust nnoremap tp msIpub<space><esc>`s
autocmd FileType rust nnoremap hp ms:RustSearch<cr>Ipub <esc>`s
autocmd FileType rust nnoremap ha ms:RustSearch<cr>f(BBiasync <esc>`s
autocmd FileType rust nnoremap hm ms:GeneralSearch fn<cr>O#[]<esc>i
autocmd FileType rust nnoremap hd :GeneralSearch struct<cr>O#[derive()]<esc>F)i
autocmd FileType rust nnoremap hc lbi_<esc> " variable => _variable
autocmd FileType rust nnoremap hb f}i<cr><esc>O
autocmd FileType rust nnoremap hhf :CreateFile<space>
autocmd FileType rust nnoremap hha :AddPkg<space>
autocmd FileType rust nnoremap hhr :!clear; cargo run --
autocmd FileType rust inoremap kkp println!("{}", );<esc>F{i
autocmd FileType rust inoremap kkq assert_eq!(, );<esc>T(i
autocmd FileType rust inoremap kkb assert!();<esc>T(i
autocmd FileType rust inoremap kkf fn () {}<esc>F(i
autocmd FileType rust inoremap kka async fn () {}<esc>F(i
autocmd FileType rust inoremap kkd #[derive()]<esc>F(a
autocmd FileType rust inoremap kkm #[]<esc>i
autocmd FileType rust inoremap kkt #[test]<cr>fn xx() {<cr>}<up><esc>fxcw
autocmd FileType rust inoremap kki impl x for {<cr>}<up><esc>fxcw
autocmd FileType rust inoremap kks struct x {}<esc>Fxcw
autocmd FileType rust inoremap " ''<esc>i
autocmd FileType rust inoremap ' ""<esc>i

" Adds macro to disable warnings
autocmd FileType rust nnoremap hs msggO
      \#![allow(dead_code, unused_variables,
      \ unused_imports, unused_assignments)]<cr><esc>`s


" Adds a test interface
autocmd FileType rust inoremap kkc #[cfg(test)]<cr>
      \ mod tests {<cr>use super::*;<cr><cr><left><space>#[test]<cr><left><space>
      \ fn xx() {<cr>}<cr>}<up><up><esc>fxcw



" ============ TYPESCRIPTREACT ============
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
autocmd FileType typescriptreact inoremap kkli <li></li><Esc>FlT>i
autocmd FileType typescriptreact inoremap kkla <label></label><esc>FlT>i
autocmd FileType typescriptreact inoremap kkn <nav></nav><esc>FnT>i
autocmd FileType typescriptreact inoremap kka <a href=""></a><esc>Fhf"a
autocmd FileType typescriptreact inoremap kklo console.log()<esc>i
autocmd FileType typescriptreact inoremap kkim <img src={} alt="" /><esc>Frf}i
autocmd FileType typescriptreact inoremap kkc className=""<esc>i
autocmd FileType typescriptreact inoremap kkb <button onClick={() => {}}></button><esc>F/hi
autocmd FileType typescriptreact inoremap ' ""<Esc>i
autocmd FileType typescriptreact inoremap " ''<Esc>i

autocmd FileType typescriptreact nnoremap hhc :ReactComp<space>
autocmd FileType typescriptreact nnoremap hhp :ReactPage<space>
autocmd FileType typescriptreact nnoremap hhl :ReactLayout<space>
autocmd FileType typescriptreact nnoremap hhf :CreateFile<space>

autocmd FileType typescriptreact nnoremap hhr :Command pnpm run dev
autocmd FileType typescriptreact nnoremap hha :AddPkg<space>
autocmd FileType typescriptreact nnoremap hhx :Command pnpx<space>
autocmd FileType typescriptreact nnoremap hhs :Command shadcn<space>

autocmd FileType typescriptreact nnoremap t. 0/<\/<CR>i
autocmd FileType typescriptreact nnoremap t, 0/[^=]><cr>li<cr><esc>OclassName=""<esc>i<cr><esc>O
autocmd FileType typescriptreact nnoremap c. 0f>lct<

" Adds a basic function component with
" structure function
autocmd FileType typescriptreact inoremap kkf function x()
                  \ {<cr><esc>O<tab>return<space>
                  \ (<cr><div>Hello function</div><cr>)
                  \<cr>}<esc>{<down>fxcw


" Adds a basic function component with
" structure const
autocmd FileType typescriptreact inoremap kkw const x = ()
                  \ => {<cr><tab>return
                  \ (<cr><div>Hello Component</div><cr>)
                  \<cr>}<esc>{<down>fxcw


" Adds the sequence to import from react
autocmd FileType typescriptreact nnoremap hr ms:NextImporter react<cr>


" Adds the sequence to import from components
autocmd FileType typescriptreact nnoremap hc ms:NextImporter @/components/index<cr>


" Adds the sequence to import from components/ui
" it's specifically used to import shadcn components
autocmd FileType typescriptreact nnoremap hs ms:NextImporter @/components/ui/index<cr>


" Adds regulas import statement
autocmd FileType typescriptreact nnoremap hi msgg}o
                  \import {  } from ""<esc>i


" Adds use client declaration
autocmd FileType typescriptreact nnoremap hu msgg<down>i
                  \"use client"<cr><esc>`s


" Breaks {} statement
autocmd FileType typescriptreact nnoremap hb f}i<cr><esc>O


" ============ HTML ============
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
autocmd FileType css inoremap gcs grid-column-start:<space>
autocmd FileType css inoremap gce grid-column-end:<space>

" Adds display class and its corresponded aligns with Flex
autocmd FileType css inoremap df display:<space>flex;<CR>
                  \justify-content:<space>center;<CR>
                  \align-items:<space>center;

" Adds display class and its corresponded aligns with Grid
autocmd FileType css inoremap dg display:<space>grid;<CR>
                  \grid-template-columns: repeat(, 1fr);<CR>
                  \grid-template-rows: repeat(, 1fr);<CR>
                  \align-items:<space>center;<esc>kkf,i

autocmd FileType css inoremap bg background-color:<space>
autocmd FileType css inoremap ff font-family:<space>
autocmd FileType css inoremap fs font-size:<space>
autocmd FileType css inoremap fw font-weight:<space>
autocmd FileType css inoremap cc color:<space>
autocmd FileType css inoremap mg margin:<space>
autocmd FileType css inoremap pd padding:<space>


" ============ PYTHON ============
autocmd FileType python nnoremap hhr :!clear; python main.py
autocmd FileType python inoremap kkf def ():<esc>F(i
autocmd FileType python inoremap kki if __name__ == "__main__":<cr>
"autocmd FileType python xmap kk <Plug>SlimeRegionSend
"autocmd FileType python nmap kk <Plug>SlimeParagraphSend
