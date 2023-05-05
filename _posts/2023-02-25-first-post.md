---
title: First post on my website!
date: 2023-02-25 04:36:00 -0500
categories: []
tags: [misc]     # TAG names should always be lowercase
author: alon
math: true
img_path: /assets/image
---
# Test blog
I am writing this to check out some features.

## Markdown stuff
I already know how to use lists and stuff:
- a
- b 
- c

But how do I use MathJax?
$$(\forall f,b \in E (f \text{ is a forward edge} \land b \text{ is a backward edge} \land f \text{ contains a residual capacity } \land b \text{ is non-empty})$$

## Code
Since I am a CS major, I need to be able to put in snippets both `inline` and as a block quote. Look at this C!
```c
#include <stdio.h>
#include "linked-list.h"

int main(int argc, char** argv) {
	List* ll = new_LL_blank_head();
	for(int i=1; i<argc; ++i) insert(ll, argv[i]);
	printf(LL_to_string(ll));
	return 0;
}
```
