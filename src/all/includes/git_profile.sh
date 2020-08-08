# Functions for managing git profiles (emails for git config)

# Set or print the git-config profile
# Usage: git_profile <code> (omit code to print)
git_profile(){
	if [ $# -ne 0 ]; then
		if [ -f "$HOME/git_profile/$1.txt" ]; then
			local email="$(< $HOME/git_profile/$1.txt)"
			git config --global user.email "${email}"
			git config user.email "${email}" 2>/dev/null || echo "Only set global"
		else
			echo "$1 does not exist"
			return 1
		fi
	fi
	echo "user.name:  $(git config user.name)"
	echo "user.email: $(git config user.email)"
}

# Print all git-config profiles
git_profiles(){
	for file in "$HOME/git_profile/"*.txt; do
		# If there are no matches, continue
		[ -e "$file" ] || continue
		local file_name="${file##*/}"
		local email="$(< ${file})"
		echo "${file_name%.txt} - ${email}"
	done
}

# Create a git-config profile
# Usage: add_git_profile <code> <email>
add_git_profile(){
	mkdir -p "$HOME/git_profile"
	echo "$2" > "$HOME/git_profile/$1.txt"
}

# Delete a git-config profile
# Usage: remove_git_profile <code>
remove_git_profile(){
	rm "$HOME/git_profile/$1.txt"
}