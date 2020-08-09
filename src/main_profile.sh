# Include all other scripts, and define basic functionality like syncing
# This should be included in your bash profile

if [[ "$_INCLUDED_SHELL_PROFILE" == 'true' ]]; then
	echo -e "\e[38;5;003mWarning:\e[m You have included shell_profile more than once. Please remove duplicate \"source\" statements from your bash profile." > /dev/stderr
fi
_INCLUDED_SHELL_PROFILE='true'

# Print help (basic usage information)
shell_profile(){
	echo '    setup_shell_profile               Run setup scripts (install software, etc.)'
	echo '    pull_shell_profile                Pull changes'
	echo '    push_shell_profile <message>      Push changes (message optional)'
	echo '    reset_shell_profile               Revert changes to shell_profile'
	echo ''
	echo '    prompt <keys>                     Set prompt (omit keys for default)'
	echo '    title <keys>                      Set title (omit keys for default)'
	echo '    echo "${!PROMPTS[@]}"             Print prompt keys'
	echo '    echo "${!TITLES[@]}"              Print title keys'
	echo ''
	echo '    add_git_profile <code> <email>    Create a git-config profile'
	echo '    remove_git_profile <code>         Delete a git-config profile'
	echo '    git_profiles                      Print all git-config profiles'
	echo '    git_profile <code>                Set git-config profile (omit code to print)'
	echo ''

	# Print script names
	for file in "$SHELL_PROFILE_PATH/src/all/scripts/"*.sh; do
		[ -e "$file" ] || continue
		first_line=$(head -n1 "$file")
		echo "    $(basename "$file" | cut -f 1 -d '.')       ${first_line:1}"
	done

	# If on macOS, print macOS specific script names
	if [[ "$OSTYPE" == darwin* ]]; then
		for file in "$SHELL_PROFILE_PATH/src/mac/scripts/"*.sh; do
			[ -e "$file" ] || continue
			first_line=$(head -n1 "$file")
			echo "    $(basename "$file" | cut -f 1 -d '.')       ${first_line:1}"
		done
	# Otherwise, print Linux-specific script names
	else
		for file in "$SHELL_PROFILE_PATH/src/linux/scripts/"*.sh; do
			[ -e "$file" ] || continue
			first_line=$(head -n1 "$file")
			echo "    $(basename "$file" | cut -f 1 -d '.')       ${first_line:1}"
		done
	fi
}

# Pull shell_profile changes from remote
pull_shell_profile(){
	git -C "$SHELL_PROFILE_PATH" pull
}

# Push shell_profile changes to remote
# Usage: push_shell_profile <message>
# Note: <message> is optional (defaults to '(Automated commit)')
push_shell_profile(){
	local message='(Automated commit)'
	if [ $# -ne 0 ]; then
		message="$1"
	fi
	git -C "$SHELL_PROFILE_PATH" add .
	git -C "$SHELL_PROFILE_PATH" commit -m "$message"
	git -C "$SHELL_PROFILE_PATH" push
}

# Revert all changes to shell_profile
reset_shell_profile(){
	git -C "$SHELL_PROFILE_PATH" reset
}

# Run setup scripts (largely for installing software)
setup_shell_profile(){
	if [ -e "$SHELL_PROFILE_PATH/src/all/setup.sh" ]; then
		"$SHELL_PROFILE_PATH/src/all/setup.sh"
	fi

	if [[ "$OSTYPE" == darwin* ]]; then
		if [ -e "$SHELL_PROFILE_PATH/src/mac/setup.sh" ]; then
			"$SHELL_PROFILE_PATH/src/mac/setup.sh"
		fi
	else
		if [ -e "$SHELL_PROFILE_PATH/src/linux/setup.sh" ]; then
			"$SHELL_PROFILE_PATH/src/linux/setup.sh"
		fi
	fi
}

# Include scripts in all/includes
for file in "$SHELL_PROFILE_PATH/src/all/includes/"*.sh; do
	# If there are no matches, continue
	[ -e "$file" ] || continue
	source "$file"
done

# Make aliases for scripts in all/scripts
for file in "$SHELL_PROFILE_PATH/src/all/scripts/"*.sh; do
	[ -e "$file" ] || continue
	alias $(basename "$file" | cut -f 1 -d '.')="$file"
done

# Include all/profile.sh
source "$SHELL_PROFILE_PATH/src/all/profile.sh"

# If on macOS, include macOS specific files
if [[ "$OSTYPE" == darwin* ]]; then
	for file in "$SHELL_PROFILE_PATH/src/mac/includes/"*.sh; do
		[ -e "$file" ] || continue
		source "$file"
	done

	for file in "$SHELL_PROFILE_PATH/src/mac/scripts/"*.sh; do
		[ -e "$file" ] || continue
		alias $(basename "$file" | cut -f 1 -d '.')="$file"
	done

	source "$SHELL_PROFILE_PATH/src/mac/profile.sh"
# Otherwise, include Linux-specific files
else
	for file in "$SHELL_PROFILE_PATH/src/linux/includes/*.sh"; do
		[ -e "$file" ] || continue
		source "$file"
	done

	for file in "$SHELL_PROFILE_PATH/src/linux/scripts/"*.sh; do
		[ -e "$file" ] || continue
		alias $(basename "$file" | cut -f 1 -d '.')="$file"
	done

	source "$SHELL_PROFILE_PATH/src/linux/profile.sh"
fi