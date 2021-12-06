	.arch armv6
	.eabi_attribute 28, 1	@ Tag_ABI_VFP_args
	.eabi_attribute 20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute 21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute 23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute 24, 1	@ Tag_ABI_align8_needed
	.eabi_attribute 25, 1	@ Tag_ABI_align8_preserved
	.eabi_attribute 26, 2	@ Tag_ABI_enum_size
	.eabi_attribute 30, 6	@ Tag_ABI_optimization_goals
	.eabi_attribute 34, 1	@ Tag_CPU_unaligned_access
	.eabi_attribute 18, 4	@ Tag_ABI_PCS_wchar_t
	.file	"main.c"
@ GNU C17 (Raspbian 8.3.0-6+rpi1) version 8.3.0 (arm-linux-gnueabihf)
@	compiled by GNU C version 8.3.0, GMP version 6.1.2, MPFR version 4.0.2, MPC version 1.1.0, isl version isl-0.20-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib . -imultiarch arm-linux-gnueabihf main.c
@ -mfloat-abi=hard -mfpu=vfp -mtls-dialect=gnu -marm -march=armv6+fp
@ -fverbose-asm
@ options enabled:  -faggressive-loop-optimizations -fauto-inc-dec
@ -fchkp-check-incomplete-type -fchkp-check-read -fchkp-check-write
@ -fchkp-instrument-calls -fchkp-narrow-bounds -fchkp-optimize
@ -fchkp-store-bounds -fchkp-use-static-bounds
@ -fchkp-use-static-const-bounds -fchkp-use-wrappers -fcommon
@ -fdelete-null-pointer-checks -fdwarf2-cfi-asm -fearly-inlining
@ -feliminate-unused-debug-types -ffp-int-builtin-inexact -ffunction-cse
@ -fgcse-lm -fgnu-runtime -fgnu-unique -fident -finline-atomics
@ -fira-hoist-pressure -fira-share-save-slots -fira-share-spill-slots
@ -fivopts -fkeep-static-consts -fleading-underscore -flifetime-dse
@ -flto-odr-type-merging -fmath-errno -fmerge-debug-strings -fpeephole
@ -fplt -fprefetch-loop-arrays -freg-struct-return
@ -fsched-critical-path-heuristic -fsched-dep-count-heuristic
@ -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
@ -fsched-rank-heuristic -fsched-spec -fsched-spec-insn-heuristic
@ -fsched-stalled-insns-dep -fsemantic-interposition -fshow-column
@ -fshrink-wrap-separate -fsigned-zeros -fsplit-ivs-in-unroller
@ -fssa-backprop -fstdarg-opt -fstrict-volatile-bitfields -fsync-libcalls
@ -ftrapping-math -ftree-cselim -ftree-forwprop -ftree-loop-if-convert
@ -ftree-loop-im -ftree-loop-ivcanon -ftree-loop-optimize
@ -ftree-parallelize-loops= -ftree-phiprop -ftree-reassoc -ftree-scev-cprop
@ -funit-at-a-time -fverbose-asm -fzero-initialized-in-bss -marm -mbe32
@ -mglibc -mlittle-endian -mpic-data-is-text-relative -msched-prolog
@ -munaligned-access -mvectorize-with-neon-quad

	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"memory error\000"
	.align	2
.LC1:
	.ascii	".data\012\000"
	.align	2
.LC2:
	.ascii	"Type name of file to open:\000"
	.align	2
.LC3:
	.ascii	"%s\000"
	.align	2
.LC4:
	.ascii	"r\000"
	.align	2
.LC5:
	.ascii	"w\000"
	.align	2
.LC6:
	.ascii	"dat.txt\000"
	.align	2
.LC7:
	.ascii	"Exited\000"
	.align	2
.LC8:
	.ascii	".text\012\000"
	.align	2
.LC9:
	.ascii	"ins.txt\000"
	.text
	.align	2
	.global	main
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 112
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}	@
	add	fp, sp, #4	@,,
	sub	sp, sp, #120	@,,
@ main.c:13:     fpos_t *mark = NULL;
	mov	r3, #0	@ tmp116,
	str	r3, [fp, #-32]	@ tmp116, mark
@ main.c:14:     fpos_t *cur = NULL;
	mov	r3, #0	@ tmp117,
	str	r3, [fp, #-36]	@ tmp117, cur
@ main.c:15:     int ret = 0;
	mov	r3, #0	@ tmp118,
	str	r3, [fp, #-20]	@ tmp118, ret
@ main.c:16:     int exit = 0;
	mov	r3, #0	@ tmp119,
	str	r3, [fp, #-24]	@ tmp119, exit
@ main.c:20:     char *buf = NULL;
	mov	r3, #0	@ tmp120,
	str	r3, [fp, #-40]	@ tmp120, buf
@ main.c:21:     char *locator = NULL;
	mov	r3, #0	@ tmp121,
	str	r3, [fp, #-28]	@ tmp121, locator
@ main.c:26:     locator = malloc(10 * sizeof(char));
	mov	r0, #10	@,
	bl	malloc		@
	mov	r3, r0	@ tmp122,
	str	r3, [fp, #-28]	@ tmp122, locator
@ main.c:27:     if (locator == NULL)
	ldr	r3, [fp, #-28]	@ tmp123, locator
	cmp	r3, #0	@ tmp123,
	bne	.L2		@,
@ main.c:29:         perror("memory error");
	ldr	r0, .L25	@,
	bl	perror		@
@ main.c:30:         ret = -1;
	mvn	r3, #0	@ tmp124,
	str	r3, [fp, #-20]	@ tmp124, ret
@ main.c:31:         goto fail;
	b	.L3		@
.L2:
@ main.c:34:     buf = malloc(256 * sizeof(char));
	mov	r0, #256	@,
	bl	malloc		@
	mov	r3, r0	@ tmp125,
	str	r3, [fp, #-40]	@ tmp125, buf
@ main.c:35:     if (buf == NULL)
	ldr	r3, [fp, #-40]	@ tmp126, buf
	cmp	r3, #0	@ tmp126,
	bne	.L4		@,
@ main.c:37:         perror("memory error");
	ldr	r0, .L25	@,
	bl	perror		@
@ main.c:38:         ret = -1;
	mvn	r3, #0	@ tmp127,
	str	r3, [fp, #-20]	@ tmp127, ret
@ main.c:39:         goto fail;
	b	.L3		@
.L4:
@ main.c:43:     locator = ".data\n";
	ldr	r3, .L25+4	@ tmp128,
	str	r3, [fp, #-28]	@ tmp128, locator
@ main.c:44:     flag = 0;
	mov	r3, #0	@ tmp129,
	str	r3, [fp, #-44]	@ tmp129, flag
@ main.c:48:     printf("Type name of file to open:\n");
	ldr	r0, .L25+8	@,
	bl	puts		@
@ main.c:49:     scanf("%s",fname);
	sub	r3, fp, #116	@ tmp130,,
	mov	r1, r3	@, tmp130
	ldr	r0, .L25+12	@,
	bl	__isoc99_scanf		@
@ main.c:50:     input = fopen(fname, "r");
	sub	r3, fp, #116	@ tmp131,,
	ldr	r1, .L25+16	@,
	mov	r0, r3	@, tmp131
	bl	fopen		@
	str	r0, [fp, #-8]	@, input
@ main.c:51:     if (input == NULL)
	ldr	r3, [fp, #-8]	@ tmp132, input
	cmp	r3, #0	@ tmp132,
	beq	.L20		@,
@ main.c:55:     ret = find_event(input, mark, locator);
	ldr	r2, [fp, #-28]	@, locator
	ldr	r1, [fp, #-32]	@, mark
	ldr	r0, [fp, #-8]	@, input
	bl	find_event		@
	str	r0, [fp, #-20]	@, ret
@ main.c:58:     dat = fopen("dat.txt", "w");
	ldr	r1, .L25+20	@,
	ldr	r0, .L25+24	@,
	bl	fopen		@
	str	r0, [fp, #-16]	@, dat
@ main.c:59:     if (dat == NULL)
	ldr	r3, [fp, #-16]	@ tmp133, dat
	cmp	r3, #0	@ tmp133,
	beq	.L21		@,
@ main.c:63:     while (exit != 1)
	b	.L7		@
.L10:
@ main.c:65:         if (fgets(buf, 256, input) == NULL)
	ldr	r2, [fp, #-8]	@, input
	mov	r1, #256	@,
	ldr	r0, [fp, #-40]	@, buf
	bl	fgets		@
	mov	r3, r0	@ _1,
@ main.c:65:         if (fgets(buf, 256, input) == NULL)
	cmp	r3, #0	@ _1,
	beq	.L22		@,
@ main.c:68:         if (buf[0] != '\n')
	ldr	r3, [fp, #-40]	@ tmp134, buf
	ldrb	r3, [r3]	@ zero_extendqisi2	@ _2, *buf_35
@ main.c:68:         if (buf[0] != '\n')
	cmp	r3, #10	@ _2,
	beq	.L7		@,
@ main.c:69:             exit = parse(buf, flag, dat, dat_mem, ins_mem);
	ldr	r3, [fp, #-52]	@ tmp135, ins_mem
	str	r3, [sp]	@ tmp135,
	ldr	r3, [fp, #-48]	@, dat_mem
	ldr	r2, [fp, #-16]	@, dat
	ldr	r1, [fp, #-44]	@, flag
	ldr	r0, [fp, #-40]	@, buf
	bl	parse		@
	str	r0, [fp, #-24]	@, exit
.L7:
@ main.c:63:     while (exit != 1)
	ldr	r3, [fp, #-24]	@ tmp136, exit
	cmp	r3, #1	@ tmp136,
	bne	.L10		@,
	b	.L9		@
.L22:
@ main.c:66:             break;
	nop	
.L9:
@ main.c:72:     printf("Exited\n");
	ldr	r0, .L25+28	@,
	bl	puts		@
@ main.c:75:     fclose(dat);
	ldr	r0, [fp, #-16]	@, dat
	bl	fclose		@
@ main.c:78:     locator = ".text\n";
	ldr	r3, .L25+32	@ tmp137,
	str	r3, [fp, #-28]	@ tmp137, locator
@ main.c:79:     rewind(input);
	ldr	r0, [fp, #-8]	@, input
	bl	rewind		@
@ main.c:80:     flag  = 1;
	mov	r3, #1	@ tmp138,
	str	r3, [fp, #-44]	@ tmp138, flag
@ main.c:81:     exit = 0;
	mov	r3, #0	@ tmp139,
	str	r3, [fp, #-24]	@ tmp139, exit
@ main.c:84:     ret = find_event(input, mark, locator);
	ldr	r2, [fp, #-28]	@, locator
	ldr	r1, [fp, #-32]	@, mark
	ldr	r0, [fp, #-8]	@, input
	bl	find_event		@
	str	r0, [fp, #-20]	@, ret
@ main.c:87:     ins = fopen("ins.txt", "w");
	ldr	r1, .L25+20	@,
	ldr	r0, .L25+36	@,
	bl	fopen		@
	str	r0, [fp, #-12]	@, ins
@ main.c:88:     if (ins == NULL)
	ldr	r3, [fp, #-12]	@ tmp140, ins
	cmp	r3, #0	@ tmp140,
	beq	.L23		@,
@ main.c:92:     while (exit != 1)
	b	.L12		@
.L14:
@ main.c:94:         if (fgets(buf, 256, input) == NULL)
	ldr	r2, [fp, #-8]	@, input
	mov	r1, #256	@,
	ldr	r0, [fp, #-40]	@, buf
	bl	fgets		@
	mov	r3, r0	@ _3,
@ main.c:94:         if (fgets(buf, 256, input) == NULL)
	cmp	r3, #0	@ _3,
	beq	.L24		@,
@ main.c:97:         if (buf[0] != '\n')
	ldr	r3, [fp, #-40]	@ tmp141, buf
	ldrb	r3, [r3]	@ zero_extendqisi2	@ _4, *buf_35
@ main.c:97:         if (buf[0] != '\n')
	cmp	r3, #10	@ _4,
	beq	.L12		@,
@ main.c:98:             exit = parse(buf, flag, ins, dat_mem, ins_mem);
	ldr	r3, [fp, #-52]	@ tmp142, ins_mem
	str	r3, [sp]	@ tmp142,
	ldr	r3, [fp, #-48]	@, dat_mem
	ldr	r2, [fp, #-12]	@, ins
	ldr	r1, [fp, #-44]	@, flag
	ldr	r0, [fp, #-40]	@, buf
	bl	parse		@
	str	r0, [fp, #-24]	@, exit
.L12:
@ main.c:92:     while (exit != 1)
	ldr	r3, [fp, #-24]	@ tmp143, exit
	cmp	r3, #1	@ tmp143,
	bne	.L14		@,
@ main.c:101: fail:
	b	.L3		@
.L20:
@ main.c:52:         goto fail;
	nop	
	b	.L3		@
.L21:
@ main.c:60:         goto fail;
	nop	
	b	.L3		@
.L23:
@ main.c:89:         goto fail;
	nop	
	b	.L3		@
.L24:
@ main.c:95:             break;
	nop	
.L3:
@ main.c:103:     if (locator)
	ldr	r3, [fp, #-28]	@ tmp144, locator
	cmp	r3, #0	@ tmp144,
	beq	.L15		@,
@ main.c:104:         free(locator);
	ldr	r0, [fp, #-28]	@, locator
	bl	free		@
.L15:
@ main.c:105:     if (input)
	ldr	r3, [fp, #-8]	@ tmp145, input
	cmp	r3, #0	@ tmp145,
	beq	.L16		@,
@ main.c:106:         fclose(input);
	ldr	r0, [fp, #-8]	@, input
	bl	fclose		@
.L16:
@ main.c:107:     if (dat)
	ldr	r3, [fp, #-16]	@ tmp146, dat
	cmp	r3, #0	@ tmp146,
	beq	.L17		@,
@ main.c:108:         fclose(dat);
	ldr	r0, [fp, #-16]	@, dat
	bl	fclose		@
.L17:
@ main.c:109:     if (ins)
	ldr	r3, [fp, #-12]	@ tmp147, ins
	cmp	r3, #0	@ tmp147,
	beq	.L18		@,
@ main.c:110:         fclose(ins);
	ldr	r0, [fp, #-12]	@, ins
	bl	fclose		@
.L18:
@ main.c:112:     return ret;
	ldr	r3, [fp, #-20]	@ _70, ret
@ main.c:113: }
	mov	r0, r3	@, <retval>
	sub	sp, fp, #4	@,,
	@ sp needed	@
	pop	{fp, pc}	@
.L26:
	.align	2
.L25:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.size	main, .-main
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
