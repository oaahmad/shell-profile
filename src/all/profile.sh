# The main profile settings

PROMPT_COLOR='074'
ALT_PROMPT_COLOR='093'
ERROR_PROMPT_COLOR='124'
END_PROMPT_COLOR='\[\e[m\]'

# Return the prompt color in a way that allows changing it by dynamically setting PROMPT_COLOR
_prompt_color(){
	echo -e "\e[38;5;${PROMPT_COLOR}m"
}
# Return the alternate prompt color in a way that allows changing it by dynamically setting ALT_PROMPT_COLOR
_alt_prompt_color(){
	echo -e "\e[38;5;${ALT_PROMPT_COLOR}m"
}
# Return the main prompt color if the exit code of the last command was 0 (success), otherwise, return the error prompt color
_main_prompt_color(){
	if [ $? -ne 0 ]; then
		echo -e "\e[38;5;${ERROR_PROMPT_COLOR}m"
	else
		echo -e "\e[38;5;${PROMPT_COLOR}m"
	fi
}
# Return the name of the current git branch, if any
_git_prompt(){
	local branch=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
	if [ -z "${branch}" ]; then
		echo ''
	else
		echo " ${branch}"
	fi
}
# If the current session is an SSH session, return a cloud character, otherwise, return an empty string
_ssh_prompt(){
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ]; then
		echo ' ☁'
	else
		echo ''
	fi
}

PROMPTS[-]=' '
PROMPTS[main]="\[\$(_main_prompt_color)\]▶${END_PROMPT_COLOR}"
PROMPTS[end]="\[\$(_prompt_color)\]>${END_PROMPT_COLOR}"
PROMPTS[host]="\[\$(_prompt_color)\]\H${END_PROMPT_COLOR}"
PROMPTS[folder]="\[\$(_prompt_color)\]\W${END_PROMPT_COLOR}"
PROMPTS[hostfolder]="\H \[\$(_prompt_color)\]\W${END_PROMPT_COLOR}"
PROMPTS[path]="\[\$(_prompt_color)\]\w${END_PROMPT_COLOR}"
PROMPTS[hostpath]="\H \[\$(_prompt_color)\]\w${END_PROMPT_COLOR}"
PROMPTS[ssh]="\$(_ssh_prompt)"
PROMPTS[git]="\[\$(_alt_prompt_color)\]\$(_git_prompt)${END_PROMPT_COLOR}"

TITLES[-]=' '
TITLES[sep]='    |    '
TITLES[host]="\H"
TITLES[folder]="\W"
TITLES[path]="\w"
TITLES[git]="\$(_git_prompt)"

DEFAULT_PROMPT='main ssh - folder'
DEFAULT_TITLE='path'
prompt && title

if [ -x "$(command -v code)" ]; then
	export EDITOR=code
	if [ -x "$(command -v git)" ]; then
		git config --global core.editor 'code --wait'
		git config --global diff.tool code
		git config --global difftool.code.cmd 'code --wait --diff "$LOCAL" "$REMOTE"'
		git config --global merge.tool code
		git config --global mergetool.code.cmd 'code --wait "$MERGED"'
	fi
elif [ -x "$(command -v nano)" ]; then
	export EDITOR=nano
fi
export VISUAL=$EDITOR