DATE=$(date --iso-8601)
DATE_TIME=$(date +"%Y-%m-%d %T")
COLOR="\033[96m"
BOLD="\033[1m"
ITALICS="\033[3m"
RESET="\033[0m"
# default variables are blank
category=""
tag=""
name="post-name"
title=""

while getopts 'c:t:p:T:h' OPTION; do
	case $OPTION in
		c)
			category="$OPTARG"
			;;
		t)
			tag="$OPTARG"
			;;
		p)
			name="$OPTARG"
			;;
		T)
			title=$(echo $OPTARG | tr '_' ' ')
			;;
		h)
			printf -- "Each option requires a corresponding argument.\n"
			printf -- "$BOLD \bFlags:$RESET\n"
			printf -- "  $COLOR-c <arg>\n$RESET"
			printf -- "     sets category to $ITALICS \barg$RESET. Only supports 1 category at the moment. Should be formatted IAW\n"
			printf -- "     $BOLD \bhttps://jekyllrb.com/docs/posts/#categories$RESET\n"
			printf -- "  $COLOR-t <arg>\n$RESET"
			printf -- "     sets tag to $ITALICS \barg$RESET. Only supports 1 tag at the moment. Should be formatted IAW\n"
			printf -- "     $BOLD \bhttps://jekyllrb.com/docs/posts/#tags$RESET\n"
			printf -- "  $COLOR-p <arg>\n$RESET"
			printf -- "     sets filename title to $ITALICS \barg$RESET. Filename should be formatted IAW\n"
			printf -- "     $BOLD \bhttps://jekyllrb.com/docs/posts/#creating-posts$RESET\n"
			printf -- "  $COLOR-T <arg>$RESET\n"
			printf -- "     sets post title to $ITALICS \barg$RESET. Underscores (_) will be parsed as spaces. " 
			printf -- "There is currently no support for escaping underscores\n"
			exit 0
			;;
		?)
			printf "Use option $BOLD-h$RESET for more information\n" >&2
			exit 1
			;;
	esac
done

echo "ECHOED"
printf -- "---\ntitle: $title\ndate: $DATE_TIME -0500\ncategories: [$category]\ntags: [$tag]\nauthor: alon\nimg_path: /assets/image\n---\n"
echo "INTO $DATE-$name.md"

printf -- "---\ntitle: $title\ndate: $DATE_TIME -0500\ncategories: [$category]\ntags: [$tag]\nauthor: alon\nimg_path: /assets/image\n---\n" > $DATE-$name.md
