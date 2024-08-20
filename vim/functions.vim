" ===================================
" Creates a component in NextJS from Vim.
" ===================================
"
function! CreateReactComp(name)
  python3 << EOF

import os
import vim
from pathlib import Path

def create_react_component(path: str):

  # Gets environment var FOLDER
  project_dir = os.getenv("FOLDER")

  if not project_dir:
    print("Environment var FOLDER not found.")
    return

  path = Path(path.lower())
  name = path.name
  names = path.name.strip().split('-')
  #
  # Adds name as folder to hold the component.
  path = path.joinpath(path.name)

  # Creates a convenient pascal case name
  pascal_case_name = ""
  for word in names:
    pascal_case_name += word.capitalize()


  components_path = Path(project_dir).joinpath("components")
  component_parent = components_path.joinpath(path.parent)

  try:
    os.makedirs(component_parent)
  except OSError as e:
    print(f"Error creating directory '{component_parent}': {e}")
    return

  component_name = component_parent / str(name + ".tsx")

  try:
    with open(component_name, "w") as file:
        file.write(
            """// components/{}.tsx

interface {}Props {{}}

export default function {}({{ }}: {}Props) {{
  return (
    <div>Hello, {}!</div>
  )
}}
    """.format(
        path.parent / name,
        pascal_case_name,
        pascal_case_name,
        pascal_case_name,
        pascal_case_name
    ))


  except Exception as error:
    print(f"Error while writting component: {error}")
    return

  # This section adds component to index.ts
  #
  statement = (
      'export {{ default as {} }} from "./{}/{}"\n'.format(
          pascal_case_name,
          path.parent,
          name,
      )
  )

  try:
    with open(components_path / "index.ts", "r") as file:
      content = file.read()
    with open(components_path / "index.ts", "w") as file:
      file.write(content + statement)

  except FileNotFoundError:
    with open(components_path / "index.ts", "w") as file:
      file.write(statement)


  print("Component {} created.".format(pascal_case_name))

create_react_component(vim.eval('a:name'))

EOF
endfunction


command! -nargs=1 ReactComp call CreateReactComp(<f-args>)



" ===================================
" Creates a page in NextJS from Vim.
" ===================================
"
function! CreateReactPage(name)
  python3 << EOF

import os
import vim
from pathlib import Path

def create_react_page(path: str):

  # Gets environment var FOLDER
  project_dir = os.getenv("FOLDER")

  if not project_dir:
    print("Environment var FOLDER not found.")
    return


  path = Path(path)
  parent = Path(project_dir) / "app" / path

  names = path.name.strip().lower().split('-')

  # Creates a convenient pascal case name
  pascal_case_name = ""
  for word in names:
    pascal_case_name += word.capitalize()


  try:
    os.makedirs(parent, exist_ok=True)
  except OSError as e:
    print(f"Error creating directory '{path}': {e}")
    return


  with open(parent / "page.tsx", "w") as file:
    file.write(
            """// {}/page.tsx

export default function {}() {{
  return (
    <div>Hello, {}!</div>
  )
}}
            """.format(
              path,
              pascal_case_name,
              path.name))

  print("Page {} created.".format(path))

create_react_page(vim.eval('a:name'))

EOF
endfunction

command! -nargs=1 ReactPage call CreateReactPage(<f-args>)



" ===================================
" Creates a layout in NextJS from Vim.
" ===================================
"
function! CreateReactLayout(name)
  python3 << EOF

import os
import vim
from pathlib import Path

def create_react_layout(path: str):

  # Gets environment var FOLDER
  project_dir = os.getenv("FOLDER")

  if not project_dir:
    print("Environment var FOLDER not found.")
    return


  path = Path(path)
  parent = Path(project_dir) / "app" / path

  names = path.name.strip().lower().split('-')

  # Creates a convenient pascal case name
  pascal_case_name = ""
  for word in names:
    pascal_case_name += word.capitalize()


  try:
    os.makedirs(parent, exist_ok=True)
  except OSError as e:
    print(f"Error creating directory '{path}': {e}")
    return


  with open(parent / "layout.tsx", "w") as file:
    file.write(
            """// {}/layout.tsx

export default function {}Layout({{
  children,
}}: {{ children: React.ReactNode }}) {{
  return (
  <>{{children}}</>
  )
}}
            """.format(
              path,
              pascal_case_name))

  print("Layout {} created.".format(path))

create_react_layout(vim.eval('a:name'))

EOF
endfunction

command! -nargs=1 ReactLayout call CreateReactLayout(<f-args>)



" ===================================
" Helpful function to search upwards
" ===================================
" Thi script is used for Rust coding
"
function! RustCodeSearcher()
    " Save the original position
    let l:original_pos = getpos('.')

    " Start from the current line
    let l:line_num = line('.')

    " Loop to search each line upwards
    while l:line_num > 0
        " Get the content of the current line
        let l:line_content = getline(l:line_num)

        let l:patterns = ['fn', 'struct', 'trait', 'enum']
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


" ===================================
" Import in Nextjs by pattern
" ===================================
"
function! NextImporter(pattern)
  " Save the original cursor position
  let l:original_pos = getpos('.')

  " Initialize the current line number to the cursor's current line
  let l:current_line = line('.')


  let l:import_statement = 'import {  } from "' . a:pattern . '"'

  " Loop until the top of the file is reached
  while l:current_line > 0
    " Get the content of the current line
    let l:line_content = getline(l:current_line)

    " Check if the current line matches the pattern in an exact way
    if l:line_content =~ '"' . a:pattern . '"'
      " Move the cursor to the start of the matched line
      call cursor(l:current_line, 1)
      " Insert a comma and space after the closing brace
      execute "normal! f}\<left>i, \<right>"
      startinsert
      return
    endif
    " Move to the previous line
    let l:current_line -= 1
  endwhile

  execute "normal! gg}o" . l:import_statement . "\<Esc>F}\<left>"
  startinsert
endfunction

command! -nargs=1 NextImporter call NextImporter(<f-args>)



" ===================================
" File creator for vim base $FOLDER
" ===================================
" Creates files from the FOLDER dir.
"

function! CreateFile(path)
  python3 << EOF

from pathlib import Path
import os

def create_file(path: str):
  path = Path(path)

  # Gets environment var FOLDER
  project_dir = os.getenv("FOLDER")

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


" ===================================
" Command runner
" ===================================
" A simple function to run bash commands
" from Vim
"
function Command(...)
  " Clear the buffer and cd FOLDER var
  let s:command = "clear && cd " . expand('$FOLDER') . "; "
  let s:args = a:000

  for arg in s:args
    let s:command = s:command . " " . arg
  endfor

  execute "!" . s:command
endfunction

command! -nargs=* Command call Command(<f-args>)
