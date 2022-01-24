#include "stdio.h"

// CG2028 Assignment
// (C) CK Tham, ECE, NUS

// Optimization routine written in assembly language
// Input parameters (signed integers):
//     xi : integer version of x
//     a, b, c : integer coefficients of f(x)
// Output : returns solution x (signed integer)
extern int optimize(int xi, int a, int b, int *counter);

#define MULTIPLIER 10000

int main(void)
{
    int a=3, b=4, c=-3, xsoli, counter = 0;
    float fp, x, xprev, xsol, change, lambda=0.1;

    printf("Initial value of x (press [Enter] after keying in): "); // try x0 = -6.78
    scanf("%f", &x);

//  ARM ASM & Integer version
    printf("ARM ASM & Integer version:\n");
    xsoli = optimize((int)(x * MULTIPLIER), a, b * MULTIPLIER, &counter);
    xsol = (float) xsoli / MULTIPLIER;
    printf("xsol : %f, no. of iterations : %d \n\n", xsol, counter);

//  NOTE: You DO NOT need to modify the code below this line

//  C & Floating Point version
  	printf("C & Floating point version:\n",x);
  	counter = 0;
    while (1)
    {
    	counter++;
    	fp = 2*a*x + b;

    	xprev = x;
    	change = -lambda*fp;
    	x += change;

    	printf("x: %f, fp: %f, change: %f\n", x, fp, change);
    	if (x==xprev) break;
    }
    printf("No. of iterations: %d\n", counter);

    // Enter an infinite loop, just incrementing a counter
	// This is for convenience to allow registers, variables and memory locations to be inspected at the end
	volatile static int loop = 0;
	while (1) {
		loop++;
	}
}

