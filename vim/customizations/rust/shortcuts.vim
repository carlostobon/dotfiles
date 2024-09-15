" ***********************************************
" *              RUST SHORTCUTS                 *
" ***********************************************

autocmd FileType rust nnoremap tp msIpub<space><esc>`s
autocmd FileType rust nnoremap hp ms:RustSearch<cr>Ipub <esc>`s
autocmd FileType rust nnoremap ha ms:RustSearch<cr>f(BBiasync <esc>`s
autocmd FileType rust nnoremap hm ms:GeneralSearch fn<cr>O#[]<esc>i
autocmd FileType rust nnoremap hd :GeneralSearch struct<cr>O#[derive()]<esc>F)i
autocmd FileType rust nnoremap hc lbi_<esc> " variable => _variable
autocmd FileType rust nnoremap hb 0f}i<cr><esc>O
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
