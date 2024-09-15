" ***********************************************
" *             PYTHON SHORTCUTS                *
" ***********************************************

autocmd FileType python nnoremap hhr :!clear; python main.py
autocmd FileType python inoremap kkf def ():<esc>F(i
autocmd FileType python inoremap kki if __name__ == "__main__":<cr>
"autocmd FileType python xmap kk <Plug>SlimeRegionSend
"autocmd FileType python nmap kk <Plug>SlimeParagraphSend
