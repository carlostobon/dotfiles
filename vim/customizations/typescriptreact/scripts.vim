" ***********************************************
" *         TYPESCRIPTREACT SCRIPTS             *
" ***********************************************


" *** CreateReactComponent ***
" Creates a component in NextJS or RemixJS
function! CreateReactComp(...)
  python3 << EOF

import os
import sys
import vim
from pathlib import Path

sys.path.append(os.getenv("HOME") + '/.vim/modules')
from frontend import find_framework

# This function serves as a checkpoint to verify
# that the new component's name does not conflict
# with any existing component names.
def check_component_conflict(
    components_path: Path, framework: str, component: Path
) -> bool:
    if not components_path.exists():
        return False

    # Collects all files in folder components_path
    files = [file for file in components_path.rglob("*") if file.is_file()]

    for file in files:
        # Compare if both components have the same name
        if file.stem == component.stem:
            print(
                "<- {} -> 🧨 Component {} conflicts with {}.".format(
                    # *file.parts[-2:] returns the last two segments
                    framework,
                    str(component),
                    str(Path(*file.parts[-3:])),
                )
            )

            return True

    return False



def create_react_component(component: str):
  # Makes component a path object
  component = Path(component)

  # Project root, comes from a script in aliasrc
  root = os.getenv("ROOT")

  if not root:
    print("Project root not found!", file=sys.stderr)
    return
  else:
      root = Path(root)

  # Adds the specified name as a folder to contain the component.
  # For example, if the component is "foo/bar", it will
  # create the directory structure "foo/bar/bar".
  component = component.joinpath(component.name + ".tsx")

  # Creates a convenient pascal case name
  names = component.stem.lower().strip().split('-')
  pascal_case_name = ""
  for word in names:
    pascal_case_name += word.capitalize()


  # Returns the components folder path and identifies the framework.
  components_folder_path, _, framework = find_framework(root)

  # Checks if component's name conflicts with any existent component.
  if check_component_conflict(components_folder_path, framework, component):
    return

  # $ROOT/components_folder_path/component
  component_whole_path = components_folder_path.joinpath(component)

  # Creates parent directory
  component_whole_path.parent.mkdir(parents=True)

  try:
    with open(component_whole_path, "w") as file:
        file.write(
            """// components/{}

interface {}Props {{}}

export default function {}({{ }}: {}Props) {{
  return (
    <div>Hello, {}!</div>
  )
}}
    """.format(
        component,
        pascal_case_name,
        pascal_case_name,
        pascal_case_name,
        pascal_case_name
    ))


  except Exception as error:
    print(f"Error while writting component: {error}", file=sys.stderr)
    return

  # Adds component to index.ts
  statement = (
      'export {{ default as {} }} from "./{}";\n'.format(
          pascal_case_name,
          # Returns path without file extension
          component.with_suffix(''),
      )
  )

  # Creates index.ts file
  try:
    with open(components_folder_path / "index.ts", "r+") as file:
      content = file.read()
      file.write(statement)

  except FileNotFoundError:
    with open(components_folder_path / "index.ts", "w") as file:
      file.write(statement)


  print("<- {} -> 🚀 Component {} created.".format(framework, pascal_case_name))

# Creates all passed components
for component in vim.eval("a:000"):
  create_react_component(component)

EOF
endfunction
command! -nargs=* ReactComp call CreateReactComp(<f-args>)



" *** CreateReactPage ***
" Creates a page in NextJS or a route in RemixJS
function! CreateReactRoute(...)
  python3 << EOF

import os
import sys
import vim
from pathlib import Path


def create_routes_exec(route: str):
  # Gets HOME
  home = os.getenv("HOME")
  if home is None:
      print("HOME env-var is not set.")
      return

  # Makes modules available
  sys.path.append(home + '/.vim/modules')
  from frontend import create_next_page, create_remix_route, find_framework, get_root_directory


  root = get_root_directory()

  if not root:
      print("Failed to get root directory.")
      return

  try:
      # Index acquisition is guaranteed to succeed
      framework = find_framework(root)[2]
  except Exception as error:
      print(error)
      return


  if framework == "NextJS":
      try:
          create_next_page(Path(route))
      except Exception as error:
          print("<- NextJS -> : 🧨 {}".format(error))

  else:
      try:
          create_remix_route(Path(route))
      except Exception as error:
          print("<- RemixJS -> : 🧨 {}".format(error))


# Creates all passed routes
for route in vim.eval("a:000"):
  create_routes_exec(route)
EOF
endfunction
command! -nargs=* ReactRoute call CreateReactRoute(<f-args>)



" *** ReactImporter ***
" Used by Importer function
function! ReactImporter(pattern)
  " Save the original cursor position
  let l:original_pos = getpos('.')

  " Initialize the current line number to the cursor's current line
  let l:current_line = line('.')

  let l:import_statement = 'import {  } from "' . a:pattern . '";'

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

  " Removes \ in patterns
  let l:result = substitute(l:import_statement, '\', '', 'g')

  execute "normal! gg}o" . l:result . "\<Esc>F}\<left>"
  startinsert
endfunction

command! -nargs=1 ReactImporter call ReactImporter(<f-args>)



" *** Importer ***
" Helps to import from Next and Remix
function! Importer(next_import, remix_import)
  python3 << EOF

import sys
import os
import vim
from pathlib import Path

sys.path.append(os.getenv("HOME") + '/.vim/modules')
from frontend import find_framework, get_root_directory


# Collects root directory
root = get_root_directory()

if not root:
  print("Project root not found!", file=sys.stderr)
  sys.exit(1)

# Returns components and route folder path,
# and identifies the framework.
framework = find_framework(root)[2]

vim.vars['framework'] = framework

EOF

  let l:framework = g:framework

  if &filetype == 'typescriptreact'
    if l:framework == 'RemixJS'
      call ReactImporter(a:remix_import)
    else
      call ReactImporter(a:next_import)
    endif
  endif

endfunction
command! -nargs=* FrameworkImport call Importer(<f-args>)


" *** Props ***
" Adds props to react components
function Props()
  " Get the current line
  let l:current_line = line('.')

  " Loops until current line reachs zero
  while l:current_line > 0
    " Collects the line content
    let l:line_content = getline(l:current_line)

    " If line contains `functions` get into the if statement
    if l:line_content =~ "function"
      " Move the cursor to the start of the matched line
      call cursor(l:current_line, 1)
      " Gets the name of the function
      let l:function_name = matchstr(l:line_content, 'function \zs\w\+')

      " If function's name begins with uppercase it's a component.
      if match(l:function_name, '^[A-Z]') != -1
        let l:props = l:function_name . "Props"
        execute "normal! f)i{}: " . l:props
        execute "normal! Ointerface " . l:props "{}\<cr>\<up>"
        return
      endif

    endif
    " If current line does not contain the pattern, will continue
    " to next upper line
    let l:current_line -= 1
  endwhile

endfunction
command! -nargs=0 Props call Props()



" *** Create Next Layout ***
" Creates a layout in NextJS
function! CreateNextLayout(name)
  python3 << EOF

import os
import vim
from pathlib import Path

def create_react_layout(path: str):

  # Gets environment var ROOT
  project_dir = os.getenv("ROOT")

  if not project_dir:
    print("Environment var ROOT not found.")
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
command! -nargs=1 NextLayout call CreateNextLayout(<f-args>)
