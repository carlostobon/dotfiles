from typing import List
from pathlib import Path
from utils import (
    Transformer,
    read_env_var,
    validate_git_exists,
)


# Retrieve all existing components from the components path.
def get_components_list(
    components_path: Path,
) -> List[Path]:

    current_components = [
        component.relative_to(components_path)
        for component in components_path.rglob("*.tsx")
    ]

    return current_components


# Check if the component conflicts with any other in the component list.
def check_component_conflicts(
    components_list: List[Path], component: Path
):

    for component_item in components_list:
        if component_item.stem == component.stem:
            raise ValueError(
                "Component {} conflicts with {}.".format(
                    component, component_item
                )
            )


# Create the parent directories and the component file
def create_parent_directories_and_component(
    component_path: Path, pascal_case: str
):
    try:
        component_path.parent.mkdir(
            parents=True, exist_ok=True
        )
    except Exception:
        raise OSError(
            "Failed to create parent directories for {}.".format(
                component_path.name
            )
        )

    try:
        component_path.write_text(
            """// components/{}/{}

interface {}Props {{}}

export default function {}({{}}: {}Props) {{
  return <div>Hello, {}!</div>;
}}
""".format(
                component_path.stem,
                component_path.name,
                pascal_case,
                pascal_case,
                pascal_case,
                pascal_case,
            )
        )

    except Exception:
        raise OSError(
            "Failed to write component {}.".format(
                component_path.name
            )
        )


# Automatically append the component to the 'index.tsx'
# file for export management
def append_component_to_index_file(
    components_path: Path,
    component_path: Path,
    pascal_case: str,
):

    statement = 'export {{ default as {} }} from "./{}";\n'.format(
        pascal_case, component_path.with_suffix("")
    )

    index_path = components_path.joinpath("index.ts")
    try:
        with open(index_path, "a") as file:
            file.write(statement)
    except Exception:
        raise ValueError(
            "Failed to write {} in index.ts".format(
                component_path
            )
        )


def create_component(path: str):
    component = Path(path)
    transformer = Transformer()

    # Verifies that the component has a valid name
    transformer.is_valid_component(component)

    # Accesses the ROOT environment variable
    root_path = read_env_var("ROOT")

    # Verifies if a Git repository has been initialized
    validate_git_exists(root_path)

    components_path = Path(root_path).joinpath(
        "components"
    )

    # Retrieve a list of all components in components_path,
    # excluding the components_path prefix
    current_components = get_components_list(
        components_path
    )

    # Verify if the component conflicts with any existing components.
    check_component_conflicts(
        current_components, component
    )

    # Append the component directory and suffix
    # Example: corge/grault -> corge/grault/grault.tsx
    component_path = (
        transformer.append_directory_and_suffix(
            component
        )
    )

    # Completed path of component to be created.
    component_path_completed = (
        components_path.joinpath(component_path)
    )

    # Generates pascal case name for the component
    pascal_case = transformer.generate_pascal_case(
        component.name
    )

    # Create parent directory and write the component.
    create_parent_directories_and_component(
        component_path_completed, pascal_case
    )

    # Appends the component to index.ts
    append_component_to_index_file(
        components_path, component_path, pascal_case
    )

    # Print the component if the operation was successful
    print(
        "<- NextJS -> 🚀 Component {} created.".format(
            pascal_case
        )
    )
