#!/usr/bin/env bash

# Install shell_profile
# Usage: install <path>
# Note: <path> is optional (defaults to $HOME)

SHELL_PROFILE_DIR="$HOME"
BASH_PROFILE_PATH="$HOME/.bash_profile"

# If an argument is given, use that as the target directory
if [ $# -ne 0 ]; then
	SHELL_PROFILE_DIR="$1"
fi

SHELL_PROFILE_PATH="$SHELL_PROFILE_DIR/shell-profile"

# If the folder containing this install script is not the target path, copy this folder to the target path
if ! [[ ./shell-profile -ef "$SHELL_PROFILE_PATH" ]]; then
	rm -rf "$SHELL_PROFILE_PATH"
	mkdir -p "$SHELL_PROFILE_PATH"
	cp -r ../shell-profile "$SHELL_PROFILE_DIR"
fi

_LINE1="SHELL_PROFILE_PATH=\"$SHELL_PROFILE_PATH\""
_LINE2='source "$SHELL_PROFILE_PATH/src/main_profile.sh"'

# If the above lines do not already exist in the bash profile, add them
if ! ( grep -Fxq "$_LINE1" "$BASH_PROFILE_PATH" && grep -Fxq "$_LINE2" "$BASH_PROFILE_PATH" ); then
	echo '' >> "$BASH_PROFILE_PATH"
	echo "$_LINE1" >> "$BASH_PROFILE_PATH"
	echo "$_LINE2" >> "$BASH_PROFILE_PATH"
fi