" ***********************************************
" *              RUST SCRIPTS                   *
" ***********************************************

" Toggle visibility state for the expression
" ==========================================
function RustAddPublic()
    let l:result = SearchPattern("fn", "struct", "trait", "enum", "type")
    let l:line_content = getline('.')

    " pub was found in current line
    if match(l:line_content, 'pub\s') != -1
        execute "normal! ^dw`s"
        return
    endif

    if l:result == 0
        execute "normal! Ipub \<esc>`s"
    else
        echo "Failed to find pattern."
    endif
endfunction
autocmd FileType rust command! -nargs=0 RustAddPublic call RustAddPublic()


" Toggle async state for the function
" ====================================
function RustAddAsync()
    let l:result = SearchPattern("fn")
    let l:line_content = getline('.')

    " async was found in current line
    if match(l:line_content, 'async\s') != -1
        execute "normal! :s/async\<space>//\<cr>`s"
        return
    endif

    if l:result == 0
        "execute "normal! ^f(BBiasync \<esc>`s"
        execute "normal! ^fn\<left>iasync \<esc>`s"
    else
        echo "Failed to find pattern."
    endif
endfunction
autocmd FileType rust command! -nargs=0 RustAddAsync call RustAddAsync()


" Add a macro to a function or structure
" ======================================
function RustAddMacro()
    let l:result = SearchPattern("fn", "struct", "enum")
    let l:line_content = getline('.')

    if l:result == 0
        execute "normal! O#[]"
        startinsert
    else
        echo "Failed to find pattern."
    endif
endfunction
autocmd FileType rust command! -nargs=0 RustAddMacro call RustAddMacro()


" Toggle variable usage
" =====================
function RustToggleVar()
    let l:line_content = getline('.')

    if match(l:line_content, 'let.*\s[^_][a-z_]\+\s=') != -1
        execute "normal! ^f=Bi_\<esc>`s\<right>"

    elseif match(l:line_content, 'let\(\smut\)\?\s_') != -1
        execute "normal! ^f=Bx`s\<left>"

    else
        echo "Failed to find pattern."
    endif
endfunction
autocmd FileType rust command! -nargs=0 RustToggleVar call RustToggleVar()


" Toggle variable mutability
" ==========================
function RustToggleMutability()
    let l:line_content = getline('.')

    if match(l:line_content, 'let\smut') != -1
        execute "normal! ^wdiwx`s4\<left>"

    elseif match(l:line_content, 'let') != -1
        execute "normal! ^wimut\<space>\<esc>`s4\<right>"

    else
        echo "Failed to find pattern."
    endif
endfunction
autocmd FileType rust command! -nargs=0 RustToggleMutability call RustToggleMutability()


" Toggle Signature
" ==========================
function RustToggleSignature()
    let l:result = SearchPattern("fn")
    let l:line_content = getline('.')

    if l:result == -1
        echo "Failed to find pattern."
        return
    endif

    if match (l:line_content, '\->.*{') != -1
        execute "normal! f-dt{`s"

    elseif match(l:line_content, '\->.*') != -1
        execute "normal! f-D`s"

    elseif match(l:line_content, '.*{') != -1
        execute "normal! ^f)a\<space>->\<space>\<right>"
        startinsert
    else
        execute "normal! ^f)a\<space>->\<space>\<space>"
        startinsert
    endif
endfunction
autocmd FileType rust command! -nargs=0 RustToggleSignature call RustToggleSignature()


" Scaffold for implementing the given trait
" =========================================
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


" Wildcard to comment singular variables
" =======================================
function SingularComment()
    let current_word = expand('<cword>')
    let first_char = current_word[0]

    if first_char == '_'
        execute "normal! bx`s\<left>"
    else
        execute "normal! bi_\<esc>`s\<right>"
    endif

endfunction
autocmd FileType rust command! -nargs=0 SingularComment call SingularComment()
