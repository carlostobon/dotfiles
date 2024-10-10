# handlers.py

import os
import re
from pathlib import Path


# Read an environmental variables
def read_env_var(env_var) -> str:
    var = os.getenv(env_var)
    if not var:
        raise ValueError(
            "Failed to read {} environment var.".format(
                var
            )
        )
    return var


def validate_git_exists(root: str):
    git_path = Path(root).joinpath(".git")

    if not git_path.exists():
        raise OSError("Git folder not found.")


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
