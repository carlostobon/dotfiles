from pathlib import Path
import os


def create_file(path: Path):
    try:
        path.parent.mkdir(parents=True, exist_ok=True)
    except Exception:
        raise OSError(f"Error while making {path.name} parent directories.")

    try:
        path.touch()
    except Exception:
        raise OSError(f"Error while creating file {path.name}.")


def create_folder(path: Path):
    try:
        path.mkdir(parents=True, exist_ok=True)
    except Exception:
        raise OSError(f"Error creating directory {path.name}.")


# Function should be improved by adding an extra
# layer of security to verify the entry name is
# valid as os name. Could be a regular expression.
def entry_creator(entry_name: str):
    entry = Path(entry_name)
    root = os.getenv("ROOT")

    if root is None:
        raise ValueError("ROOT environment var not found.")

    root_directory = Path(root)
    if not root_directory.joinpath(".git").is_dir():
        raise ValueError("Git folder not found.")

    whole_path = root_directory.joinpath(entry)

    if whole_path.suffix == str():
        create_folder(whole_path)
    else:
        create_file(whole_path)

    print(f"Entry {entry_name} created.")
