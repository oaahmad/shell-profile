# Install software (on Linux)

apt update

# Install git
if ! [ -x "$(command -v git)" ]; then
	apt install git
fi

# Install git lfs (Git Large File Storage)
if ! ( git lfs &>/dev/null ); then
	apt install git-lfs
fi

# Install Python 3
if ! ( python -V 2>&1 | grep -q '^Python 3\.' || python3 -V 2>&1 | grep -q '^Python 3\.' ); then
	apt install python3
fi