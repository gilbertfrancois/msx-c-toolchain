#include <msx_fusion.h>
#include <stdio.h>

int add(int a, int b) {
	return a + b; 
}

void main(void) { 
	int a = 1;
	int b = 2;
	int value = add(a, b); 
	printf("The sum of %d+%d=%d\r\n", a, b, value);
}

