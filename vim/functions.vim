
" Creates a component in NextJS from Vim.
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

  path = Path(path)
  names = path.name.strip().lower().split('-')
  #
  # Adds name as folder to hold the component.
  path = path.joinpath(path.name)

  # Creates a convenient pascal case name
  pascal_case_name = ""
  for word in names:
    pascal_case_name += word.capitalize()


  components_path = Path(project_dir).joinpath("app/components")
  component_parent = components_path.joinpath(path.parent)

  try:
    os.makedirs(component_parent)
  except OSError as e:
    print(f"Error creating directory '{component_dir}': {e}")
    return

  component_name = component_parent / str(pascal_case_name + ".tsx")

  try:
    with open(component_name, "w") as file:
        file.write(
            """// components/{}.tsx

export default function {}() {{
  return (
    <div>Hello, {}!</div>
  )
}}
    """.format(
        path.parent / pascal_case_name,
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
          pascal_case_name
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



" ====
" Creates a page in NextJS from Vim.
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
    os.makedirs(parent)
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


" Function to search upwards line by line for a pattern
"
function! SearchUpwards(pattern)
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
            echo "Pattern found at line " . l:line_num
            return
        endif

        " Move to the previous line
        let l:line_num -= 1
    endwhile

    " If pattern is not found, move back to the original position
    call setpos('.', l:original_pos)
    echo "Pattern not found"
endfunction

" Map the function to a command for easier usage
command! -nargs=1 SearchUp call SearchUpwards(<q-args>)
