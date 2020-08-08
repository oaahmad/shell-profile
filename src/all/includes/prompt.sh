# Utility functions for setting the shell prompt and title (requires PROMPTS and TITLES associative arrays - see functions for details)

_CURRENT_PROMPT=''
_CURRENT_TITLE=''
declare -A PROMPTS
declare -A TITLES

# Set the shell prompt (requires PROMPTS to have keys/values)
# Usage: prompt <key1> <key2>...<keyn>
prompt(){
	local choice="$DEFAULT_PROMPT"
	if [ $# -ne 0 ]; then
		choice="$@"
	fi
	combined=''
	for segment in $choice; do
		combined="${combined}${PROMPTS[$segment]}"
	done
	_CURRENT_PROMPT="$combined"
	PS1="${_CURRENT_PROMPT} \[\e]2;${_CURRENT_TITLE}\a\]"
}

# Set the shell title (requires TITLES to have keys/values)
# Usage: title <key1> <key2>...<keyn>
title(){
	local choice="$DEFAULT_TITLE"
	if [ $# -ne 0 ]; then
		choice="$@"
	fi
	combined=''
	for segment in $choice; do
		combined="${combined}${TITLES[$segment]}"
	done
	_CURRENT_TITLE="$combined"
	PS1="${_CURRENT_PROMPT} \[\e]2;${_CURRENT_TITLE}\a\]"
}