Done by Mohamed Riyas and Mohideen Imran Khan


# Problem statement
Gradient descent algorithm makes use of the property of function gradient to find local minimum value for a given function. For this assignment, our group was tasked to write the assembly language function optimize() in the file “optimize.s” to implement the gradient descent algorithm. The below sections will examine the design methodology and implementation aspects of the assignment.

# Design methodology
1.	It can become very difficult to handle floating numbers in assembly language. And as such, we decided to cast the floating-point number to an integer value in C before passing the value to the function in assembly language. However, we found out that a simple and direct casting may still result in loss of precision. In order to prevent such issues with casting, we decided to preform scaling for the input of x. To be more specify, we multiplied x by 10,000 and then converted x into an integer value in C. By doing this, we were able to ensure a precision of 0.00001 and therefore reduce the loss of precision when performing the conversion to an integer.
2.	The optimized solution for some functions may not necessarily be an integer value. For instance, for quadratic functions, the optimized solution (-b/(2a)) may not always be an integer. Hence, by scaling up the optimized value, we realized that there is an increased chance to get near to the correct value. s
3.	We decided to keep track of the number of iterations in the assembly program by passing in an additional parameter, the address of “count”, to the assembly program. So, assembly function will do a load operation from the given address and store the final value back. Then in C we just need to do print out “count” as the value in the address is updated already by assembly function.
4.	However, one potential issue of scaling is the risk of overflow. To prevent such as issue, we decided to scale x by only up to 10,000.

# Implementation

## The C program

Take note that the function signature is altered to fit in to find and print the total number of iterations recorded in the function in the assembly language. In addition, we also decided to drop the variable c, in the function declaration since the value of “c” does not influence the calculation at all.In the C program, integer values are bit-shifted to the left by 16 positions and `lambda` is multiplied by `2^16` to emulate a fixed-point number. This data scaling ensures that the decimal part is not totally lost. However, we concede that the accuracy of the number is compromised here. For instance, the floating-point value `...` is simply taken as `...` with our scaling method. For our use case, this is acceptable.

The relevant parts of our C program are as follows:

`#define MULTIPLIER 10000`\
`extern int optimize(int xi, int a, int b, int* counter);`

Here, we are passing in the integer value of “xi” after the scaling operation, the value of “a”, the value “b” after the scaling operation and lastly the address of “counter” which stands for count.


`printf("ARM ASM & Integer version:\n");`\
`xsoli = optimize((int)(x * MULTIPLIER), a, b * MULTIPLIER, &counter);`\
`xsol = (float) xsoli / MULTIPLIER;`\
`printf("xsol : %f, no. of iterations : %d \n\n", xsol, counter);`

The above part is calling optimize function in the assembly language and printing out the result of optimize by first scaling down the value of optimized solution and casting it to a float. The below subsection examines the optimize function in the assemble language.

## The assembly program

We break down the optimization process into two routines, `optimize` and `loop`. 
- The `optimize` subroutine performs a single update of the current `x` value.
- The `loop` routine calls the `step` subroutine repeatedly till `x` converges (`x*`).

The `optimize` subroutine is as follows:

`PUSH {R1-R6}           @ save registers`\
`LDR  R4, LAMBDA_INV    @ load R4 which is = 1/lambda`\
`MOV  R5, #0            @ num iterations counter = 0`


The `loop` routine is as follows:

`ADD   R5, #1                @ increment counter`\
`MUL   R6, R0, R1            @ R7 = ax = R0 * R1;`\
`ADD   R6, R2, R6, LSL #1    @ R7 = 2ax + b = 2 * R7 + R2; (fp)`\
`SDIV  R6, R6, R4            @ R7 = fp * lambda = R7 * R4`\
`SUB   R0, R0, R6            @ R0 = x - fp * lambda;`\
`CMP   R6, #0                @ check if x = xprev`\
`BNE   loop                  @ if x != xprev, loop`

`STR  R5, [R3]          @ store num iterations at pointed location`\
`POP  {R1-R6}           @ restore registers`\
`BX   LR                @ return`


Note that both `optimize` and `loop` are designed to handle only integer values.



