#include <stdio.h>
#include <string.h>
#define MAGIC 0xdeadbeef
#define MAGIC_2 0xcafebabe

int main(int argc, char** argv) {
	char buffer[8];
	int value=-1;
	if(argc==2)
		strcpy(buffer,argv[1]);
	else
		gets(buffer);
	if(value!=MAGIC)
		printf("You did not get the number right (%d)", value);
	else
		printf("Congrats! You got the correct number (%d)!", value);
	return 0;
}

void special(int argument){
	printf("Congrats! You got to the hidden section!");
	if(argument!=MAGIC_2)
		printf("You did not get the number right (%d)", argument);
	else
		printf("Congrats! You got the correct number (%d)!", argument);
	return;
}
