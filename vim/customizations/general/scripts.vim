" ***********************************************
" *              GENERAL SCRIPTS                *
" ***********************************************

" -----------------------------------------------
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


" *** CreateFile ***
" Creates a file from current ROOT directory.
function! CreateFile(path)
  python3 << EOF

from pathlib import Path
import os

def create_file(path: str):
  path = Path(path)

  # Gets environment var ROOT
  project_dir = os.getenv("ROOT")

  target_path = Path(project_dir).joinpath(path)

  if target_path.exists():
    print("File already exists.")
    return

  try:
    target_path.parent.mkdir(parents=True, exist_ok=True)
  except Exception as e:
    print("Error while making parents: {}".format(e))

  try:
    with open(target_path, "w") as file:
      file.write("// {}".format(path))

  except OSError as e:
    print("Something when wrong: {}".format(e))
    return

  print("File {} created.".format(path))


create_file(vim.eval('a:path'))
EOF
endfunction

command! -nargs=1 CreateFile call CreateFile(<f-args>)


" *** Command ***
" Run a specified command in the terminal within
" the ROOT directory.
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



" *** AddPkg ***
" Adds pkg based on the current project.
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
    elseif filereadable(base . "/Cargo.toml")
        call Executer('cargo', 'add ' . s:command)
    elseif filereadable("./Cargo.toml")
        call Executer('cargo', 'add ' . s:command)
    else
        echo "Nothing to do here."
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

        execute "normal! :Goyo 75%+90%x100%\<cr>"
        let g:goyo_state = 1
    else
        execute "normal! :Goyo\<cr>"
        let g:goyo_state = 0
    endif
endfunction
command! -nargs=0 ToggleGoyo call ToggleGoyo()


let g:nerd_tree_state = 0
function! ToggleNerdTree()
    if g:goyo_state == 0
        execute "normal! :NERDTreeToggle\<cr>"
        let g:nerd_tree_state = !g:nerd_tree_state
    else
        echo "Goyo is currently opened."
    endif
endfunction
command! -nargs=0 ToggleNerdTree call ToggleNerdTree()
