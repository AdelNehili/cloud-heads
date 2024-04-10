import os

def print_dir_tree(startpath):
    print(f"Starting directory tree print for: {startpath}")
    for root, dirs, files in os.walk(startpath, topdown=True):
        dirs[:] = [d for d in dirs if d != '.git']  # Skip .git directories
        level = root.replace(startpath, '').count(os.sep)
        indent = ' ' * 4 * (level)
        print(f"{indent}{os.path.basename(root)}/")
        subindent = ' ' * 4 * (level + 1)
        for f in files:
            print(f"{subindent}{f}")

print_dir_tree('flask_project/src')

