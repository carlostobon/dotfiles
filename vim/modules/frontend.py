# frontend.py

import os
from pathlib import Path
from typing import Tuple, Optional
from utils import PathHandler


def get_root_directory() -> Optional[Path]:
    """
    Returns the project root directory from the 'ROOT'
    environment variable as a Path object. If 'ROOT' is
    not set, returns None.
    """

    # Project root, comes from a script in aliasrc
    root = os.getenv("ROOT")

    return Path(root) if root else None


def find_framework(root: Path) -> Tuple[Path, Path, str]:
    """
    Try to access pacakge.json to determine it's
    Remix or NextJS project otherwise it will panic.

    Args:
        root (Path): The root directory of the project

    Returns:
        Tuple[Path, Path, str]: First element components path,
        second one is the root point for routes, and last one
        is the framework's name.
    """

    try:
        with open(root.joinpath("package.json"), "r") as file:
            content = file.read()
    except OSError:
        raise OSError("Failed to read package.json")

    if "remix-run" in content:
        components_folder = root.joinpath("app/components")
        routes_folder = root.joinpath("app/routes")
        framework = "RemixJS"
    else:
        components_folder = root.joinpath("components")
        routes_folder = root.joinpath("app")
        framework = "NextJS"

    # Returns the path for components and the framework's name.
    return components_folder, routes_folder, framework


def create_next_page(page: Path):
    """
    Create a Next.js page scaffold.

    Args:
        page (Path): Folder path where the page
        file should be created. E.g., 'foo/bar'.

    Example:
        create_next_page(Path('foo/bar')) creates
        'foo/bar/page.tsx'.
    """

    root = get_root_directory()
    if not root:
        raise ValueError("Failed to get root directory.")

    pascal_case = PathHandler(page).pascal_case()

    routes_folder = find_framework(root)[1]

    page_path = routes_folder / page

    target = page_path / "page.tsx"
    if target.exists():
        raise FileExistsError("Route {} already exists.".format(page))

    # First try to create the required folders.
    try:
        os.makedirs(page_path, exist_ok=True)

    except OSError:
        raise OSError("Failed to create parent directories.")

    # Once folders are created, attempt to write the scaffold
    # into page.tsx.
    try:
        with open(target, "w") as file:
            file.write(
                """// {}/page.tsx

export default function {}() {{
  return (
    <div>Hello, {}!</div>
  )
}}
            """.format(
                    page, pascal_case, pascal_case
                )
            )
    except OSError:
        raise OSError("Failed to write page {}".format(page.name))

    print("<- NextJS -> : 📜 Page {} created.".format(page))


def create_remix_route(route: Path):
    """
    Create a Remix.js route scaffold.

    Args:
        route (Path): route to be createad.
    """
    root = get_root_directory()
    if not root:
        raise ValueError("Failed to get root directory.")

    _, routes_path, _ = find_framework(root)

    # Adds .tsx exetension to route
    route = Path(f"{route}.tsx")

    # The `route` parameter is not used by the handler itself,
    # but it is necessary for creating the handler.
    handler = PathHandler(route)
    route_name = handler.remix_find_name()
    pascal_case = handler.pascal_case(route_name)

    # List all .tsx files in the routes_path directory.
    tsx_files = [
        # relative_to extracts routes path from file path.
        file.relative_to(routes_path)
        for file in routes_path.rglob("*.tsx")  # Filter for .tsx files only
        if file.is_file()  # Ensure the path is a file
    ]

    # Ensures the route doesn't conflict with an existing one.
    handler.remix_route_collision(route, tsx_files)

    try:
        with open(routes_path / route, "w") as file:
            file.write(
                """// {}

export default function {}() {{
  return (
    <div>Hello, {}!</div>
  )
}}
            """.format(
                    route, pascal_case, pascal_case
                )
            )
    except OSError as e:
        raise OSError("Error when writting route {} : {}".format(route.name, e))

    print("<- RemixJS -> : 📜 Route {} created.".format(route))
