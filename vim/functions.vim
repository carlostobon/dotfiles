
" Creates a component in NextJS.
"
function! CreateReactComp(name)
  python3 << EOF

import os
import vim
from pathlib import Path

def create_react_component(name):

  # Gets envionment var FOLDER
  project_dir = os.getenv("FOLDER")

  if not project_dir:
    print("Environment var FOLDER not found.")
    return

  name = name.strip()
  names = name.strip().lower().split('-')

  pascal_case_name = ""
  for word in names:
    pascal_case_name += word.capitalize()


  components = Path(project_dir) / "app" / "components"
  component_dir = components / name

  try:
    os.makedirs(component_dir)
  except OSError as e:
    print(f"Error creating directory '{component_dir}': {e}")
    return


  component_name = component_dir / str(pascal_case_name + ".tsx")

  try:
    with open(component_name, "w") as file:
        file.write(
            """// {}.tsx

export default function {}() {{
  return (
    <div>Hello, {}!</div>
  )
}}
    """.format(pascal_case_name, pascal_case_name, pascal_case_name))

  except Exception as error:
    print(f"Error while writting component: {error}")
    return

  # This section adds component to index.ts
  #
  statement = (
      'export {{ default as {} }} from "./{}/{}"\n'.format(
          pascal_case_name,
          name,
          pascal_case_name
      )
  )

  try:
    with open(components / "index.ts", "r") as file:
      content = file.read()
    with open(components / "index.ts", "w") as file:
      file.write(content + statement)

  except FileNotFoundError:
    with open(components / "index.ts", "w") as file:
      file.write(statement)


  print("Component {} created.".format(pascal_case_name))

create_react_component(vim.eval('a:name'))

EOF
endfunction


command! -nargs=1 ReactComp call CreateReactComp(<f-args>)
