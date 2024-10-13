# handlers.py

import os
import re
from pathlib import Path


# Read an environmental variables
def read_env_var(name: str) -> Path:
    env_var = os.getenv(name)

    if env_var is None:
        raise OSError(
            f"Failed to read {env_var} env var."
        )

    return Path(env_var)


def set_root_directory():
    """Try to set the env var PROJECT_ROOT"""

    home_path = read_env_var("HOME")
    current_path = read_env_var("PWD")

    while current_path != home_path:
        for entry in current_path.iterdir():
            if entry.name == "package.json":
                os.environ["PROJECT_ROOT"] = str(
                    entry.parent
                )
                return

        current_path = current_path.parent

    raise OSError(
        "Failed to set PROJECT_ROOT, it seems a JSON file was not found."
    )


# Basic class for path manipulation
class PathHandler:

    def __init__(self, path: Path):
        self.path = path

    def as_str(self) -> str:
        return str(self.path)

    def join_path(self, path: str) -> Path:
        return self.path.joinpath(path)


# Transformer class to handle various concepts
class Transformer:

    # Given an string returns its pascal case
    def generate_pascal_case(self, string: str) -> str:
        words_in_string = (
            string.strip().lower().split("-")
        )
        case = str()
        for word in words_in_string:
            case += word.capitalize()

        return case

    # Validate if a component name is valid
    def is_valid_component(self, component: Path):
        component_as_str = str(component)
        expression = re.compile(
            r"^(?:\((?:[a-z]+(?:-[a-z]+)?)\)\/|[a-z]+(?:-[a-z]+)?\/)*[a-z]+(?:-[a-z]+)?$"
        )

        if not expression.match(component_as_str):
            raise ValueError(
                "Component name is not valid."
            )

    # Append the component's directory, ensuring each component
    # has its own parent folder and the '.tsx'
    # suffix is added to the file
    def append_directory_and_suffix(
        self, component: Path
    ) -> Path:
        stem = component.stem
        return component.joinpath(stem).with_suffix(
            ".tsx"
        )

    # Validate if a page name is valid
    def is_valid_page(self, page: Path):
        page_as_str = str(page)
        expression = re.compile(
            r"^(?:\((?:[a-z]+(-[a-z]+)?)\)\/|[a-z]+(-[a-z]+)?\/)*([a-z]+(-[a-z]+)?)$"
        )

        if not expression.match(page_as_str):
            raise ValueError(
                "Page with name {} is not valid.".format(
                    page_as_str
                )
            )

    def substract_group_in_page(
        self, page: Path
    ) -> Path:
        page_as_str = str(page)
        clean_path = re.sub(
            r"\/\(.*\)", r"", page_as_str
        )
        return Path(clean_path)
