# Install software (on macOS)

# Install Xcode Command Line Tools
if ! [[ $(xcode-select -p 1>/dev/null;echo $?) == '0' ]]; then
	xcode-select --install
fi

# Install Homebrew (https://brew.sh/index.html)
if ! [ -x "$(command -v brew)" ]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install duti (https://github.com/moretension/duti)
if ! [ -x "$(command -v duti)" ]; then
	brew install duti
fi

# Install git if not installed
if ! [ -x "$(command -v git)" ]; then
	brew install git
# Install latest git if Apple git installed
elif git --version 2>&1 | grep -q '(Apple'; then
	brew install git
fi

# Install git lfs (Git Large File Storage)
if ! ( git lfs &>/dev/null ); then
	brew install git-lfs
fi

# Install Python 3
if ! ( python -V 2>&1 | grep -q '^Python 3\.' || python3 -V 2>&1 | grep -q '^Python 3\.' ); then
	brew install python
fi