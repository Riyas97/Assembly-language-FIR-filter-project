   1              		.syntax unified
   2              		.cpu cortex-m3
   3              		.fpu softvfp
   4              		.eabi_attribute 20, 1
   5              		.eabi_attribute 21, 1
   6              		.eabi_attribute 23, 3
   7              		.eabi_attribute 24, 1
   8              		.eabi_attribute 25, 1
   9              		.eabi_attribute 26, 1
  10              		.eabi_attribute 30, 6
  11              		.eabi_attribute 34, 1
  12              		.eabi_attribute 18, 4
  13              		.thumb
  14              		.file	"main.c"
  15              		.text
  16              	.Ltext0:
  17              		.cfi_sections	.debug_frame
  18              		.section	.rodata
  19              		.align	2
  20              	.LC0:
  21 0000 496E6974 		.ascii	"Initial value of x (press [Enter] after keying in):"
  21      69616C20 
  21      76616C75 
  21      65206F66 
  21      20782028 
  22 0033 2000     		.ascii	" \000"
  23 0035 000000   		.align	2
  24              	.LC1:
  25 0038 256600   		.ascii	"%f\000"
  26 003b 00       		.align	2
  27              	.LC2:
  28 003c 41524D20 		.ascii	"ARM ASM & Integer version:\012\000"
  28      41534D20 
  28      2620496E 
  28      74656765 
  28      72207665 
  29              		.global	__aeabi_fmul
  30              		.global	__aeabi_f2iz
  31              		.global	__aeabi_i2f
  32              		.global	__aeabi_fdiv
  33              		.align	2
  34              	.LC3:
  35 0058 78736F6C 		.ascii	"xsol : %f, no. of iterations : %d \012\012\000"
  35      203A2025 
  35      662C206E 
  35      6F2E206F 
  35      66206974 
  36              		.global	__aeabi_f2d
  37 007d 000000   		.align	2
  38              	.LC4:
  39 0080 43202620 		.ascii	"C & Floating point version:\012\000"
  39      466C6F61 
  39      74696E67 
  39      20706F69 
  39      6E742076 
  40              		.global	__aeabi_fadd
  41 009d 000000   		.align	2
  42              	.LC5:
  43 00a0 783A2025 		.ascii	"x: %f, fp: %f, change: %f\012\000"
  43      662C2066 
  43      703A2025 
  43      662C2063 
  43      68616E67 
  44              		.global	__aeabi_fcmpeq
  45 00bb 00       		.align	2
  46              	.LC6:
  47 00bc 4E6F2E20 		.ascii	"No. of iterations: %d\012\000"
  47      6F662069 
  47      74657261 
  47      74696F6E 
  47      733A2025 
  48 00d3 00       		.section	.text.main,"ax",%progbits
  49              		.align	2
  50              		.global	main
  51              		.thumb
  52              		.thumb_func
  54              	main:
  55              	.LFB0:
  56              		.file 1 "../src/main.c"
   1:../src/main.c **** #include "stdio.h"
   2:../src/main.c **** 
   3:../src/main.c **** // CG2028 Assignment
   4:../src/main.c **** // (C) CK Tham, ECE, NUS
   5:../src/main.c **** 
   6:../src/main.c **** // Optimization routine written in assembly language
   7:../src/main.c **** // Input parameters (signed integers):
   8:../src/main.c **** //     xi : integer version of x
   9:../src/main.c **** //     a, b, c : integer coefficients of f(x)
  10:../src/main.c **** // Output : returns solution x (signed integer)
  11:../src/main.c **** extern int optimize(int xi, int a, int b, int *counter);
  12:../src/main.c **** 
  13:../src/main.c **** #define MULTIPLIER 10000
  14:../src/main.c **** 
  15:../src/main.c **** int main(void)
  16:../src/main.c **** {
  57              		.loc 1 16 0
  58              		.cfi_startproc
  59              		@ args = 0, pretend = 0, frame = 48
  60              		@ frame_needed = 1, uses_anonymous_args = 0
  61 0000 2DE9904F 		push	{r4, r7, r8, r9, sl, fp, lr}
  62              	.LCFI0:
  63              		.cfi_def_cfa_offset 28
  64              		.cfi_offset 14, -4
  65              		.cfi_offset 11, -8
  66              		.cfi_offset 10, -12
  67              		.cfi_offset 9, -16
  68              		.cfi_offset 8, -20
  69              		.cfi_offset 7, -24
  70              		.cfi_offset 4, -28
  71 0004 91B0     		sub	sp, sp, #68
  72              	.LCFI1:
  73              		.cfi_def_cfa_offset 96
  74 0006 04AF     		add	r7, sp, #16
  75              	.LCFI2:
  76              		.cfi_def_cfa 7, 80
  17:../src/main.c ****     int a=5, b=0, c=-9, xsoli, counter = 0;
  77              		.loc 1 17 0
  78 0008 4FF00503 		mov	r3, #5
  79 000c FB62     		str	r3, [r7, #44]
  80 000e 4FF00003 		mov	r3, #0
  81 0012 BB62     		str	r3, [r7, #40]
  82 0014 6FF00803 		mvn	r3, #8
  83 0018 7B62     		str	r3, [r7, #36]
  84 001a 4FF00003 		mov	r3, #0
  85 001e BB60     		str	r3, [r7, #8]
  18:../src/main.c ****     float fp, x, xprev, xsol, change, lambda=0.5;
  86              		.loc 1 18 0
  87 0020 614B     		ldr	r3, .L8	@ float
  88 0022 3B62     		str	r3, [r7, #32]	@ float
  19:../src/main.c **** 
  20:../src/main.c ****     printf("Initial value of x (press [Enter] after keying in): "); // try x0 = -6.78
  89              		.loc 1 20 0
  90 0024 40F20003 		movw	r3, #:lower16:.LC0
  91 0028 C0F20003 		movt	r3, #:upper16:.LC0
  92 002c 1846     		mov	r0, r3
  93 002e FFF7FEFF 		bl	printf
  21:../src/main.c ****     scanf("%f", &x);
  94              		.loc 1 21 0
  95 0032 40F20003 		movw	r3, #:lower16:.LC1
  96 0036 C0F20003 		movt	r3, #:upper16:.LC1
  97 003a 07F10402 		add	r2, r7, #4
  98 003e 1846     		mov	r0, r3
  99 0040 1146     		mov	r1, r2
 100 0042 FFF7FEFF 		bl	scanf
  22:../src/main.c **** 
  23:../src/main.c **** //  ARM ASM & Integer version
  24:../src/main.c ****     printf("ARM ASM & Integer version:\n");
 101              		.loc 1 24 0
 102 0046 40F20003 		movw	r3, #:lower16:.LC2
 103 004a C0F20003 		movt	r3, #:upper16:.LC2
 104 004e 1846     		mov	r0, r3
 105 0050 FFF7FEFF 		bl	printf
  25:../src/main.c ****     xsoli = optimize((int)(x * MULTIPLIER), a, b * MULTIPLIER, &counter);
 106              		.loc 1 25 0
 107 0054 7B68     		ldr	r3, [r7, #4]	@ float
 108 0056 1846     		mov	r0, r3
 109 0058 5449     		ldr	r1, .L8+4	@ float
 110 005a FFF7FEFF 		bl	__aeabi_fmul
 111 005e 0346     		mov	r3, r0
 112 0060 1846     		mov	r0, r3
 113 0062 FFF7FEFF 		bl	__aeabi_f2iz
 114 0066 0146     		mov	r1, r0
 115 0068 BB6A     		ldr	r3, [r7, #40]
 116 006a 42F21072 		movw	r2, #10000
 117 006e 02FB03F2 		mul	r2, r2, r3
 118 0072 07F10803 		add	r3, r7, #8
 119 0076 0846     		mov	r0, r1
 120 0078 F96A     		ldr	r1, [r7, #44]
 121 007a FFF7FEFF 		bl	optimize
 122 007e 0346     		mov	r3, r0
 123 0080 FB61     		str	r3, [r7, #28]
  26:../src/main.c ****     xsol = (float) xsoli / MULTIPLIER;
 124              		.loc 1 26 0
 125 0082 F869     		ldr	r0, [r7, #28]
 126 0084 FFF7FEFF 		bl	__aeabi_i2f
 127 0088 0346     		mov	r3, r0
 128 008a 1846     		mov	r0, r3
 129 008c 4749     		ldr	r1, .L8+4	@ float
 130 008e FFF7FEFF 		bl	__aeabi_fdiv
 131 0092 0346     		mov	r3, r0
 132 0094 BB61     		str	r3, [r7, #24]	@ float
  27:../src/main.c ****     printf("xsol : %f, no. of iterations : %d \n\n", xsol, counter);
 133              		.loc 1 27 0
 134 0096 40F20004 		movw	r4, #:lower16:.LC3
 135 009a C0F20004 		movt	r4, #:upper16:.LC3
 136 009e B869     		ldr	r0, [r7, #24]	@ float
 137 00a0 FFF7FEFF 		bl	__aeabi_f2d
 138 00a4 0246     		mov	r2, r0
 139 00a6 0B46     		mov	r3, r1
 140 00a8 B968     		ldr	r1, [r7, #8]
 141 00aa 0091     		str	r1, [sp, #0]
 142 00ac 2046     		mov	r0, r4
 143 00ae FFF7FEFF 		bl	printf
  28:../src/main.c **** 
  29:../src/main.c **** //  NOTE: You DO NOT need to modify the code below this line
  30:../src/main.c **** 
  31:../src/main.c **** //  C & Floating Point version
  32:../src/main.c ****   	printf("C & Floating point version:\n",x);
 144              		.loc 1 32 0
 145 00b2 40F20004 		movw	r4, #:lower16:.LC4
 146 00b6 C0F20004 		movt	r4, #:upper16:.LC4
 147 00ba 7B68     		ldr	r3, [r7, #4]	@ float
 148 00bc 1846     		mov	r0, r3
 149 00be FFF7FEFF 		bl	__aeabi_f2d
 150 00c2 0246     		mov	r2, r0
 151 00c4 0B46     		mov	r3, r1
 152 00c6 2046     		mov	r0, r4
 153 00c8 FFF7FEFF 		bl	printf
  33:../src/main.c ****   	counter = 0;
 154              		.loc 1 33 0
 155 00cc 4FF00003 		mov	r3, #0
 156 00d0 BB60     		str	r3, [r7, #8]
 157              	.L5:
  34:../src/main.c ****     while (1)
  35:../src/main.c ****     {
  36:../src/main.c ****     	counter++;
 158              		.loc 1 36 0
 159 00d2 BB68     		ldr	r3, [r7, #8]
 160 00d4 03F10103 		add	r3, r3, #1
 161 00d8 BB60     		str	r3, [r7, #8]
  37:../src/main.c ****     	fp = 2*a*x + b;
 162              		.loc 1 37 0
 163 00da FB6A     		ldr	r3, [r7, #44]
 164 00dc 4FEA4303 		lsl	r3, r3, #1
 165 00e0 1846     		mov	r0, r3
 166 00e2 FFF7FEFF 		bl	__aeabi_i2f
 167 00e6 0246     		mov	r2, r0
 168 00e8 7B68     		ldr	r3, [r7, #4]	@ float
 169 00ea 1046     		mov	r0, r2
 170 00ec 1946     		mov	r1, r3
 171 00ee FFF7FEFF 		bl	__aeabi_fmul
 172 00f2 0346     		mov	r3, r0
 173 00f4 1C46     		mov	r4, r3
 174 00f6 B86A     		ldr	r0, [r7, #40]
 175 00f8 FFF7FEFF 		bl	__aeabi_i2f
 176 00fc 0346     		mov	r3, r0
 177 00fe 2046     		mov	r0, r4
 178 0100 1946     		mov	r1, r3
 179 0102 FFF7FEFF 		bl	__aeabi_fadd
 180 0106 0346     		mov	r3, r0
 181 0108 7B61     		str	r3, [r7, #20]	@ float
  38:../src/main.c **** 
  39:../src/main.c ****     	xprev = x;
 182              		.loc 1 39 0
 183 010a 7B68     		ldr	r3, [r7, #4]	@ float
 184 010c 3B61     		str	r3, [r7, #16]	@ float
  40:../src/main.c ****     	change = -lambda*fp;
 185              		.loc 1 40 0
 186 010e 3B6A     		ldr	r3, [r7, #32]
 187 0110 83F00043 		eor	r3, r3, #-2147483648
 188 0114 1846     		mov	r0, r3
 189 0116 7969     		ldr	r1, [r7, #20]	@ float
 190 0118 FFF7FEFF 		bl	__aeabi_fmul
 191 011c 0346     		mov	r3, r0
 192 011e FB60     		str	r3, [r7, #12]	@ float
  41:../src/main.c ****     	x += change;
 193              		.loc 1 41 0
 194 0120 7B68     		ldr	r3, [r7, #4]	@ float
 195 0122 1846     		mov	r0, r3
 196 0124 F968     		ldr	r1, [r7, #12]	@ float
 197 0126 FFF7FEFF 		bl	__aeabi_fadd
 198 012a 0346     		mov	r3, r0
 199 012c 7B60     		str	r3, [r7, #4]	@ float
  42:../src/main.c **** 
  43:../src/main.c ****     	printf("x: %f, fp: %f, change: %f\n", x, fp, change);
 200              		.loc 1 43 0
 201 012e 40F20004 		movw	r4, #:lower16:.LC5
 202 0132 C0F20004 		movt	r4, #:upper16:.LC5
 203 0136 7B68     		ldr	r3, [r7, #4]	@ float
 204 0138 1846     		mov	r0, r3
 205 013a FFF7FEFF 		bl	__aeabi_f2d
 206 013e 8046     		mov	r8, r0
 207 0140 8946     		mov	r9, r1
 208 0142 7869     		ldr	r0, [r7, #20]	@ float
 209 0144 FFF7FEFF 		bl	__aeabi_f2d
 210 0148 8246     		mov	sl, r0
 211 014a 8B46     		mov	fp, r1
 212 014c F868     		ldr	r0, [r7, #12]	@ float
 213 014e FFF7FEFF 		bl	__aeabi_f2d
 214 0152 0246     		mov	r2, r0
 215 0154 0B46     		mov	r3, r1
 216 0156 CDE900AB 		strd	sl, [sp]
 217 015a CDE90223 		strd	r2, [sp, #8]
 218 015e 2046     		mov	r0, r4
 219 0160 4246     		mov	r2, r8
 220 0162 4B46     		mov	r3, r9
 221 0164 FFF7FEFF 		bl	printf
  44:../src/main.c ****     	if (x==xprev) break;
 222              		.loc 1 44 0
 223 0168 7B68     		ldr	r3, [r7, #4]	@ float
 224 016a 1846     		mov	r0, r3
 225 016c 3969     		ldr	r1, [r7, #16]	@ float
 226 016e FFF7FEFF 		bl	__aeabi_fcmpeq
 227 0172 0346     		mov	r3, r0
 228 0174 002B     		cmp	r3, #0
 229 0176 00D1     		bne	.L7
  45:../src/main.c ****     }
 230              		.loc 1 45 0
 231 0178 ABE7     		b	.L5
 232              	.L7:
  44:../src/main.c ****     	if (x==xprev) break;
 233              		.loc 1 44 0
 234 017a 00BF     		nop
 235              	.L4:
  46:../src/main.c ****     printf("No. of iterations: %d\n", counter);
 236              		.loc 1 46 0
 237 017c 40F20003 		movw	r3, #:lower16:.LC6
 238 0180 C0F20003 		movt	r3, #:upper16:.LC6
 239 0184 BA68     		ldr	r2, [r7, #8]
 240 0186 1846     		mov	r0, r3
 241 0188 1146     		mov	r1, r2
 242 018a FFF7FEFF 		bl	printf
 243              	.L6:
  47:../src/main.c **** 
  48:../src/main.c ****     // Enter an infinite loop, just incrementing a counter
  49:../src/main.c **** 	// This is for convenience to allow registers, variables and memory locations to be inspected at t
  50:../src/main.c **** 	volatile static int loop = 0;
  51:../src/main.c **** 	while (1) {
  52:../src/main.c **** 		loop++;
 244              		.loc 1 52 0 discriminator 1
 245 018e 40F20003 		movw	r3, #:lower16:loop.3827
 246 0192 C0F20003 		movt	r3, #:upper16:loop.3827
 247 0196 1B68     		ldr	r3, [r3, #0]
 248 0198 03F10102 		add	r2, r3, #1
 249 019c 40F20003 		movw	r3, #:lower16:loop.3827
 250 01a0 C0F20003 		movt	r3, #:upper16:loop.3827
 251 01a4 1A60     		str	r2, [r3, #0]
  53:../src/main.c **** 	}
 252              		.loc 1 53 0 discriminator 1
 253 01a6 F2E7     		b	.L6
 254              	.L9:
 255              		.align	2
 256              	.L8:
 257 01a8 0000003F 		.word	1056964608
 258 01ac 00401C46 		.word	1176256512
 259              		.cfi_endproc
 260              	.LFE0:
 262              		.bss
 263              		.align	2
 264              	loop.3827:
 265 0000 00000000 		.space	4
 266              		.text
 267              	.Letext0:
DEFINED SYMBOLS
                            *ABS*:00000000 main.c
C:\Users\Imran\AppData\Local\Temp\ccsN4wBr.s:19     .rodata:00000000 $d
C:\Users\Imran\AppData\Local\Temp\ccsN4wBr.s:20     .rodata:00000000 .LC0
C:\Users\Imran\AppData\Local\Temp\ccsN4wBr.s:24     .rodata:00000038 .LC1
C:\Users\Imran\AppData\Local\Temp\ccsN4wBr.s:27     .rodata:0000003c .LC2
C:\Users\Imran\AppData\Local\Temp\ccsN4wBr.s:34     .rodata:00000058 .LC3
C:\Users\Imran\AppData\Local\Temp\ccsN4wBr.s:38     .rodata:00000080 .LC4
C:\Users\Imran\AppData\Local\Temp\ccsN4wBr.s:42     .rodata:000000a0 .LC5
C:\Users\Imran\AppData\Local\Temp\ccsN4wBr.s:46     .rodata:000000bc .LC6
C:\Users\Imran\AppData\Local\Temp\ccsN4wBr.s:49     .text.main:00000000 $t
C:\Users\Imran\AppData\Local\Temp\ccsN4wBr.s:54     .text.main:00000000 main
C:\Users\Imran\AppData\Local\Temp\ccsN4wBr.s:264    .bss:00000000 loop.3827
C:\Users\Imran\AppData\Local\Temp\ccsN4wBr.s:257    .text.main:000001a8 $d
C:\Users\Imran\AppData\Local\Temp\ccsN4wBr.s:263    .bss:00000000 $d
                     .debug_frame:00000010 $d

UNDEFINED SYMBOLS
__aeabi_fmul
__aeabi_f2iz
__aeabi_i2f
__aeabi_fdiv
__aeabi_f2d
__aeabi_fadd
__aeabi_fcmpeq
printf
scanf
optimize
