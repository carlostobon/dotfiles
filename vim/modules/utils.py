# utils.py

from pathlib import Path
from typing import Optional, List
import re


class PathHandler:
    """
    Handles path conversion to PascalCase.

    Attributes:
        path (Path): The file or directory path.

    Methods:
        pascal_case() -> str:
            Converts the path stem to PascalCase.
    """

    def __init__(self, path: Path):
        self.path = path

    def pascal_case(self, string: Optional[str] = None) -> str:
        """
        Converts the path stem to PascalCase. If a
        name is provided, it converts that string
        to PascalCase instead.

        Returns:
            str: PascalCase version of the path stem or
            given string
        """

        if not string:
            names = self.path.stem.strip().lower().split("-")
        else:
            names = string.strip().lower().split("-")

        pascal_case = str()
        for word in names:
            pascal_case += word.capitalize()

        return pascal_case

    def remix_find_name(self) -> str:
        """
        Gets the name of the page to be created
        in RemixJS.

        Example:
            input: _foo.bar.baz.tsx
            output: baz
        """
        return self.path.name.replace("$", "").replace(":", "").split(".")[-2]

    #

    def remix_route_collision(self, target: Path, paths: List[Path]):
        """
        Checks if the target route conflicts with any route in the given list.

        The function compares the target route with each route in `paths` after removing
        specific patterns. Raises a ValueError if a conflict is detected.

        Args:
            target (Path): The route to check.
            paths (List[Path]): List of existing routes to compare with.
        """

        # Pattern to remove layout-specific elements from routes.
        # Used to standardize route comparison in Remix.
        pattern = re.compile(r"_[^.]*\.")

        # Extract pattern from target
        clean_target = re.sub(pattern, "", str(target))

        if clean_target == "tsx":
            if target in paths:
                raise ValueError(f"Route {target} conflicts with {target} route.")
            else:
                return

        for path in paths:
            # Clean the path by removing the pattern
            clean_path = re.sub(pattern, "", str(path))

            # Check for conflicts between the target and cleaned path
            if clean_target == clean_path:
                raise ValueError(f"Route {target} conflicts with path {path}.")
