disassemble: program
	objdump -d program

program:
	gcc -O0 -g -Wno-deprecated-declarations -std=c99 program.c -o program

clean:
	rm program
