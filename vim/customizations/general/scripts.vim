" ***********************************************
" *              GENERAL SCRIPTS                *
" ***********************************************

" Searches for a given pattern upwards
" -----------------------------------------------
function SearchPattern(...)
    let l:original_pos = getpos('.')
    let l:line_num = line('.')

    while l:line_num > 0
        let l:line_content = getline(l:line_num)
        let l:patterns = a:000

        for l:pattern in l:patterns
            if l:line_content =~ l:pattern
                call cursor(l:line_num, 1)
                return 0
            endif
        endfor
        let l:line_num -= 1
    endwhile

    return -1
endfunction
command! -nargs=* SearchPattern call SearchPattern(<f-args>)


" Creates a file from current ROOT directory.
" -----------------------------------------------
function! CreateEntry(...)
  call ImportPythonModules(".vim/modules/general")
  python3 << EOF
from file_manager import entry_creator

for entry in vim.eval("a:000"):
  try:
      entry_creator(entry)
  except Exception as e:
      print("{e}")
EOF
endfunction

command! -nargs=* CreateEntry call CreateEntry(<f-args>)


" Run a specified command in the terminal within
" the ROOT directory.
" -----------------------------------------------
function RootCommand(...)
  " Clear the buffer and cd ROOT env-var
  let s:command = "clear && cd " . expand('$ROOT') . " &&"
  let s:args = a:000

  for arg in s:args
    let s:command = s:command . " " . arg
  endfor

  execute "!" . s:command
endfunction

command! -nargs=* Command call RootCommand(<f-args>)


" Adds pkg based on the current project.
" -----------------------------------------------
function AddPkg(...)
    let base = $ROOT

    if empty(base)
        throw "Environment variable ROOT is not set."
    endif

    " Join arguments into a single string
    let s:command = join(a:000, ' ')

    " Helper function to handle command execution
    function! Executer(binary, command)
        if executable(a:binary)
            execute "!clear && " . a:binary . " " . a:command
        else
            throw a:binary . " is not reachable."
        endif
    endfunction

    " Check for pnpm or Cargo
    if filereadable(base . "/pnpm-lock.yaml")
        call Executer('pnpm', 'add ' . s:command)
    elseif filereadable(base . "/bun.lockb")
        call Executer('rx', 'add ' . s:command)
    elseif filereadable(base . "/Cargo.toml")
        call Executer('cargo', 'add ' . s:command)
    else
        echo "Failed to find package maanager."
    endif

endfunction
command! -nargs=* AddPkg call AddPkg(<f-args>)


let g:goyo_state = 0
function! ToggleGoyo()
    if g:goyo_state == 0
        if g:nerd_tree_state == 1
            echo "NerdTree is currently opened."
            return
        endif

        execute "normal! :Goyo\<cr>"
        let g:goyo_state = 1
    else
        execute "normal! :Goyo\<cr>"
        let g:goyo_state = 0
    endif
endfunction
command! -nargs=0 ToggleGoyo call ToggleGoyo()


let g:nerd_tree_state = 0
function! ToggleNerdTree()
    if g:goyo_state == 0 && g:nerd_tree_state == 0
        execute "normal! :NERDTree\<cr>"
        let g:nerd_tree_state = 1
    elseif g:goyo_state == 0 && g:nerd_tree_state == 1
        execute "normal! :NERDTreeClose\<cr>"
        let g:nerd_tree_state = 0
    else
        echo "Goyo is currently opened."
    endif
endfunction
command! -nargs=0 ToggleNerdTree call ToggleNerdTree()


" Ensure G is only ran when Goyo is not active.
" -----------------------------------------------
function! GitHandler()
    if g:goyo_state == 0
        execute "normal! :G\<cr>"
    else
        echo "Goyo is currently opened."
    endif
endfunction
command! -nargs=0 GG call GitHandler()


" Add empty lines to the end of file
" -----------------------------------------------
function! Spaces()
    execute "normal! G"
    for i in range(1, 11)
      call append(line("."), "")
    endfor
    execute "normal! G`s"
endfunction

command! -nargs=0 Spaces call Spaces()
