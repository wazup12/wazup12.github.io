---
title: "Making Scripts: QOL Improvements Waste of Time?"
date: 2023-03-11 01:21:35 -0500
categories: [Scripting]
tags: [bash]
author: alon
img_path: /assets/image
---
[![Why solve a problem when you can automate a solution?](https://imgs.xkcd.com/comics/automation.png){: .left }](https://xkcd.com/1319/)
# How it started
The software I am using to generate this site, [Jekyll](https://jekyllrb.com/), has a specific way of formatting post names and frontmatter. 
Posts follow the following convention: `date-title.md` (where the date is in ISO-8601 calendar date format).
After finding out there was a `date` utility that had the `--iso-8601` option, everything seemed perfect.
I could now just pass in an argument to set the post title! 
# Mission creep
Now I had a different problem.
It was easy enough to generate the name of the file, but that task only takes a couple seconds.
The annoying part about creating posts wasn't the title, but it was the front matter. 
After all, aside from a few changes, mostly everything should be the same.
My next feature was to support not just creating a file, but writing some basic front matter like the following:
```md
---
title: "lipsum"
date: 2000-00-00 00:00:00 -0500
categories: [lipsum]
tags: [lipsum]
author: alon
---
```
To make it more dynamic, I just called date again (but now with a different formatter to include time. 
Now I would not have to manually write in the date or the front matter, I would just have to change the categories, tags, and post title (since the file title is not going to be the same).
But... now that I did that, how hard would it be to just automatically change those via more command line arguments?
# Mission creep (part 2)
Some of the parameters I mentioned above were optional, so I wanted to have the script be able to discriminate between values (i.e., parse command line options).
I stumbled upon the `getopts` utility which does the hard work of parsing and gives the options of forcing inputs for certain options with `:`.
Now I can just set default values, check for the arguments `{-c, -t, -T, -p}`, and replace them if needed.
I also added the option of encoding a string with underscores where spaces are meant to be to avoid over-tokenization (although there are other ways of escaping for whitespace).
But... how will I remember what each option means?
# Mission creep (part 3)
Adding a help option was fairly trivial, but the text looked boring so I wanted to work on the formatting.
The [ECMA-48](https://www.ecma-international.org/wp-content/uploads/ECMA-48_5th_edition_june_1991.pdf) standard defines ANSI SGR parameters for formatting text in a console.
The escape character `\033` specifies the ANSI escape character, and the start and end symbols of the SGR sequence are `[` and `m` respectively.
Using `printf --` will allow me to show the command line arguments (otherwise `printf` will try to interpret anything that looks like an argument as one.
# The script
Here is the script!
As a reminder, this started as a simple utility to create files formatted in a specific way and ballooned into a more dynamic script with various arguments.
```sh
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
author="alon"

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

printf -- "---\ntitle: $title\ndate: $DATE_TIME -0500\ncategories: [$category]\ntags: [$tag]\nauthor: $author\nimg_path: /assets/image\n---\n" > $DATE-$name.md
```
{: file="makepost.sh" }
