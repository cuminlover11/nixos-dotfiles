#!/usr/bin/env python3
import argparse
import os
import subprocess
import sys

parser = argparse.ArgumentParser(description="Rebuild NixOS and push config to git.")
parser.add_argument("--no-push", action="store_true",
                     help="Rebuild and commit locally, but skip git push")
args = parser.parse_args()


REPO_DIR = os.path.expanduser("~/dotfiles/nixos")
SEP = "=" * 100

def main(): 
    print("Attempting to rebuild NixOs..")
    
    print(SEP)
    result = subprocess.run(
	    ["sudo", "nixos-rebuild", "switch", "--flake", ".#tunix"],
	    cwd=REPO_DIR
    )
    
    if result.returncode != 0: 
        print(SEP)
        print("✗ Rebuild FAILED :(\nNot pushing anything.")
        sys.exit(1)

    print(SEP)
    print("✓ Rebuild succeeded.")
    
    msg = input("Commit message. What did you do? ").strip()
    while not msg:
        msg = input("Commit message cannot be empty. Try again: ").strip()
    
    print(SEP)
    subprocess.run(["git", "add", "-A"], cwd=REPO_DIR)
    subprocess.run(["git", "commit", "-m", msg], cwd=REPO_DIR)
    
    if not args.no_push:
        push_result = subprocess.run(["git", "push"], cwd=REPO_DIR)
        print(SEP)
        if push_result.returncode == 0:
            print(f"✓ Pushed: \"{msg}\"")
        else:
            print("✗ Push failed — check git output above.")
    else:
        print(SEP)
        print(f"✓ Committed locally: \"{msg}\" (push skipped)")


if __name__ == "__main__":
    main()

