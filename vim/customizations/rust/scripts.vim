" ***********************************************
" *              RUST SCRIPTS                   *
" ***********************************************


" -----------------------------------------------
"  Makes an expression public
" -----------------------------------------------
function RustAddPublic()
    let l:result = SearchPattern("fn", "struct", "trait", "enum", "type")
    let l:line_content = getline('.')

    " pub was found in current line
    if match(l:line_content, 'pub\s') != -1
        echo "Expression is already public."
        execute "normal! `s"
        return
    endif

    if l:result == 0
        execute "normal! Ipub \<esc>`s"
    else
        echo "Failed to find pattern."
    endif
endfunction
autocmd FileType rust command! -nargs=0 RustAddPublic call RustAddPublic()


" -----------------------------------------------
"  Add async to a given function
" -----------------------------------------------
function RustAddAsync()
    let l:result = SearchPattern("fn")
    let l:line_content = getline('.')

    " async was found in current line
    if match(l:line_content, 'async\s') != -1
        echo "Function is already asynchronous."
        execute "normal! `s"
        return
    endif

    if l:result == 0
        execute "normal! ^f(BBiasync \<esc>`s"
    else
        echo "Failed to find pattern."
    endif
endfunction
autocmd FileType rust command! -nargs=0 RustAddAsync call RustAddAsync()


" -----------------------------------------------
"  Add a macro to a function or structure
" -----------------------------------------------
function RustAddMacro()
    let l:result = SearchPattern("fn", "struct")
    let l:line_content = getline('.')

    if l:result == 0
        execute "normal! O#[]"
        startinsert
    else
        echo "Failed to find pattern."
    endif
endfunction
autocmd FileType rust command! -nargs=0 RustAddMacro call RustAddMacro()


" -----------------------------------------------
"  Toggle variable usage
" -----------------------------------------------
function RustToggleVar()
    let l:line_content = getline('.')

    if match(l:line_content, 'let\s[^_][a-z_]\+') != -1
        execute "normal! ^wi_\<esc>`s"

    elseif match(l:line_content, 'let\s_[a-z_]\+') != -1
        execute "normal! ^wx`s"

    else
        echo "Failed to find pattern."
    endif
endfunction
autocmd FileType rust command! -nargs=0 RustToggleVar call RustToggleVar()


" -----------------------------------------------
"  Scafold of a given trait
" -----------------------------------------------
function Implement(trait)
    if a:trait == "from"
        let lines = [
            \ '',
            \ 'impl From<T> for V {',
            \ 'fn from(x: T) -> Self {}',
            \ '}',
            \ ''
        \ ]

        execute "normal! i" . join(lines, "\n")
        execute "normal! kkkfT"

    else
        echo "Unknown implementation"
    endif
endfunction
autocmd FileType rust command! -nargs=1 Implement call Implement(<f-args>)
