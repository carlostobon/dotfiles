# page.py
from utils import (
    Transformer,
    read_env_var,
    set_root_directory,
)
from pathlib import Path
from typing import List


# Retrieve all existing pages from the pages path.
def get_pages_list(
    pages_path: Path,
) -> List[Path]:
    current_pages = [
        x.relative_to(pages_path)
        for x in pages_path.rglob("page.tsx")
        if x.is_file()
    ]
    return current_pages


# Check if the page conflicts with any other in the page list.
def check_page_conflicts(page: Path, pages_path: Path):
    transformer = Transformer()
    clean_page = transformer.substract_group_in_page(
        page
    )
    current_pages = get_pages_list(pages_path)

    for x in current_pages:
        x = transformer.substract_group_in_page(x)
        if x.parent == clean_page:
            raise ValueError(
                "Page {} conflicts with {}.".format(
                    page, x.parent
                )
            )


def create_parent_directories(
    page: Path, pages_path: Path
):
    page_path = pages_path.joinpath(page)

    try:
        page_path.mkdir(parents=True, exist_ok=True)
    except Exception:
        raise OSError(
            "Failed to create parent directories for {}.".format(
                page.name
            )
        )


def write_page(page: Path, pages_path: Path):
    page_name = page.name
    pascal_case = Transformer().generate_pascal_case(
        page_name
    )

    page_path = pages_path.joinpath(page).joinpath(
        "page.tsx"
    )

    try:
        page_path.write_text(
            """// {}/page.tsx

export default function {}() {{
  return <div>Hello, {}!</div>;
}}
            """.format(
                page,
                pascal_case,
                pascal_case,
            )
        )

    except OSError:
        raise OSError(
            "Failed to write page {}.".format(
                str(page)
            )
        )


def create_page(page_str: str):
    page = Path(page_str)
    transformer = Transformer()

    # Verifies that the page has a valid name
    transformer.is_valid_page(page)

    # Try to set PROJECT_ROOT env-var, otherwise
    # it will panic.
    set_root_directory()

    # Accesses the PROJECT_ROOT environment variable
    root_path = read_env_var("PROJECT_ROOT")

    pages_path = root_path.joinpath("app")

    check_page_conflicts(page, pages_path)

    create_parent_directories(page, pages_path)

    write_page(page, pages_path)

    print(
        "<- NextJS -> : 📜 Page {} created.".format(
            str(page)
        )
    )
