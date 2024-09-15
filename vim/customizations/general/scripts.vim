" ***********************************************
" *              GENERAL SCRIPTS                *
" ***********************************************


" *** GeneralSeach ***
" Searches for a given pattern upwards
function! GeneralSearch(pattern)
    " Save the original position
    let l:original_pos = getpos('.')

    " Start from the current line
    let l:line_num = line('.')

    " Loop to search each line upwards
    while l:line_num > 0
        " Get the content of the current line
        let l:line_content = getline(l:line_num)

        " Check if the pattern is in the line
          if l:line_content =~ a:pattern

              " Move the cursor to the matching line
              call cursor(l:line_num, 1)

              return
          endif

        " Move to the previous line
        let l:line_num -= 1
    endwhile

    " If pattern is not found, move back to the original position
    call setpos('.', l:original_pos)
    echo "Pattern not found."
endfunction

" Map the function to a command for easier usage
command! -nargs=1 GeneralSearch call GeneralSearch(<f-args>)



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
    else
        echo "Nothing to do here."
    endif

endfunction
command! -nargs=* AddPkg call AddPkg(<f-args>)
