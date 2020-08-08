# Set the default app to open various text files in macOS
# Usage: ./defaultapps <appname>
# Note: <appname> is optional (defaults to 'Visual Studio Code')
# Requirements: duti (brew install duti)

DEFAULT_APP='Visual Studio Code'

PUBLIC_IDENTIFIERS='plain-text bash-script c-header c-plus-plus-header c-plus-plus-source c-source comma-separated-values-text assembly-source csh-script css json ksh-script log make-source objective-c-plus-plus-source objective-c-source pascal-source patch-file perl-script php-script python-script ruby-script script shell-script source-code swift-source tcsh-script utf16-plain-text utf8-plain-text xhtml xml yacc-source zsh-script'

COM_IDENTIFIERS='microsoft.c-sharp netscape.javascript-source sun.java-source'

OTHER_IDENTIFIERS='org.fsharp.f-sharp'

if [ $# -ne 0 ]; then
	DEFAULT_APP=$1
fi

APP_IDENTIFIER=$(/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' "/Applications/${DEFAULT_APP}.app/Contents/Info.plist")

for TYPE_IDENTIFIER in $PUBLIC_IDENTIFIERS; do
	duti -s $APP_IDENTIFIER "public.$TYPE_IDENTIFIER" all
done

for TYPE_IDENTIFIER in $COM_IDENTIFIERS; do
	duti -s $APP_IDENTIFIER "com.$TYPE_IDENTIFIER" all
done

for TYPE_IDENTIFIER in $OTHER_IDENTIFIERS; do
	duti -s $APP_IDENTIFIER "$TYPE_IDENTIFIER" all
done