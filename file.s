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
	.file	"file.c"
@ GNU C17 (Raspbian 8.3.0-6+rpi1) version 8.3.0 (arm-linux-gnueabihf)
@	compiled by GNU C version 8.3.0, GMP version 6.1.2, MPFR version 4.0.2, MPC version 1.1.0, isl version isl-0.20-GMP

@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib . -imultiarch arm-linux-gnueabihf file.c
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
	.text
	.align	2
	.global	find_event
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	find_event, %function
find_event:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}	@
	add	fp, sp, #4	@,,
	sub	sp, sp, #32	@,,
	str	r0, [fp, #-24]	@ fd, fd
	str	r1, [fp, #-28]	@ prof_start, prof_start
	str	r2, [fp, #-32]	@ locator, locator
@ file.c:10:   int flag = 0;
	mov	r3, #0	@ tmp130,
	str	r3, [fp, #-8]	@ tmp130, flag
@ file.c:11:   int found = 0;
	mov	r3, #0	@ tmp131,
	str	r3, [fp, #-12]	@ tmp131, found
@ file.c:12:   char *buffer = NULL;
	mov	r3, #0	@ tmp132,
	str	r3, [fp, #-16]	@ tmp132, buffer
@ file.c:14:   buffer = malloc(strlen(locator) + 1);
	ldr	r0, [fp, #-32]	@, locator
	bl	strlen		@
	mov	r3, r0	@ _1,
@ file.c:14:   buffer = malloc(strlen(locator) + 1);
	add	r3, r3, #1	@ _2, _1,
	mov	r0, r3	@, _2
	bl	malloc		@
	mov	r3, r0	@ tmp133,
	str	r3, [fp, #-16]	@ tmp133, buffer
@ file.c:15:   if (buffer == NULL)
	ldr	r3, [fp, #-16]	@ tmp134, buffer
	cmp	r3, #0	@ tmp134,
	bne	.L2		@,
@ file.c:17:     perror("memory error");
	ldr	r0, .L10	@,
	bl	perror		@
@ file.c:18:     goto fail;
	nop	
.L3:
@ file.c:50:   free(buffer);
	ldr	r0, [fp, #-16]	@, buffer
	bl	free		@
@ file.c:51:   return -1;
	mvn	r3, #0	@ _25,
	b	.L9		@
.L2:
@ file.c:20:   memset(buffer, 0, strlen(locator));
	ldr	r0, [fp, #-32]	@, locator
	bl	strlen		@
	mov	r3, r0	@ _3,
	mov	r2, r3	@, _3
	mov	r1, #0	@,
	ldr	r0, [fp, #-16]	@, buffer
	bl	memset		@
@ file.c:23:   buffer[strlen(locator)] = '\0';
	ldr	r0, [fp, #-32]	@, locator
	bl	strlen		@
	mov	r2, r0	@ _4,
@ file.c:23:   buffer[strlen(locator)] = '\0';
	ldr	r3, [fp, #-16]	@ tmp135, buffer
	add	r3, r3, r2	@ _5, tmp135, _4
@ file.c:23:   buffer[strlen(locator)] = '\0';
	mov	r2, #0	@ tmp136,
	strb	r2, [r3]	@ tmp137, *_5
.L8:
@ file.c:26:     buffer[flag] = fgetc(fd);
	ldr	r0, [fp, #-24]	@, fd
	bl	fgetc		@
	mov	r1, r0	@ _6,
@ file.c:26:     buffer[flag] = fgetc(fd);
	ldr	r3, [fp, #-8]	@ flag.0_7, flag
	ldr	r2, [fp, #-16]	@ tmp138, buffer
	add	r3, r2, r3	@ _8, tmp138, flag.0_7
@ file.c:26:     buffer[flag] = fgetc(fd);
	uxtb	r2, r1	@ _9, _6
	strb	r2, [r3]	@ tmp139, *_8
@ file.c:27:     if (buffer[flag] == locator[flag])
	ldr	r3, [fp, #-8]	@ flag.1_10, flag
	ldr	r2, [fp, #-16]	@ tmp140, buffer
	add	r3, r2, r3	@ _11, tmp140, flag.1_10
	ldrb	r2, [r3]	@ zero_extendqisi2	@ _12, *_11
@ file.c:27:     if (buffer[flag] == locator[flag])
	ldr	r3, [fp, #-8]	@ flag.2_13, flag
	ldr	r1, [fp, #-32]	@ tmp141, locator
	add	r3, r1, r3	@ _14, tmp141, flag.2_13
	ldrb	r3, [r3]	@ zero_extendqisi2	@ _15, *_14
@ file.c:27:     if (buffer[flag] == locator[flag])
	cmp	r2, r3	@ _12, _15
	bne	.L4		@,
@ file.c:29:       if (flag == strlen(locator) - 1)
	ldr	r0, [fp, #-32]	@, locator
	bl	strlen		@
	mov	r3, r0	@ _16,
@ file.c:29:       if (flag == strlen(locator) - 1)
	sub	r2, r3, #1	@ _17, _16,
@ file.c:29:       if (flag == strlen(locator) - 1)
	ldr	r3, [fp, #-8]	@ flag.3_18, flag
@ file.c:29:       if (flag == strlen(locator) - 1)
	cmp	r2, r3	@ _17, flag.3_18
	bne	.L5		@,
@ file.c:31:         found++;
	ldr	r3, [fp, #-12]	@ tmp143, found
	add	r3, r3, #1	@ tmp142, tmp143,
	str	r3, [fp, #-12]	@ tmp142, found
	b	.L7		@
.L5:
@ file.c:35:         flag++;
	ldr	r3, [fp, #-8]	@ tmp145, flag
	add	r3, r3, #1	@ tmp144, tmp145,
	str	r3, [fp, #-8]	@ tmp144, flag
	b	.L7		@
.L4:
@ file.c:40:       flag = 0;
	mov	r3, #0	@ tmp146,
	str	r3, [fp, #-8]	@ tmp146, flag
.L7:
@ file.c:44:   } while (found < 1);
	ldr	r3, [fp, #-12]	@ tmp147, found
	cmp	r3, #0	@ tmp147,
	ble	.L8		@,
@ file.c:46:   free(buffer);
	ldr	r0, [fp, #-16]	@, buffer
	bl	free		@
@ file.c:47:   return 0;
	mov	r3, #0	@ _25,
.L9:
@ file.c:52: }
	mov	r0, r3	@, <retval>
	sub	sp, fp, #4	@,,
	@ sp needed	@
	pop	{fp, pc}	@
.L11:
	.align	2
.L10:
	.word	.LC0
	.size	find_event, .-find_event
	.section	.rodata
	.align	2
.LC1:
	.ascii	"Segment: \"%s\"\012\000"
	.text
	.align	2
	.global	parse
	.syntax unified
	.arm
	.fpu vfp
	.type	parse, %function
parse:
	@ args = 4, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}	@
	add	fp, sp, #4	@,,
	sub	sp, sp, #32	@,,
	str	r0, [fp, #-24]	@ line, line
	str	r1, [fp, #-28]	@ flag, flag
	str	r2, [fp, #-32]	@ file, file
	str	r3, [fp, #-36]	@ data, data
@ file.c:57:   int ret = 0;
	mov	r3, #0	@ tmp134,
	str	r3, [fp, #-16]	@ tmp134, ret
@ file.c:58:   int i = 0;
	mov	r3, #0	@ tmp135,
	str	r3, [fp, #-8]	@ tmp135, i
@ file.c:59:   char **trimmed = NULL;
	mov	r3, #0	@ tmp136,
	str	r3, [fp, #-20]	@ tmp136, trimmed
@ file.c:61:   if (line == NULL)
	ldr	r3, [fp, #-24]	@ tmp137, line
	cmp	r3, #0	@ tmp137,
	bne	.L13		@,
@ file.c:62:     return 1;
	mov	r3, #1	@ _26,
	b	.L23		@
.L13:
@ file.c:66:   ret = trim(line, &trimmed);
	sub	r3, fp, #20	@ tmp138,,
	mov	r1, r3	@, tmp138
	ldr	r0, [fp, #-24]	@, line
	bl	trim		@
	str	r0, [fp, #-16]	@, ret
@ file.c:67:   if (ret != 0)
	ldr	r3, [fp, #-16]	@ tmp139, ret
	cmp	r3, #0	@ tmp139,
	bne	.L24		@,
@ file.c:70:   while(trimmed[i] != NULL) {
	b	.L17		@
.L18:
@ file.c:71:     printf("Segment: \"%s\"\n", trimmed[i]);
	ldr	r2, [fp, #-20]	@ trimmed.4_1, trimmed
	ldr	r3, [fp, #-8]	@ i.5_2, i
	lsl	r3, r3, #2	@ _3, i.5_2,
	add	r3, r2, r3	@ _4, trimmed.4_1, _3
@ file.c:71:     printf("Segment: \"%s\"\n", trimmed[i]);
	ldr	r3, [r3]	@ _5, *_4
	mov	r1, r3	@, _5
	ldr	r0, .L25	@,
	bl	printf		@
@ file.c:72:     i++;
	ldr	r3, [fp, #-8]	@ tmp141, i
	add	r3, r3, #1	@ tmp140, tmp141,
	str	r3, [fp, #-8]	@ tmp140, i
.L17:
@ file.c:70:   while(trimmed[i] != NULL) {
	ldr	r2, [fp, #-20]	@ trimmed.6_6, trimmed
	ldr	r3, [fp, #-8]	@ i.7_7, i
	lsl	r3, r3, #2	@ _8, i.7_7,
	add	r3, r2, r3	@ _9, trimmed.6_6, _8
	ldr	r3, [r3]	@ _10, *_9
@ file.c:70:   while(trimmed[i] != NULL) {
	cmp	r3, #0	@ _10,
	bne	.L18		@,
@ file.c:75: fail:
	b	.L16		@
.L24:
@ file.c:68:     goto fail;
	nop	
.L16:
@ file.c:76:   for (int j = i-1;j>=0;j--) {
	ldr	r3, [fp, #-8]	@ tmp143, i
	sub	r3, r3, #1	@ tmp142, tmp143,
	str	r3, [fp, #-12]	@ tmp142, j
@ file.c:76:   for (int j = i-1;j>=0;j--) {
	b	.L19		@
.L21:
@ file.c:77: 	if (trimmed[j])
	ldr	r2, [fp, #-20]	@ trimmed.8_11, trimmed
	ldr	r3, [fp, #-12]	@ j.9_12, j
	lsl	r3, r3, #2	@ _13, j.9_12,
	add	r3, r2, r3	@ _14, trimmed.8_11, _13
	ldr	r3, [r3]	@ _15, *_14
@ file.c:77: 	if (trimmed[j])
	cmp	r3, #0	@ _15,
	beq	.L20		@,
@ file.c:78: 		free(trimmed[j]);
	ldr	r2, [fp, #-20]	@ trimmed.10_16, trimmed
	ldr	r3, [fp, #-12]	@ j.11_17, j
	lsl	r3, r3, #2	@ _18, j.11_17,
	add	r3, r2, r3	@ _19, trimmed.10_16, _18
@ file.c:78: 		free(trimmed[j]);
	ldr	r3, [r3]	@ _20, *_19
	mov	r0, r3	@, _20
	bl	free		@
.L20:
@ file.c:76:   for (int j = i-1;j>=0;j--) {
	ldr	r3, [fp, #-12]	@ tmp145, j
	sub	r3, r3, #1	@ tmp144, tmp145,
	str	r3, [fp, #-12]	@ tmp144, j
.L19:
@ file.c:76:   for (int j = i-1;j>=0;j--) {
	ldr	r3, [fp, #-12]	@ tmp146, j
	cmp	r3, #0	@ tmp146,
	bge	.L21		@,
@ file.c:80:   if (trimmed)
	ldr	r3, [fp, #-20]	@ trimmed.12_21, trimmed
@ file.c:80:   if (trimmed)
	cmp	r3, #0	@ trimmed.12_21,
	beq	.L22		@,
@ file.c:81: 	free(trimmed);
	ldr	r3, [fp, #-20]	@ trimmed.13_22, trimmed
	mov	r0, r3	@, trimmed.13_22
	bl	free		@
.L22:
@ file.c:82:   return ret;
	ldr	r3, [fp, #-16]	@ _26, ret
.L23:
@ file.c:83: }
	mov	r0, r3	@, <retval>
	sub	sp, fp, #4	@,,
	@ sp needed	@
	pop	{fp, pc}	@
.L26:
	.align	2
.L25:
	.word	.LC1
	.size	parse, .-parse
	.section	.rodata
	.align	2
.LC2:
	.ascii	", \000\000"
	.text
	.align	2
	.global	trim
	.syntax unified
	.arm
	.fpu vfp
	.type	trim, %function
trim:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, fp, lr}	@
	add	fp, sp, #8	@,,
	sub	sp, sp, #52	@,,
	str	r0, [fp, #-56]	@ line, line
	str	r1, [fp, #-60]	@ trimmed, trimmed
@ file.c:88:   int decr = 0;
	mov	r3, #0	@ tmp184,
	str	r3, [fp, #-48]	@ tmp184, decr
@ file.c:89:   int ret = 0;
	mov	r3, #0	@ tmp185,
	str	r3, [fp, #-16]	@ tmp185, ret
@ file.c:91:   int count = 0;
	mov	r3, #0	@ tmp186,
	str	r3, [fp, #-24]	@ tmp186, count
@ file.c:93:   int offset = 0;
	mov	r3, #0	@ tmp187,
	str	r3, [fp, #-32]	@ tmp187, offset
@ file.c:94:   int len = 0;
	mov	r3, #0	@ tmp188,
	str	r3, [fp, #-40]	@ tmp188, len
@ file.c:95:   char *semitrimmed = NULL;
	mov	r3, #0	@ tmp189,
	str	r3, [fp, #-52]	@ tmp189, semitrimmed
@ file.c:98:   ret = semitrim(line, &semitrimmed, &decr);
	sub	r2, fp, #48	@ tmp190,,
	sub	r3, fp, #52	@ tmp191,,
	mov	r1, r3	@, tmp191
	ldr	r0, [fp, #-56]	@, line
	bl	semitrim		@
	str	r0, [fp, #-16]	@, ret
@ file.c:99:   if (ret != 0)
	ldr	r3, [fp, #-16]	@ tmp192, ret
	cmp	r3, #0	@ tmp192,
	bne	.L47		@,
@ file.c:105:   for (i = 0; i < strlen(semitrimmed); i++)
	mov	r3, #0	@ tmp193,
	str	r3, [fp, #-20]	@ tmp193, i
@ file.c:105:   for (i = 0; i < strlen(semitrimmed); i++)
	b	.L30		@
.L32:
@ file.c:107:     if (semitrimmed[i] == ' ')
	ldr	r2, [fp, #-52]	@ semitrimmed.14_1, semitrimmed
	ldr	r3, [fp, #-20]	@ i.15_2, i
	add	r3, r2, r3	@ _3, semitrimmed.14_1, i.15_2
	ldrb	r3, [r3]	@ zero_extendqisi2	@ _4, *_3
@ file.c:107:     if (semitrimmed[i] == ' ')
	cmp	r3, #32	@ _4,
	bne	.L31		@,
@ file.c:109:       count++;
	ldr	r3, [fp, #-24]	@ tmp195, count
	add	r3, r3, #1	@ tmp194, tmp195,
	str	r3, [fp, #-24]	@ tmp194, count
@ file.c:110:       last = i;
	ldr	r3, [fp, #-20]	@ tmp196, i
	str	r3, [fp, #-28]	@ tmp196, last
.L31:
@ file.c:105:   for (i = 0; i < strlen(semitrimmed); i++)
	ldr	r3, [fp, #-20]	@ tmp198, i
	add	r3, r3, #1	@ tmp197, tmp198,
	str	r3, [fp, #-20]	@ tmp197, i
.L30:
@ file.c:105:   for (i = 0; i < strlen(semitrimmed); i++)
	ldr	r3, [fp, #-52]	@ semitrimmed.16_5, semitrimmed
	mov	r0, r3	@, semitrimmed.16_5
	bl	strlen		@
	mov	r2, r0	@ _6,
@ file.c:105:   for (i = 0; i < strlen(semitrimmed); i++)
	ldr	r3, [fp, #-20]	@ i.17_7, i
@ file.c:105:   for (i = 0; i < strlen(semitrimmed); i++)
	cmp	r2, r3	@ _6, i.17_7
	bhi	.L32		@,
@ file.c:114:   if (count != 0)
	ldr	r3, [fp, #-24]	@ tmp199, count
	cmp	r3, #0	@ tmp199,
	beq	.L33		@,
@ file.c:116:     if (semitrimmed[last + 1] != '\0')
	ldr	r2, [fp, #-52]	@ semitrimmed.18_8, semitrimmed
	ldr	r3, [fp, #-28]	@ last.19_9, last
	add	r3, r3, #1	@ _10, last.19_9,
	add	r3, r2, r3	@ _11, semitrimmed.18_8, _10
	ldrb	r3, [r3]	@ zero_extendqisi2	@ _12, *_11
@ file.c:116:     if (semitrimmed[last + 1] != '\0')
	cmp	r3, #0	@ _12,
	beq	.L35		@,
@ file.c:117:       count++;
	ldr	r3, [fp, #-24]	@ tmp201, count
	add	r3, r3, #1	@ tmp200, tmp201,
	str	r3, [fp, #-24]	@ tmp200, count
	b	.L35		@
.L33:
@ file.c:119:   else if (count == 0)
	ldr	r3, [fp, #-24]	@ tmp202, count
	cmp	r3, #0	@ tmp202,
	bne	.L35		@,
@ file.c:120:     count++;
	ldr	r3, [fp, #-24]	@ tmp204, count
	add	r3, r3, #1	@ tmp203, tmp204,
	str	r3, [fp, #-24]	@ tmp203, count
.L35:
@ file.c:125:   *trimmed = (char **)malloc((count + 1) * sizeof(char *));
	ldr	r3, [fp, #-24]	@ tmp205, count
	add	r3, r3, #1	@ _13, tmp205,
@ file.c:125:   *trimmed = (char **)malloc((count + 1) * sizeof(char *));
	lsl	r3, r3, #2	@ _15, _14,
	mov	r0, r3	@, _15
	bl	malloc		@
	mov	r3, r0	@ tmp206,
	mov	r2, r3	@ _16, tmp206
@ file.c:125:   *trimmed = (char **)malloc((count + 1) * sizeof(char *));
	ldr	r3, [fp, #-60]	@ tmp207, trimmed
	str	r2, [r3]	@ _16, *trimmed_108(D)
@ file.c:126:   if (trimmed == NULL)
	ldr	r3, [fp, #-60]	@ tmp208, trimmed
	cmp	r3, #0	@ tmp208,
	bne	.L36		@,
@ file.c:128:     perror("memory error");
	ldr	r0, .L48	@,
	bl	perror		@
@ file.c:129:     ret = -1;
	mvn	r3, #0	@ tmp209,
	str	r3, [fp, #-16]	@ tmp209, ret
@ file.c:130:     goto fail;
	b	.L29		@
.L36:
@ file.c:132:   for (i = 0; i < count; i++)
	mov	r3, #0	@ tmp210,
	str	r3, [fp, #-20]	@ tmp210, i
@ file.c:132:   for (i = 0; i < count; i++)
	b	.L37		@
.L39:
@ file.c:134:     (*trimmed)[i] = (char *)malloc(32 + 1);
	ldr	r3, [fp, #-60]	@ tmp211, trimmed
	ldr	r2, [r3]	@ _17, *trimmed_108(D)
@ file.c:134:     (*trimmed)[i] = (char *)malloc(32 + 1);
	ldr	r3, [fp, #-20]	@ i.20_18, i
	lsl	r3, r3, #2	@ _19, i.20_18,
	add	r4, r2, r3	@ _20, _17, _19
@ file.c:134:     (*trimmed)[i] = (char *)malloc(32 + 1);
	mov	r0, #33	@,
	bl	malloc		@
	mov	r3, r0	@ tmp212,
@ file.c:134:     (*trimmed)[i] = (char *)malloc(32 + 1);
	str	r3, [r4]	@ _21, *_20
@ file.c:135:     if ((*trimmed)[i] == NULL)
	ldr	r3, [fp, #-60]	@ tmp213, trimmed
	ldr	r2, [r3]	@ _22, *trimmed_108(D)
@ file.c:135:     if ((*trimmed)[i] == NULL)
	ldr	r3, [fp, #-20]	@ i.21_23, i
	lsl	r3, r3, #2	@ _24, i.21_23,
	add	r3, r2, r3	@ _25, _22, _24
	ldr	r3, [r3]	@ _26, *_25
@ file.c:135:     if ((*trimmed)[i] == NULL)
	cmp	r3, #0	@ _26,
	bne	.L38		@,
@ file.c:137:       perror("memory error");
	ldr	r0, .L48	@,
	bl	perror		@
@ file.c:138:       ret = -1;
	mvn	r3, #0	@ tmp214,
	str	r3, [fp, #-16]	@ tmp214, ret
@ file.c:139:       goto fail;
	b	.L29		@
.L38:
@ file.c:141:     memset((*trimmed)[i], 0, 32);
	ldr	r3, [fp, #-60]	@ tmp215, trimmed
	ldr	r2, [r3]	@ _27, *trimmed_108(D)
@ file.c:141:     memset((*trimmed)[i], 0, 32);
	ldr	r3, [fp, #-20]	@ i.22_28, i
	lsl	r3, r3, #2	@ _29, i.22_28,
	add	r3, r2, r3	@ _30, _27, _29
@ file.c:141:     memset((*trimmed)[i], 0, 32);
	ldr	r3, [r3]	@ _31, *_30
	mov	r2, #32	@,
	mov	r1, #0	@,
	mov	r0, r3	@, _31
	bl	memset		@
@ file.c:132:   for (i = 0; i < count; i++)
	ldr	r3, [fp, #-20]	@ tmp217, i
	add	r3, r3, #1	@ tmp216, tmp217,
	str	r3, [fp, #-20]	@ tmp216, i
.L37:
@ file.c:132:   for (i = 0; i < count; i++)
	ldr	r2, [fp, #-20]	@ tmp218, i
	ldr	r3, [fp, #-24]	@ tmp219, count
	cmp	r2, r3	@ tmp218, tmp219
	blt	.L39		@,
@ file.c:143:   (*trimmed)[count] = NULL;
	ldr	r3, [fp, #-60]	@ tmp220, trimmed
	ldr	r2, [r3]	@ _32, *trimmed_108(D)
@ file.c:143:   (*trimmed)[count] = NULL;
	ldr	r3, [fp, #-24]	@ count.23_33, count
	lsl	r3, r3, #2	@ _34, count.23_33,
	add	r3, r2, r3	@ _35, _32, _34
@ file.c:143:   (*trimmed)[count] = NULL;
	mov	r2, #0	@ tmp221,
	str	r2, [r3]	@ tmp221, *_35
@ file.c:146:   for (int j = 0; j < count; j++)
	mov	r3, #0	@ tmp222,
	str	r3, [fp, #-36]	@ tmp222, j
@ file.c:146:   for (int j = 0; j < count; j++)
	b	.L40		@
.L44:
@ file.c:149:     jump = strcspn((semitrimmed) + offset, ", \0");
	ldr	r2, [fp, #-52]	@ semitrimmed.24_36, semitrimmed
	ldr	r3, [fp, #-32]	@ offset.25_37, offset
@ file.c:149:     jump = strcspn((semitrimmed) + offset, ", \0");
	add	r3, r2, r3	@ _38, semitrimmed.24_36, offset.25_37
@ file.c:149:     jump = strcspn((semitrimmed) + offset, ", \0");
	ldr	r1, .L48+4	@,
	mov	r0, r3	@, _38
	bl	strcspn		@
	mov	r3, r0	@ _39,
@ file.c:149:     jump = strcspn((semitrimmed) + offset, ", \0");
	str	r3, [fp, #-44]	@ _39, jump
@ file.c:153:     if (((semitrimmed) + offset)[0] != '\0')
	ldr	r2, [fp, #-52]	@ semitrimmed.26_40, semitrimmed
	ldr	r3, [fp, #-32]	@ offset.27_41, offset
	add	r3, r2, r3	@ _42, semitrimmed.26_40, offset.27_41
	ldrb	r3, [r3]	@ zero_extendqisi2	@ _43, *_42
@ file.c:153:     if (((semitrimmed) + offset)[0] != '\0')
	cmp	r3, #0	@ _43,
	beq	.L41		@,
@ file.c:156:       strncpy((*trimmed)[j], (semitrimmed) + offset, jump);
	ldr	r3, [fp, #-60]	@ tmp223, trimmed
	ldr	r2, [r3]	@ _44, *trimmed_108(D)
@ file.c:156:       strncpy((*trimmed)[j], (semitrimmed) + offset, jump);
	ldr	r3, [fp, #-36]	@ j.28_45, j
	lsl	r3, r3, #2	@ _46, j.28_45,
	add	r3, r2, r3	@ _47, _44, _46
@ file.c:156:       strncpy((*trimmed)[j], (semitrimmed) + offset, jump);
	ldr	r0, [r3]	@ _48, *_47
	ldr	r2, [fp, #-52]	@ semitrimmed.29_49, semitrimmed
	ldr	r3, [fp, #-32]	@ offset.30_50, offset
@ file.c:156:       strncpy((*trimmed)[j], (semitrimmed) + offset, jump);
	add	r3, r2, r3	@ _51, semitrimmed.29_49, offset.30_50
@ file.c:156:       strncpy((*trimmed)[j], (semitrimmed) + offset, jump);
	ldr	r2, [fp, #-44]	@ jump.31_52, jump
	mov	r1, r3	@, _51
	bl	strncpy		@
.L41:
@ file.c:162:     len = strlen((*trimmed)[j]);
	ldr	r3, [fp, #-60]	@ tmp224, trimmed
	ldr	r2, [r3]	@ _53, *trimmed_108(D)
@ file.c:162:     len = strlen((*trimmed)[j]);
	ldr	r3, [fp, #-36]	@ j.32_54, j
	lsl	r3, r3, #2	@ _55, j.32_54,
	add	r3, r2, r3	@ _56, _53, _55
@ file.c:162:     len = strlen((*trimmed)[j]);
	ldr	r3, [r3]	@ _57, *_56
	mov	r0, r3	@, _57
	bl	strlen		@
	mov	r3, r0	@ _58,
@ file.c:162:     len = strlen((*trimmed)[j]);
	str	r3, [fp, #-40]	@ _58, len
@ file.c:163:     if (semitrimmed[jump + offset] == ' ')
	ldr	r3, [fp, #-52]	@ semitrimmed.33_59, semitrimmed
@ file.c:163:     if (semitrimmed[jump + offset] == ' ')
	ldr	r1, [fp, #-44]	@ tmp225, jump
	ldr	r2, [fp, #-32]	@ tmp226, offset
	add	r2, r1, r2	@ _60, tmp225, tmp226
@ file.c:163:     if (semitrimmed[jump + offset] == ' ')
	add	r3, r3, r2	@ _62, semitrimmed.33_59, _61
	ldrb	r3, [r3]	@ zero_extendqisi2	@ _63, *_62
@ file.c:163:     if (semitrimmed[jump + offset] == ' ')
	cmp	r3, #32	@ _63,
	bne	.L42		@,
@ file.c:164:       offset = offset + len + 1;
	ldr	r2, [fp, #-32]	@ tmp227, offset
	ldr	r3, [fp, #-40]	@ tmp228, len
	add	r3, r2, r3	@ _64, tmp227, tmp228
@ file.c:164:       offset = offset + len + 1;
	add	r3, r3, #1	@ tmp229, _64,
	str	r3, [fp, #-32]	@ tmp229, offset
	b	.L43		@
.L42:
@ file.c:166:       offset = offset + len + 2;
	ldr	r2, [fp, #-32]	@ tmp230, offset
	ldr	r3, [fp, #-40]	@ tmp231, len
	add	r3, r2, r3	@ _65, tmp230, tmp231
@ file.c:166:       offset = offset + len + 2;
	add	r3, r3, #2	@ tmp232, _65,
	str	r3, [fp, #-32]	@ tmp232, offset
.L43:
@ file.c:146:   for (int j = 0; j < count; j++)
	ldr	r3, [fp, #-36]	@ tmp234, j
	add	r3, r3, #1	@ tmp233, tmp234,
	str	r3, [fp, #-36]	@ tmp233, j
.L40:
@ file.c:146:   for (int j = 0; j < count; j++)
	ldr	r2, [fp, #-36]	@ tmp235, j
	ldr	r3, [fp, #-24]	@ tmp236, count
	cmp	r2, r3	@ tmp235, tmp236
	blt	.L44		@,
@ file.c:169: fail:
	b	.L29		@
.L47:
@ file.c:100:     goto fail;
	nop	
.L29:
@ file.c:170:   if (semitrimmed)
	ldr	r3, [fp, #-52]	@ semitrimmed.34_66, semitrimmed
@ file.c:170:   if (semitrimmed)
	cmp	r3, #0	@ semitrimmed.34_66,
	beq	.L45		@,
@ file.c:171:     free(semitrimmed -= decr);
	ldr	r2, [fp, #-52]	@ semitrimmed.35_67, semitrimmed
	ldr	r3, [fp, #-48]	@ decr.36_68, decr
	rsb	r3, r3, #0	@ _70, decr.37_69
	add	r3, r2, r3	@ _71, semitrimmed.35_67, _70
	str	r3, [fp, #-52]	@ _71, semitrimmed
@ file.c:171:     free(semitrimmed -= decr);
	ldr	r3, [fp, #-52]	@ semitrimmed.38_72, semitrimmed
	mov	r0, r3	@, semitrimmed.38_72
	bl	free		@
.L45:
@ file.c:172:   return ret;
	ldr	r3, [fp, #-16]	@ _129, ret
@ file.c:173: }
	mov	r0, r3	@, <retval>
	sub	sp, fp, #8	@,,
	@ sp needed	@
	pop	{r4, fp, pc}	@
.L49:
	.align	2
.L48:
	.word	.LC0
	.word	.LC2
	.size	trim, .-trim
	.section	.rodata
	.align	2
.LC3:
	.ascii	"\012#\000"
	.text
	.align	2
	.global	semitrim
	.syntax unified
	.arm
	.fpu vfp
	.type	semitrim, %function
semitrim:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}	@
	add	fp, sp, #4	@,,
	sub	sp, sp, #32	@,,
	str	r0, [fp, #-24]	@ line, line
	str	r1, [fp, #-28]	@ semitrimmed, semitrimmed
	str	r2, [fp, #-32]	@ count, count
@ file.c:177:   int ret = 0;
	mov	r3, #0	@ tmp164,
	str	r3, [fp, #-8]	@ tmp164, ret
@ file.c:179:   size_t size = strcspn(line, "\n#");
	ldr	r1, .L63	@,
	ldr	r0, [fp, #-24]	@, line
	bl	strcspn		@
	str	r0, [fp, #-12]	@, size
@ file.c:181:   (*semitrimmed) = malloc((size + 1) * sizeof(char));
	ldr	r3, [fp, #-12]	@ tmp165, size
	add	r3, r3, #1	@ _1, tmp165,
	mov	r0, r3	@, _1
	bl	malloc		@
	mov	r3, r0	@ tmp166,
	mov	r2, r3	@ _2, tmp166
@ file.c:181:   (*semitrimmed) = malloc((size + 1) * sizeof(char));
	ldr	r3, [fp, #-28]	@ tmp167, semitrimmed
	str	r2, [r3]	@ _2, *semitrimmed_66(D)
@ file.c:182:   if (semitrimmed == NULL)
	ldr	r3, [fp, #-28]	@ tmp168, semitrimmed
	cmp	r3, #0	@ tmp168,
	bne	.L51		@,
@ file.c:184:     perror("memory error");
	ldr	r0, .L63+4	@,
	bl	perror		@
@ file.c:185:     ret = -1;
	mvn	r3, #0	@ tmp169,
	str	r3, [fp, #-8]	@ tmp169, ret
@ file.c:186:     goto fail;
	b	.L52		@
.L51:
@ file.c:189:   line[size] = '\0';
	ldr	r2, [fp, #-24]	@ tmp170, line
	ldr	r3, [fp, #-12]	@ tmp171, size
	add	r3, r2, r3	@ _3, tmp170, tmp171
@ file.c:189:   line[size] = '\0';
	mov	r2, #0	@ tmp172,
	strb	r2, [r3]	@ tmp173, *_3
@ file.c:193:   strncpy((*semitrimmed), line, size + 1);
	ldr	r3, [fp, #-28]	@ tmp174, semitrimmed
	ldr	r0, [r3]	@ _4, *semitrimmed_66(D)
	ldr	r3, [fp, #-12]	@ tmp175, size
	add	r3, r3, #1	@ _5, tmp175,
	mov	r2, r3	@, _5
	ldr	r1, [fp, #-24]	@, line
	bl	strncpy		@
@ file.c:195:   if (size == 0)
	ldr	r3, [fp, #-12]	@ tmp176, size
	cmp	r3, #0	@ tmp176,
	bne	.L53		@,
@ file.c:197:     ret = -1;
	mvn	r3, #0	@ tmp177,
	str	r3, [fp, #-8]	@ tmp177, ret
@ file.c:198:     goto fail;
	b	.L52		@
.L53:
@ file.c:202:   for (int i = 0; i < size; i++)
	mov	r3, #0	@ tmp178,
	str	r3, [fp, #-16]	@ tmp178, i
@ file.c:202:   for (int i = 0; i < size; i++)
	b	.L54		@
.L56:
@ file.c:204:     if (isspace((*semitrimmed)[i]))
	bl	__ctype_b_loc		@
	mov	r3, r0	@ _6,
	ldr	r2, [r3]	@ _7, *_6
	ldr	r3, [fp, #-28]	@ tmp179, semitrimmed
	ldr	r1, [r3]	@ _8, *semitrimmed_66(D)
	ldr	r3, [fp, #-16]	@ i.39_9, i
	add	r3, r1, r3	@ _10, _8, i.39_9
	ldrb	r3, [r3]	@ zero_extendqisi2	@ _11, *_10
	lsl	r3, r3, #1	@ _13, _12,
	add	r3, r2, r3	@ _14, _7, _13
	ldrh	r3, [r3]	@ _15, *_14
	and	r3, r3, #8192	@ _17, _16,
@ file.c:204:     if (isspace((*semitrimmed)[i]))
	cmp	r3, #0	@ _17,
	beq	.L55		@,
@ file.c:206:       (*semitrimmed)[i] = ' ';
	ldr	r3, [fp, #-28]	@ tmp180, semitrimmed
	ldr	r2, [r3]	@ _18, *semitrimmed_66(D)
@ file.c:206:       (*semitrimmed)[i] = ' ';
	ldr	r3, [fp, #-16]	@ i.40_19, i
	add	r3, r2, r3	@ _20, _18, i.40_19
@ file.c:206:       (*semitrimmed)[i] = ' ';
	mov	r2, #32	@ tmp181,
	strb	r2, [r3]	@ tmp182, *_20
.L55:
@ file.c:202:   for (int i = 0; i < size; i++)
	ldr	r3, [fp, #-16]	@ tmp184, i
	add	r3, r3, #1	@ tmp183, tmp184,
	str	r3, [fp, #-16]	@ tmp183, i
.L54:
@ file.c:202:   for (int i = 0; i < size; i++)
	ldr	r3, [fp, #-16]	@ i.41_21, i
@ file.c:202:   for (int i = 0; i < size; i++)
	ldr	r2, [fp, #-12]	@ tmp185, size
	cmp	r2, r3	@ tmp185, i.41_21
	bhi	.L56		@,
@ file.c:211:   while (isspace((*semitrimmed)[0]))
	b	.L57		@
.L58:
@ file.c:213:     (*semitrimmed)++;
	ldr	r3, [fp, #-28]	@ tmp186, semitrimmed
	ldr	r3, [r3]	@ _22, *semitrimmed_66(D)
@ file.c:213:     (*semitrimmed)++;
	add	r2, r3, #1	@ _23, _22,
	ldr	r3, [fp, #-28]	@ tmp187, semitrimmed
	str	r2, [r3]	@ _23, *semitrimmed_66(D)
@ file.c:214:     (*count)++;
	ldr	r3, [fp, #-32]	@ tmp188, count
	ldr	r3, [r3]	@ _24, *count_77(D)
@ file.c:214:     (*count)++;
	add	r2, r3, #1	@ _25, _24,
	ldr	r3, [fp, #-32]	@ tmp189, count
	str	r2, [r3]	@ _25, *count_77(D)
.L57:
@ file.c:211:   while (isspace((*semitrimmed)[0]))
	bl	__ctype_b_loc		@
	mov	r3, r0	@ _26,
	ldr	r2, [r3]	@ _27, *_26
	ldr	r3, [fp, #-28]	@ tmp190, semitrimmed
	ldr	r3, [r3]	@ _28, *semitrimmed_66(D)
	ldrb	r3, [r3]	@ zero_extendqisi2	@ _29, *_28
	lsl	r3, r3, #1	@ _31, _30,
	add	r3, r2, r3	@ _32, _27, _31
	ldrh	r3, [r3]	@ _33, *_32
	and	r3, r3, #8192	@ _35, _34,
@ file.c:211:   while (isspace((*semitrimmed)[0]))
	cmp	r3, #0	@ _35,
	bne	.L58		@,
@ file.c:217:   if ((*semitrimmed)[0] == '\0')
	ldr	r3, [fp, #-28]	@ tmp191, semitrimmed
	ldr	r3, [r3]	@ _36, *semitrimmed_66(D)
@ file.c:217:   if ((*semitrimmed)[0] == '\0')
	ldrb	r3, [r3]	@ zero_extendqisi2	@ _37, *_36
@ file.c:217:   if ((*semitrimmed)[0] == '\0')
	cmp	r3, #0	@ _37,
	bne	.L60		@,
@ file.c:219:     ret = -1;
	mvn	r3, #0	@ tmp192,
	str	r3, [fp, #-8]	@ tmp192, ret
@ file.c:220:     goto fail;
	b	.L52		@
.L61:
@ file.c:225:     (*semitrimmed)[size - 2] = '\0';
	ldr	r3, [fp, #-28]	@ tmp193, semitrimmed
	ldr	r2, [r3]	@ _38, *semitrimmed_66(D)
@ file.c:225:     (*semitrimmed)[size - 2] = '\0';
	ldr	r3, [fp, #-12]	@ tmp194, size
	sub	r3, r3, #2	@ _39, tmp194,
	add	r3, r2, r3	@ _40, _38, _39
@ file.c:225:     (*semitrimmed)[size - 2] = '\0';
	mov	r2, #0	@ tmp195,
	strb	r2, [r3]	@ tmp196, *_40
@ file.c:226:     size--;
	ldr	r3, [fp, #-12]	@ tmp198, size
	sub	r3, r3, #1	@ tmp197, tmp198,
	str	r3, [fp, #-12]	@ tmp197, size
.L60:
@ file.c:223:   while (isspace((*semitrimmed)[size - 2]))
	bl	__ctype_b_loc		@
	mov	r3, r0	@ _41,
	ldr	r2, [r3]	@ _42, *_41
	ldr	r3, [fp, #-28]	@ tmp199, semitrimmed
	ldr	r1, [r3]	@ _43, *semitrimmed_66(D)
	ldr	r3, [fp, #-12]	@ tmp200, size
	sub	r3, r3, #2	@ _44, tmp200,
	add	r3, r1, r3	@ _45, _43, _44
	ldrb	r3, [r3]	@ zero_extendqisi2	@ _46, *_45
	lsl	r3, r3, #1	@ _48, _47,
	add	r3, r2, r3	@ _49, _42, _48
	ldrh	r3, [r3]	@ _50, *_49
	and	r3, r3, #8192	@ _52, _51,
@ file.c:223:   while (isspace((*semitrimmed)[size - 2]))
	cmp	r3, #0	@ _52,
	bne	.L61		@,
@ file.c:230: fail:
	nop	
.L52:
@ file.c:231:   return ret;
	ldr	r3, [fp, #-8]	@ _82, ret
@ file.c:232: }
	mov	r0, r3	@, <retval>
	sub	sp, fp, #4	@,,
	@ sp needed	@
	pop	{fp, pc}	@
.L64:
	.align	2
.L63:
	.word	.LC3
	.word	.LC0
	.size	semitrim, .-semitrim
	.section	.rodata
	.align	2
.LC4:
	.ascii	"zero\000"
	.align	2
.LC5:
	.ascii	"00000\000"
	.align	2
.LC6:
	.ascii	"at\000"
	.align	2
.LC7:
	.ascii	"00001\000"
	.align	2
.LC8:
	.ascii	"v0\000"
	.align	2
.LC9:
	.ascii	"00010\000"
	.align	2
.LC10:
	.ascii	"v1\000"
	.align	2
.LC11:
	.ascii	"00011\000"
	.align	2
.LC12:
	.ascii	"a0\000"
	.align	2
.LC13:
	.ascii	"00100\000"
	.align	2
.LC14:
	.ascii	"a1\000"
	.align	2
.LC15:
	.ascii	"00101\000"
	.align	2
.LC16:
	.ascii	"a2\000"
	.align	2
.LC17:
	.ascii	"00110\000"
	.align	2
.LC18:
	.ascii	"a3\000"
	.align	2
.LC19:
	.ascii	"00111\000"
	.align	2
.LC20:
	.ascii	"t0\000"
	.align	2
.LC21:
	.ascii	"01000\000"
	.align	2
.LC22:
	.ascii	"t1\000"
	.align	2
.LC23:
	.ascii	"01001\000"
	.align	2
.LC24:
	.ascii	"t2\000"
	.align	2
.LC25:
	.ascii	"01010\000"
	.align	2
.LC26:
	.ascii	"t3\000"
	.align	2
.LC27:
	.ascii	"01011\000"
	.align	2
.LC28:
	.ascii	"t4\000"
	.align	2
.LC29:
	.ascii	"01100\000"
	.align	2
.LC30:
	.ascii	"t5\000"
	.align	2
.LC31:
	.ascii	"01101\000"
	.align	2
.LC32:
	.ascii	"t6\000"
	.align	2
.LC33:
	.ascii	"01110\000"
	.align	2
.LC34:
	.ascii	"t7\000"
	.align	2
.LC35:
	.ascii	"01111\000"
	.align	2
.LC36:
	.ascii	"s0\000"
	.align	2
.LC37:
	.ascii	"10000\000"
	.align	2
.LC38:
	.ascii	"s1\000"
	.align	2
.LC39:
	.ascii	"10001\000"
	.align	2
.LC40:
	.ascii	"s2\000"
	.align	2
.LC41:
	.ascii	"10010\000"
	.align	2
.LC42:
	.ascii	"s3\000"
	.align	2
.LC43:
	.ascii	"10011\000"
	.align	2
.LC44:
	.ascii	"s4\000"
	.align	2
.LC45:
	.ascii	"10100\000"
	.align	2
.LC46:
	.ascii	"s5\000"
	.align	2
.LC47:
	.ascii	"10101\000"
	.align	2
.LC48:
	.ascii	"s6\000"
	.align	2
.LC49:
	.ascii	"10110\000"
	.align	2
.LC50:
	.ascii	"s7\000"
	.align	2
.LC51:
	.ascii	"10111\000"
	.align	2
.LC52:
	.ascii	"t8\000"
	.align	2
.LC53:
	.ascii	"11000\000"
	.align	2
.LC54:
	.ascii	"t9\000"
	.align	2
.LC55:
	.ascii	"11001\000"
	.align	2
.LC56:
	.ascii	"k0\000"
	.align	2
.LC57:
	.ascii	"11010\000"
	.align	2
.LC58:
	.ascii	"k1\000"
	.align	2
.LC59:
	.ascii	"11011\000"
	.align	2
.LC60:
	.ascii	"gp\000"
	.align	2
.LC61:
	.ascii	"11100\000"
	.align	2
.LC62:
	.ascii	"sp\000"
	.align	2
.LC63:
	.ascii	"11101\000"
	.align	2
.LC64:
	.ascii	"fp\000"
	.align	2
.LC65:
	.ascii	"11110\000"
	.align	2
.LC66:
	.ascii	"ra\000"
	.align	2
.LC67:
	.ascii	"11111\000"
	.text
	.align	2
	.global	reg_lookup
	.syntax unified
	.arm
	.fpu vfp
	.type	reg_lookup, %function
reg_lookup:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}	@
	add	fp, sp, #4	@,,
	sub	sp, sp, #16	@,,
	str	r0, [fp, #-16]	@ name, name
@ file.c:236:   char *reg = NULL;
	mov	r3, #0	@ tmp144,
	str	r3, [fp, #-8]	@ tmp144, reg
@ file.c:237:   reg = malloc(5 * sizeof(char));
	mov	r0, #5	@,
	bl	malloc		@
	mov	r3, r0	@ tmp145,
	str	r3, [fp, #-8]	@ tmp145, reg
@ file.c:239:   if (strcmp(name, "zero") == 0)
	ldr	r1, .L100	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _1,
@ file.c:239:   if (strcmp(name, "zero") == 0)
	cmp	r3, #0	@ _1,
	bne	.L66		@,
@ file.c:240:     reg = zero;
	ldr	r3, .L100+4	@ tmp146,
	str	r3, [fp, #-8]	@ tmp146, reg
	b	.L67		@
.L66:
@ file.c:241:   else if (strcmp(name, "at") == 0)
	ldr	r1, .L100+8	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _2,
@ file.c:241:   else if (strcmp(name, "at") == 0)
	cmp	r3, #0	@ _2,
	bne	.L68		@,
@ file.c:242:     reg = at;
	ldr	r3, .L100+12	@ tmp147,
	str	r3, [fp, #-8]	@ tmp147, reg
	b	.L67		@
.L68:
@ file.c:243:   else if (strcmp(name, "v0") == 0)
	ldr	r1, .L100+16	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _3,
@ file.c:243:   else if (strcmp(name, "v0") == 0)
	cmp	r3, #0	@ _3,
	bne	.L69		@,
@ file.c:244:     reg = v0;
	ldr	r3, .L100+20	@ tmp148,
	str	r3, [fp, #-8]	@ tmp148, reg
	b	.L67		@
.L69:
@ file.c:245:   else if (strcmp(name, "v1") == 0)
	ldr	r1, .L100+24	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _4,
@ file.c:245:   else if (strcmp(name, "v1") == 0)
	cmp	r3, #0	@ _4,
	bne	.L70		@,
@ file.c:246:     reg = v1;
	ldr	r3, .L100+28	@ tmp149,
	str	r3, [fp, #-8]	@ tmp149, reg
	b	.L67		@
.L70:
@ file.c:247:   else if (strcmp(name, "a0") == 0)
	ldr	r1, .L100+32	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _5,
@ file.c:247:   else if (strcmp(name, "a0") == 0)
	cmp	r3, #0	@ _5,
	bne	.L71		@,
@ file.c:248:     reg = a0;
	ldr	r3, .L100+36	@ tmp150,
	str	r3, [fp, #-8]	@ tmp150, reg
	b	.L67		@
.L71:
@ file.c:249:   else if (strcmp(name, "a1") == 0)
	ldr	r1, .L100+40	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _6,
@ file.c:249:   else if (strcmp(name, "a1") == 0)
	cmp	r3, #0	@ _6,
	bne	.L72		@,
@ file.c:250:     reg = a1;
	ldr	r3, .L100+44	@ tmp151,
	str	r3, [fp, #-8]	@ tmp151, reg
	b	.L67		@
.L72:
@ file.c:251:   else if (strcmp(name, "a2") == 0)
	ldr	r1, .L100+48	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _7,
@ file.c:251:   else if (strcmp(name, "a2") == 0)
	cmp	r3, #0	@ _7,
	bne	.L73		@,
@ file.c:252:     reg = a2;
	ldr	r3, .L100+52	@ tmp152,
	str	r3, [fp, #-8]	@ tmp152, reg
	b	.L67		@
.L73:
@ file.c:253:   else if (strcmp(name, "a3") == 0)
	ldr	r1, .L100+56	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _8,
@ file.c:253:   else if (strcmp(name, "a3") == 0)
	cmp	r3, #0	@ _8,
	bne	.L74		@,
@ file.c:254:     reg = a3;
	ldr	r3, .L100+60	@ tmp153,
	str	r3, [fp, #-8]	@ tmp153, reg
	b	.L67		@
.L74:
@ file.c:255:   else if (strcmp(name, "t0") == 0)
	ldr	r1, .L100+64	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _9,
@ file.c:255:   else if (strcmp(name, "t0") == 0)
	cmp	r3, #0	@ _9,
	bne	.L75		@,
@ file.c:256:     reg = t0;
	ldr	r3, .L100+68	@ tmp154,
	str	r3, [fp, #-8]	@ tmp154, reg
	b	.L67		@
.L75:
@ file.c:257:   else if (strcmp(name, "t1") == 0)
	ldr	r1, .L100+72	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _10,
@ file.c:257:   else if (strcmp(name, "t1") == 0)
	cmp	r3, #0	@ _10,
	bne	.L76		@,
@ file.c:258:     reg = t1;
	ldr	r3, .L100+76	@ tmp155,
	str	r3, [fp, #-8]	@ tmp155, reg
	b	.L67		@
.L76:
@ file.c:259:   else if (strcmp(name, "t2") == 0)
	ldr	r1, .L100+80	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _11,
@ file.c:259:   else if (strcmp(name, "t2") == 0)
	cmp	r3, #0	@ _11,
	bne	.L77		@,
@ file.c:260:     reg = t2;
	ldr	r3, .L100+84	@ tmp156,
	str	r3, [fp, #-8]	@ tmp156, reg
	b	.L67		@
.L77:
@ file.c:261:   else if (strcmp(name, "t3") == 0)
	ldr	r1, .L100+88	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _12,
@ file.c:261:   else if (strcmp(name, "t3") == 0)
	cmp	r3, #0	@ _12,
	bne	.L78		@,
@ file.c:262:     reg = t3;
	ldr	r3, .L100+92	@ tmp157,
	str	r3, [fp, #-8]	@ tmp157, reg
	b	.L67		@
.L78:
@ file.c:263:   else if (strcmp(name, "t4") == 0)
	ldr	r1, .L100+96	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _13,
@ file.c:263:   else if (strcmp(name, "t4") == 0)
	cmp	r3, #0	@ _13,
	bne	.L79		@,
@ file.c:264:     reg = t4;
	ldr	r3, .L100+100	@ tmp158,
	str	r3, [fp, #-8]	@ tmp158, reg
	b	.L67		@
.L79:
@ file.c:265:   else if (strcmp(name, "t5") == 0)
	ldr	r1, .L100+104	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _14,
@ file.c:265:   else if (strcmp(name, "t5") == 0)
	cmp	r3, #0	@ _14,
	bne	.L80		@,
@ file.c:266:     reg = t5;
	ldr	r3, .L100+108	@ tmp159,
	str	r3, [fp, #-8]	@ tmp159, reg
	b	.L67		@
.L80:
@ file.c:267:   else if (strcmp(name, "t6") == 0)
	ldr	r1, .L100+112	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _15,
@ file.c:267:   else if (strcmp(name, "t6") == 0)
	cmp	r3, #0	@ _15,
	bne	.L81		@,
@ file.c:268:     reg = t6;
	ldr	r3, .L100+116	@ tmp160,
	str	r3, [fp, #-8]	@ tmp160, reg
	b	.L67		@
.L81:
@ file.c:269:   else if (strcmp(name, "t7") == 0)
	ldr	r1, .L100+120	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _16,
@ file.c:269:   else if (strcmp(name, "t7") == 0)
	cmp	r3, #0	@ _16,
	bne	.L82		@,
@ file.c:270:     reg = t7;
	ldr	r3, .L100+124	@ tmp161,
	str	r3, [fp, #-8]	@ tmp161, reg
	b	.L67		@
.L82:
@ file.c:271:   else if (strcmp(name, "s0") == 0)
	ldr	r1, .L100+128	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _17,
@ file.c:271:   else if (strcmp(name, "s0") == 0)
	cmp	r3, #0	@ _17,
	bne	.L83		@,
@ file.c:272:     reg = s0;
	ldr	r3, .L100+132	@ tmp162,
	str	r3, [fp, #-8]	@ tmp162, reg
	b	.L67		@
.L83:
@ file.c:273:   else if (strcmp(name, "s1") == 0)
	ldr	r1, .L100+136	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _18,
@ file.c:273:   else if (strcmp(name, "s1") == 0)
	cmp	r3, #0	@ _18,
	bne	.L84		@,
@ file.c:274:     reg = s1;
	ldr	r3, .L100+140	@ tmp163,
	str	r3, [fp, #-8]	@ tmp163, reg
	b	.L67		@
.L84:
@ file.c:275:   else if (strcmp(name, "s2") == 0)
	ldr	r1, .L100+144	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _19,
@ file.c:275:   else if (strcmp(name, "s2") == 0)
	cmp	r3, #0	@ _19,
	bne	.L85		@,
@ file.c:276:     reg = s2;
	ldr	r3, .L100+148	@ tmp164,
	str	r3, [fp, #-8]	@ tmp164, reg
	b	.L67		@
.L85:
@ file.c:277:   else if (strcmp(name, "s3") == 0)
	ldr	r1, .L100+152	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _20,
@ file.c:277:   else if (strcmp(name, "s3") == 0)
	cmp	r3, #0	@ _20,
	bne	.L86		@,
@ file.c:278:     reg = s3;
	ldr	r3, .L100+156	@ tmp165,
	str	r3, [fp, #-8]	@ tmp165, reg
	b	.L67		@
.L86:
@ file.c:279:   else if (strcmp(name, "s4") == 0)
	ldr	r1, .L100+160	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _21,
@ file.c:279:   else if (strcmp(name, "s4") == 0)
	cmp	r3, #0	@ _21,
	bne	.L87		@,
@ file.c:280:     reg = s4;
	ldr	r3, .L100+164	@ tmp166,
	str	r3, [fp, #-8]	@ tmp166, reg
	b	.L67		@
.L87:
@ file.c:281:   else if (strcmp(name, "s5") == 0)
	ldr	r1, .L100+168	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _22,
@ file.c:281:   else if (strcmp(name, "s5") == 0)
	cmp	r3, #0	@ _22,
	bne	.L88		@,
@ file.c:282:     reg = s5;
	ldr	r3, .L100+172	@ tmp167,
	str	r3, [fp, #-8]	@ tmp167, reg
	b	.L67		@
.L88:
@ file.c:283:   else if (strcmp(name, "s6") == 0)
	ldr	r1, .L100+176	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _23,
@ file.c:283:   else if (strcmp(name, "s6") == 0)
	cmp	r3, #0	@ _23,
	bne	.L89		@,
@ file.c:284:     reg = s6;
	ldr	r3, .L100+180	@ tmp168,
	str	r3, [fp, #-8]	@ tmp168, reg
	b	.L67		@
.L89:
@ file.c:285:   else if (strcmp(name, "s7") == 0)
	ldr	r1, .L100+184	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _24,
@ file.c:285:   else if (strcmp(name, "s7") == 0)
	cmp	r3, #0	@ _24,
	bne	.L90		@,
@ file.c:286:     reg = s7;
	ldr	r3, .L100+188	@ tmp169,
	str	r3, [fp, #-8]	@ tmp169, reg
	b	.L67		@
.L90:
@ file.c:287:   else if (strcmp(name, "t8") == 0)
	ldr	r1, .L100+192	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _25,
@ file.c:287:   else if (strcmp(name, "t8") == 0)
	cmp	r3, #0	@ _25,
	bne	.L91		@,
@ file.c:288:     reg = t8;
	ldr	r3, .L100+196	@ tmp170,
	str	r3, [fp, #-8]	@ tmp170, reg
	b	.L67		@
.L91:
@ file.c:289:   else if (strcmp(name, "t9") == 0)
	ldr	r1, .L100+200	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _26,
@ file.c:289:   else if (strcmp(name, "t9") == 0)
	cmp	r3, #0	@ _26,
	bne	.L92		@,
@ file.c:290:     reg = t9;
	ldr	r3, .L100+204	@ tmp171,
	str	r3, [fp, #-8]	@ tmp171, reg
	b	.L67		@
.L92:
@ file.c:291:   else if (strcmp(name, "k0") == 0)
	ldr	r1, .L100+208	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _27,
@ file.c:291:   else if (strcmp(name, "k0") == 0)
	cmp	r3, #0	@ _27,
	bne	.L93		@,
@ file.c:292:     reg = k0;
	ldr	r3, .L100+212	@ tmp172,
	str	r3, [fp, #-8]	@ tmp172, reg
	b	.L67		@
.L93:
@ file.c:293:   else if (strcmp(name, "k1") == 0)
	ldr	r1, .L100+216	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _28,
@ file.c:293:   else if (strcmp(name, "k1") == 0)
	cmp	r3, #0	@ _28,
	bne	.L94		@,
@ file.c:294:     reg = k1;
	ldr	r3, .L100+220	@ tmp173,
	str	r3, [fp, #-8]	@ tmp173, reg
	b	.L67		@
.L94:
@ file.c:295:   else if (strcmp(name, "gp") == 0)
	ldr	r1, .L100+224	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _29,
@ file.c:295:   else if (strcmp(name, "gp") == 0)
	cmp	r3, #0	@ _29,
	bne	.L95		@,
@ file.c:296:     reg = gp;
	ldr	r3, .L100+228	@ tmp174,
	str	r3, [fp, #-8]	@ tmp174, reg
	b	.L67		@
.L95:
@ file.c:297:   else if (strcmp(name, "sp") == 0)
	ldr	r1, .L100+232	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _30,
@ file.c:297:   else if (strcmp(name, "sp") == 0)
	cmp	r3, #0	@ _30,
	bne	.L96		@,
@ file.c:298:     reg = sp;
	ldr	r3, .L100+236	@ tmp175,
	str	r3, [fp, #-8]	@ tmp175, reg
	b	.L67		@
.L96:
@ file.c:299:   else if (strcmp(name, "fp") == 0)
	ldr	r1, .L100+240	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _31,
@ file.c:299:   else if (strcmp(name, "fp") == 0)
	cmp	r3, #0	@ _31,
	bne	.L97		@,
@ file.c:300:     reg = fp;
	ldr	r3, .L100+244	@ tmp176,
	str	r3, [fp, #-8]	@ tmp176, reg
	b	.L67		@
.L97:
@ file.c:301:   else if (strcmp(name, "ra") == 0)
	ldr	r1, .L100+248	@,
	ldr	r0, [fp, #-16]	@, name
	bl	strcmp		@
	mov	r3, r0	@ _32,
@ file.c:301:   else if (strcmp(name, "ra") == 0)
	cmp	r3, #0	@ _32,
	bne	.L98		@,
@ file.c:302:     reg = ra;
	ldr	r3, .L100+252	@ tmp177,
	str	r3, [fp, #-8]	@ tmp177, reg
	b	.L67		@
.L98:
@ file.c:304:     reg = zero;
	ldr	r3, .L100+4	@ tmp178,
	str	r3, [fp, #-8]	@ tmp178, reg
.L67:
@ file.c:306:   return reg;
	ldr	r3, [fp, #-8]	@ _72, reg
@ file.c:307: }
	mov	r0, r3	@, <retval>
	sub	sp, fp, #4	@,,
	@ sp needed	@
	pop	{fp, pc}	@
.L101:
	.align	2
.L100:
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.word	.LC16
	.word	.LC17
	.word	.LC18
	.word	.LC19
	.word	.LC20
	.word	.LC21
	.word	.LC22
	.word	.LC23
	.word	.LC24
	.word	.LC25
	.word	.LC26
	.word	.LC27
	.word	.LC28
	.word	.LC29
	.word	.LC30
	.word	.LC31
	.word	.LC32
	.word	.LC33
	.word	.LC34
	.word	.LC35
	.word	.LC36
	.word	.LC37
	.word	.LC38
	.word	.LC39
	.word	.LC40
	.word	.LC41
	.word	.LC42
	.word	.LC43
	.word	.LC44
	.word	.LC45
	.word	.LC46
	.word	.LC47
	.word	.LC48
	.word	.LC49
	.word	.LC50
	.word	.LC51
	.word	.LC52
	.word	.LC53
	.word	.LC54
	.word	.LC55
	.word	.LC56
	.word	.LC57
	.word	.LC58
	.word	.LC59
	.word	.LC60
	.word	.LC61
	.word	.LC62
	.word	.LC63
	.word	.LC64
	.word	.LC65
	.word	.LC66
	.word	.LC67
	.size	reg_lookup, .-reg_lookup
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
