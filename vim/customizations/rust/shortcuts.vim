" ***********************************************
" *              RUST SHORTCUTS                 *
" ***********************************************

autocmd FileType rust nnoremap hp ms:RustAddPublic<CR>
autocmd FileType rust nnoremap ha ms:RustAddAsync<CR>
autocmd FileType rust nnoremap hf ms:RustAddMacro<CR>
autocmd FileType rust nnoremap hx ms:RustToggleMutability<CR>
autocmd FileType rust nnoremap hc ms:RustToggleVar<CR>
autocmd FileType rust nnoremap hi :Implement<space>
autocmd FileType rust nnoremap ti 0f}i<cr><esc>O
autocmd FileType rust nnoremap tn ms:RustToggleSignature<CR>

autocmd FileType rust nnoremap hhf :CreateFile<space>
autocmd FileType rust nnoremap hha :AddPkg<space>
autocmd FileType rust nnoremap hhr :!clear; cargo run --<space>
autocmd FileType rust nnoremap hht :!clear; cargo test<cr>

" Adds macro to disable warnings
autocmd FileType rust nnoremap hm msggO
      \#![allow(dead_code, unused_variables,
      \ unused_imports, unused_assignments)]<cr><esc>`s

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

" Adds a test interface
autocmd FileType rust inoremap kkc #[cfg(test)]<cr>
      \ mod tests {<cr>use super::*;<cr><cr><left><space>#[test]<cr><left><space>
      \ fn xx() {<cr>}<cr>}<up><up><esc>fxcw

autocmd FileType rust inoremap " ''<esc>i
autocmd FileType rust inoremap ' ""<esc>i
