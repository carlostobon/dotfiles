from pathlib import Path
import os


# Set the type of comment required depending
# on the file suffix
def set_comment_type(path: Path) -> str:
    match path.suffix:
        case ".py" | ".sh":
            return "#"

    return "//"


def create_file(path: Path, entry_name: str):
    try:
        path.parent.mkdir(parents=True, exist_ok=True)
    except Exception:
        raise OSError(f"Error while making {path.name} parent directories.")

    comment_type = set_comment_type(path)
    try:
        path.write_text(f"{comment_type} {entry_name}")
    except Exception:
        raise OSError(f"Error while creating file {path.name}.")


def create_folder(path: Path):
    try:
        path.mkdir(parents=True, exist_ok=True)
    except Exception:
        raise OSError(f"Error creating directory {path.name}.")


def read_env_var(name: str) -> Path:
    env_var = os.getenv(name)

    if env_var is None:
        raise OSError(f"Failed to read {env_var} env var.")

    return Path(env_var)


def set_root_directory():
    """Try to set the env var PROJECT_ROOT"""

    home_path = read_env_var("HOME")
    current_path = read_env_var("PWD")
    possible_targets = [".git", "Cargo.toml", "package.json", "main.py"]

    while current_path != home_path:
        for entry in current_path.iterdir():
            # In case any of the targets exist in given folder
            # set that same folder as PROJECT_ROOT
            if entry.name in possible_targets:
                os.environ["PROJECT_ROOT"] = str(entry.parent)
                return

        current_path = current_path.parent

    raise OSError("None of the target entries was found.")


# Function should be improved by adding an extra
# layer of security to verify the entry name is
# valid as os name. Could be a regular expression.
def entry_creator(entry_name: str):
    entry = Path(entry_name)

    try:
        set_root_directory()
        root_directory = read_env_var("PROJECT_ROOT")
    except OSError:
        # As a last resort, the PWD environment variable
        # will be used. If it's not found, the application
        # will terminate with an error.
        root_directory = read_env_var("PWD")

    full_path = root_directory.joinpath(entry)

    if full_path.suffix == str():
        create_folder(full_path)
    else:
        create_file(full_path, entry_name)

    print(f"Entry {entry_name} created.")
