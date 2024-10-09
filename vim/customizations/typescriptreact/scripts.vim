" ***********************************************
" *         TYPESCRIPTREACT SCRIPTS             *
" ***********************************************

" -----------------------------------------------
function ImportPythonModules(module)
  let l:module_name = a:module
  python3 << EOF
import os
import sys
import vim

module_name = vim.eval('l:module_name')
module_path = os.getenv("HOME") + '/' + module_name
sys.path.append(module_path)
EOF
endfunction


" -----------------------------------------------
function! CreateReactComponent(...)
  call ImportPythonModules(".vim/modules/next")
  python3 << EOF
from component import create_component

for component in vim.eval("a:000"):
  try:
      create_component(component)
  except Exception as e:
      print(" 🧨 {}".format(e))
EOF
endfunction
autocmd FileType typescriptreact command! -nargs=* ReactComp call CreateReactComponent(<f-args>)



" -----------------------------------------------
function! CreateReactRoute(...)
  call ImportPythonModules(".vim/modules/next")
  python3 << EOF
from page import create_page

for page in vim.eval("a:000"):
  try:
      create_page(page)
  except Exception as e:
      print(" 🧨 {}".format(e))
EOF
endfunction
autocmd FileType typescriptreact command! -nargs=* ReactRoute call CreateReactRoute(<f-args>)


" -----------------------------------------------
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
autocmd FileType typescriptreact command! -nargs=1 ReactImporter call ReactImporter(<f-args>)


" -----------------------------------------------
function AddProps()
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
autocmd FileType typescriptreact command! -nargs=0 Props call AddProps()
