" ==== Rust ====
autocmd FileType rust nnoremap hhp msIpub<space><esc>`s
autocmd FileType rust nnoremap hp ms:SearchUp<cr>Ipub <esc>`s
autocmd FileType rust nnoremap ha ms:SearchUp<cr>f(BBiasync <esc>`s
autocmd FileType rust nnoremap hm :SearchUp<cr>O#[]<esc>i
autocmd FileType rust nnoremap ht ms:SearchUp<cr>O#[test]<esc>`s
autocmd FileType rust nnoremap hs msggO
      \#![allow(dead_code, unused_variables, unused_imports, unused_assignments)]<cr><esc>`s
autocmd FileType rust nnoremap hc lbi_<esc> " variable => _variable
autocmd FileType rust nnoremap hb f}i<cr><esc>O
autocmd FileType rust nnoremap hi :!cargo add<space>
autocmd FileType rust inoremap kkpr println!("{}", );<esc>hi
autocmd FileType rust inoremap kkq assert_eq!(, );<esc>T(i
autocmd FileType rust inoremap kkb assert!();<esc>T(i
autocmd FileType rust inoremap kkf fn () {<cr>}<esc><up>f(i
autocmd FileType rust inoremap kka async fn () {<cr>}<esc><up>f(i
autocmd FileType rust inoremap kkd #[derive()]<esc>F(a
autocmd FileType rust inoremap kkm #[]<esc>i
autocmd FileType rust inoremap kkc #[cfg(test)]<cr>
      \ mod tests {<cr>use super::*;<cr><cr><left><space>#[test]<cr><left><space>
      \ fn xx() {<cr>}<cr>}<up><up><esc>fxcw
autocmd FileType rust inoremap kkt #[test]<cr>fn xx() {<cr>}<up><esc>fxcw
autocmd FileType rust inoremap " ''<esc>i
autocmd FileType rust inoremap ' ""<esc>i
autocmd FileType rust inoremap kki impl x for {<cr>}<up><esc>fxcw
autocmd FileType rust inoremap kks struct x {}<esc>Fxcw
autocmd FileType rust nnoremap <space>mm :!clear; cargo run --



" ==== Html and React ====
autocmd FileType html,typescriptreact inoremap kkd <div></div><Esc>F>a
autocmd FileType html,typescriptreact inoremap kkin <input type=""/><Esc>F"i
autocmd FileType html,typescriptreact inoremap kk1 <h1></h1><Esc>FhT>i
autocmd FileType html,typescriptreact inoremap kk2 <h2></h2><Esc>FhT>i
autocmd FileType html,typescriptreact inoremap kk3 <h3></h3><Esc>FhT>i
autocmd FileType html,typescriptreact inoremap kk4 <h4></h4><Esc>FhT>i
autocmd FileType html,typescriptreact inoremap kkm <main></main><Esc>FmT>i
autocmd FileType html,typescriptreact inoremap kksp <span></span><esc>FsT>i
autocmd FileType html,typescriptreact inoremap kkse <section></section><esc>FsT>i
autocmd FileType html,typescriptreact inoremap kkp <p></p><Esc>FpT>i
autocmd FileType html,typescriptreact inoremap kku <ul><CR></ul><Esc>O
autocmd FileType html,typescriptreact inoremap kkli <li></li><Esc>FlT>i
autocmd FileType html,typescriptreact inoremap kkfo <form></form><esc>FfT>i
autocmd FileType html,typescriptreact inoremap kkla <label></label><esc>FlT>i
autocmd FileType html,typescriptreact inoremap kkna <nav></nav><esc>FnT>i
autocmd FileType html,typescriptreact nnoremap tg I{/*<esc>A*/}<esc>^
autocmd FileType html,typescriptreact nnoremap tk ^xxx<esc>$xxx<esc>^
autocmd FileType html,typescriptreact nnoremap c. f<cT>
autocmd FileType html,typescriptreact inoremap ' ""<Esc>i
autocmd FileType html,typescriptreact inoremap " ''<Esc>i
autocmd FileType html,typescriptreact nnoremap hc :ReactComp<space>
autocmd FileType html,typescriptreact nnoremap hp :ReactPage<space>

autocmd FileType typescriptreact inoremap kkan <a href=""></a><esc>Fhf"a
autocmd FileType typescriptreact inoremap kklo console.log()<esc>i
autocmd FileType typescriptreact inoremap kkim <img src={} alt="" /><esc>Frf}i
autocmd FileType typescriptreact inoremap kkcl className=""<esc>i
autocmd FileType typescriptreact inoremap kkb <button onClick={}></button><esc>F/hi
autocmd FileType typescriptreact nnoremap <space>mm :!clear; pnpm run dev

autocmd FileType typescriptreact nnoremap hr msgg}oimport {  } from "react"<esc>F}<left>i
autocmd FileType typescriptreact nnoremap hi msgg}oimport {  } from "@components/index"<esc>F}<left>i
autocmd FileType typescriptreact nnoremap hu msgg<down>i"use client"<cr><esc>`s

autocmd FileType html inoremap kkan <a href=""></a><Esc>Fhf"a
autocmd FileType html inoremap kkim <img src="" alt=""/><esc>fsf"a
autocmd FileType html inoremap kkcn class=""<esc>i
autocmd FileType html inoremap kkb <button></button><esc>F{a



" ==== CSS ====
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



" ==== Python ====
autocmd FileType python nnoremap <space>mm :!clear; python main.py
autocmd FileType python inoremap kkf def ():<esc>F(i
autocmd FileType python inoremap kki if __name__ == "__main__":<cr>
"autocmd FileType python xmap kk <Plug>SlimeRegionSend
"autocmd FileType python nmap kk <Plug>SlimeParagraphSend
