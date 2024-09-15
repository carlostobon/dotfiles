" ***********************************************
" *              RUST SCRIPTS                   *
" ***********************************************

" *** RustCodeSearcher ***
" Searches upwards for patterns like fn, struct,
" trait, enum, and type.
function! RustCodeSearcher()
    " Save the original position
    let l:original_pos = getpos('.')

    " Start from the current line
    let l:line_num = line('.')

    " Loop to search each line upwards
    while l:line_num > 0
        " Get the content of the current line
        let l:line_content = getline(l:line_num)

        " Patterns
        let l:patterns = ['fn', 'struct', 'trait', 'enum', 'type']

        " Check if the pattern is in the line
        for pattern in patterns
          if l:line_content =~ pattern
              " Move the cursor to the matching line
              call cursor(l:line_num, 1)
              echo "Pattern found at line " . l:line_num
              return
          endif
        endfor


        " Move to the previous line
        let l:line_num -= 1
    endwhile

    " If pattern is not found, move back to the original position
    call setpos('.', l:original_pos)
    echo "Pattern not found"
endfunction

" Map the function to a command for easier usage
command! -nargs=0 RustSearch call RustCodeSearcher()
