	.file	"mandelfp.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_a2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
# GNU C17 (SiFive GCC 8.3.0-2019.08.0) version 8.3.0 (riscv64-unknown-elf)
#	compiled by GNU C version 5.4.0 20160609, GMP version 6.1.0, MPFR version 3.1.4, MPC version 1.0.3, isl version isl-0.18-GMP

# GGC heuristics: --param ggc-min-expand=30 --param ggc-min-heapsize=4096
# options passed:  -imultilib rv32imac/ilp32
# -iprefix /home/martin/2019/riscv/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/bin/../lib/gcc/riscv64-unknown-elf/8.3.0/
# -isysroot /home/martin/2019/riscv/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/bin/../riscv64-unknown-elf
# mandelfp.c -march=rv32imac -mabi=ilp32 -O3 -fverbose-asm
# options enabled:  -faggressive-loop-optimizations -falign-functions
# -falign-jumps -falign-labels -falign-loops -fauto-inc-dec
# -fbranch-count-reg -fcaller-saves -fchkp-check-incomplete-type
# -fchkp-check-read -fchkp-check-write -fchkp-instrument-calls
# -fchkp-narrow-bounds -fchkp-optimize -fchkp-store-bounds
# -fchkp-use-static-bounds -fchkp-use-static-const-bounds
# -fchkp-use-wrappers -fcode-hoisting -fcombine-stack-adjustments -fcommon
# -fcompare-elim -fcprop-registers -fcrossjumping -fcse-follow-jumps
# -fdefer-pop -fdelete-null-pointer-checks -fdevirtualize
# -fdevirtualize-speculatively -fdwarf2-cfi-asm -fearly-inlining
# -feliminate-unused-debug-types -fexpensive-optimizations
# -fforward-propagate -ffp-int-builtin-inexact -ffunction-cse -fgcse
# -fgcse-after-reload -fgcse-lm -fgnu-runtime -fgnu-unique
# -fguess-branch-probability -fhoist-adjacent-loads -fident -fif-conversion
# -fif-conversion2 -findirect-inlining -finline -finline-atomics
# -finline-functions -finline-functions-called-once
# -finline-small-functions -fipa-bit-cp -fipa-cp -fipa-cp-clone -fipa-icf
# -fipa-icf-functions -fipa-icf-variables -fipa-profile -fipa-pure-const
# -fipa-ra -fipa-reference -fipa-sra -fipa-vrp -fira-hoist-pressure
# -fira-share-save-slots -fira-share-spill-slots
# -fisolate-erroneous-paths-dereference -fivopts -fkeep-static-consts
# -fleading-underscore -flifetime-dse -floop-interchange
# -floop-unroll-and-jam -flra-remat -flto-odr-type-merging -fmath-errno
# -fmerge-constants -fmerge-debug-strings -fmove-loop-invariants
# -fomit-frame-pointer -foptimize-sibling-calls -foptimize-strlen
# -fpartial-inlining -fpeel-loops -fpeephole -fpeephole2 -fplt
# -fpredictive-commoning -fprefetch-loop-arrays -free -freg-struct-return
# -freorder-blocks -freorder-functions -frerun-cse-after-loop
# -fsched-critical-path-heuristic -fsched-dep-count-heuristic
# -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
# -fsched-rank-heuristic -fsched-spec -fsched-spec-insn-heuristic
# -fsched-stalled-insns-dep -fschedule-fusion -fschedule-insns
# -fschedule-insns2 -fsection-anchors -fsemantic-interposition
# -fshow-column -fshrink-wrap -fshrink-wrap-separate -fsigned-zeros
# -fsplit-ivs-in-unroller -fsplit-loops -fsplit-paths -fsplit-wide-types
# -fssa-backprop -fssa-phiopt -fstdarg-opt -fstore-merging
# -fstrict-aliasing -fstrict-volatile-bitfields -fsync-libcalls
# -fthread-jumps -ftoplevel-reorder -ftrapping-math -ftree-bit-ccp
# -ftree-builtin-call-dce -ftree-ccp -ftree-ch -ftree-coalesce-vars
# -ftree-copy-prop -ftree-cselim -ftree-dce -ftree-dominator-opts
# -ftree-dse -ftree-forwprop -ftree-fre -ftree-loop-distribute-patterns
# -ftree-loop-distribution -ftree-loop-if-convert -ftree-loop-im
# -ftree-loop-ivcanon -ftree-loop-optimize -ftree-loop-vectorize
# -ftree-parallelize-loops= -ftree-partial-pre -ftree-phiprop -ftree-pre
# -ftree-pta -ftree-reassoc -ftree-scev-cprop -ftree-sink
# -ftree-slp-vectorize -ftree-slsr -ftree-sra -ftree-switch-conversion
# -ftree-tail-merge -ftree-ter -ftree-vrp -funit-at-a-time -funswitch-loops
# -fverbose-asm -fzero-initialized-in-bss -mdiv -mexplicit-relocs -mplt
# -mriscv-attribute -mstrict-align

	.text
	.align	1
	.globl	mandelfp
	.type	mandelfp, @function
mandelfp:
	addi	sp,sp,-1104	#,,
# mandelfp.c:24: int xmax=-20441;//-1.24763480;
	li	a5,-20480		# tmp138,
# mandelfp.c:15: {
	li	t1,-24576		#,
# mandelfp.c:23: int xmin=-20666;//-1.26136183;
	addi	t5,a5,-186	#, xmin, tmp138
# mandelfp.c:15: {
	sw	s0,1096(sp)	#,
	sw	s2,1088(sp)	#,
	sw	s3,1084(sp)	#,
	sw	s5,1076(sp)	#,
	sw	s7,1068(sp)	#,
	sw	s8,1064(sp)	#,
	sw	ra,1100(sp)	#,
	sw	s1,1092(sp)	#,
	sw	s4,1080(sp)	#,
	sw	s6,1072(sp)	#,
	sw	s9,1060(sp)	#,
	sw	s10,1056(sp)	#,
	sw	s11,1052(sp)	#,
# mandelfp.c:24: int xmax=-20441;//-1.24763480;
	addi	s7,a5,39	#, xmax, tmp138
# mandelfp.c:15: {
	add	sp,sp,t1	#,,
	li	a5,24576		# tmp279,
	li	s2,-24576		# tmp145,
	addi	a5,a5,1024	#, tmp278, tmp279
	addi	a4,sp,16	#, tmp287,
	add	a5,a5,a4	# tmp287, tmp278, tmp278
	addi	s2,s2,-1024	#, tmp144, tmp145
	add	s2,a5,s2	# tmp144, _75, tmp278
# mandelfp.c:26: int ymax= 6337;//0.38676353;
	li	s3,8192		# tmp136,
# mandelfp.c:52:             while ((mul(xn,xn)+mul(y0,y0))<(65536) && ++i<maxiter)  
	mv	a5,s2	# _75, _75
# mandelfp.c:26: int ymax= 6337;//0.38676353;
	addi	s8,s3,-1855	#, ymax, tmp136
# mandelfp.c:52:             while ((mul(xn,xn)+mul(y0,y0))<(65536) && ++i<maxiter)  
	mv	s2,t5	# xmin, xmin
# mandelfp.c:27: int s=-1;
	li	s5,-1		# s,
# mandelfp.c:25: int ymin= 6168;//0.37648215;
	addi	s3,s3,-2024	#, ymin, tmp136
# mandelfp.c:52:             while ((mul(xn,xn)+mul(y0,y0))<(65536) && ++i<maxiter)  
	li	s0,300		# tmp185,
	mv	t5,a5	# _75, _75
	
	
.L8:
# mandelfp.c:33:     s=s*-1;
    #may look odd but now the 'reset' per frame is a mere register transfer and no stack access
	neg	a5,s5	# s, s
	mv	s11,s8	# ymax, ymax
	mv	s6,s3	# ymin, ymin
	mv	s1,s2	# xmin, xmin
# mandelfp.c:40:     int xs=(xmax-xmin)*16/SCREEN_WIDTH;
	mv	t4,s8	# ymax, ymax
# mandelfp.c:33:     s=s*-1;

    #except for this one which gets saved
	sw	a5,8(sp)	# s, %sfp
# mandelfp.c:40:     int xs=(xmax-xmin)*16/SCREEN_WIDTH;
	mv	s8,s3	# ymin, ymin
# mandelfp.c:33:     s=s*-1;
	mv	s10,s7	# xmax, xmax
# mandelfp.c:40:     int xs=(xmax-xmin)*16/SCREEN_WIDTH;
	mv	s3,s2	# xmin, xmin
# mandelfp.c:33:     s=s*-1;
	li	s4,0		# ivtmp.31,
	li	s9,200		# ivtmp_108,
# mandelfp.c:40:     int xs=(xmax-xmin)*16/SCREEN_WIDTH;
	li	t6,10		# tmp141,
	mv	s2,t5	# _75, _75
.L7:
# mandelfp.c:36:     xmin-=z*s;
	sub	s1,s1,s4	# xmin, xmin, ivtmp.31
# mandelfp.c:37:     xmax+=z*s;
	add	s10,s10,s4	# ivtmp.31, xmax, xmax
# mandelfp.c:38:     ymin-=z*s;
	sub	s6,s6,s4	# ymin, ymin, ivtmp.31
# mandelfp.c:39:     ymax+=z*s;
	add	s11,s11,s4	# ivtmp.31, ymax, ymax
# mandelfp.c:40:     int xs=(xmax-xmin)*16/SCREEN_WIDTH;
	sub	t3,s10,s1	# tmp140, xmax, xmin
# mandelfp.c:41:     int ys=(ymax-ymin)*16/SCREEN_HEIGHT;
	sub	t0,s11,s6	# tmp142, ymax, ymin
# mandelfp.c:41:     int ys=(ymax-ymin)*16/SCREEN_HEIGHT;
	li	a5,5		# tmp143,
# mandelfp.c:40:     int xs=(xmax-xmin)*16/SCREEN_WIDTH;
	div	t3,t3,t6	# tmp141, xs, tmp140
	addi	t1,s2,320	#, ivtmp.23, _75
# mandelfp.c:41:     int ys=(ymax-ymin)*16/SCREEN_HEIGHT;
	li	t5,0		# ivtmp.22,
# mandelfp.c:52:             while ((mul(xn,xn)+mul(y0,y0))<(65536) && ++i<maxiter)  
	li	a0,65536		# tmp174,
# mandelfp.c:41:     int ys=(ymax-ymin)*16/SCREEN_HEIGHT;
	div	t0,t0,a5	# tmp143, _79, tmp142
.L6:
# mandelfp.c:44:       q= ymin+(y*ys)/16;
	srai	a1,t5,31	#, tmp151, ivtmp.22
	andi	a1,a1,15	#, tmp152, tmp151
	add	a1,a1,t5	# ivtmp.22, tmp153, tmp152
	srai	a1,a1,4	#, tmp154, tmp153
# mandelfp.c:44:       q= ymin+(y*ys)/16;
	add	a1,a1,s6	# ymin, q, tmp154
	addi	a6,t1,-320	#, ivtmp.13, ivtmp.23
	li	a7,0		# ivtmp.12,
.L5:
# mandelfp.c:46:         p = xmin+(x*xs)/16;
	srai	a2,a7,31	#, tmp158, ivtmp.12
	andi	a2,a2,15	#, tmp159, tmp158
	add	a2,a2,a7	# ivtmp.12, tmp160, tmp159
	srai	a2,a2,4	#, tmp161, tmp160
# mandelfp.c:46:         p = xmin+(x*xs)/16;
	add	a2,a2,s1	# xmin, p, tmp161
# mandelfp.c:52:             while ((mul(xn,xn)+mul(y0,y0))<(65536) && ++i<maxiter)  
	li	a3,1		# i,
# mandelfp.c:50:             y0=0;
	li	a4,0		# y0,
# mandelfp.c:49:             x0=0;
	li	a5,0		# x0,
	j	.L3		#
.L16:
# mandelfp.c:52:             while ((mul(xn,xn)+mul(y0,y0))<(65536) && ++i<maxiter)  
	addi	a3,a3,1	#, i, i
	beq	a3,s0,.L15	#, i, tmp185,
.L3:
# mandelfp.c:58:                 y0=mul(32768,mul(x0,y0)) +q;
	mul	t2,a4,a5	# tmp166, y0, x0
# mandelfp.c:54:                 xn=mul((x0+y0),(x0-y0)) +p; 
	add	ra,a4,a5	# x0, tmp162, y0
	sub	a5,a5,a4	# tmp163, x0, y0
	mul	a5,ra,a5	# tmp164, tmp162, tmp163
# mandelfp.c:58:                 y0=mul(32768,mul(x0,y0)) +q;
	srai	a4,t2,14	#, tmp167, tmp166
	slli	a4,a4,1	#, tmp168, tmp167
	#srai	a4,a4,14	#, _15, tmp168
# mandelfp.c:58:                 y0=mul(32768,mul(x0,y0)) +q;
	add	a4,a4,a1	# q, y0, _15
# mandelfp.c:54:                 xn=mul((x0+y0),(x0-y0)) +p; 
	srai	a5,a5,14	#, tmp165, tmp164
# mandelfp.c:54:                 xn=mul((x0+y0),(x0-y0)) +p; 
	add	a5,a5,a2	# p, xn, tmp165
# mandelfp.c:52:             while ((mul(xn,xn)+mul(y0,y0))<(65536) && ++i<maxiter)  
	mul	t2,a5,a5	# tmp169, xn, xn
# mandelfp.c:52:             while ((mul(xn,xn)+mul(y0,y0))<(65536) && ++i<maxiter)  
	mul	ra,a4,a4	# tmp171, y0, y0
# mandelfp.c:52:             while ((mul(xn,xn)+mul(y0,y0))<(65536) && ++i<maxiter)  
	srai	t2,t2,14	#, tmp170, tmp169
# mandelfp.c:52:             while ((mul(xn,xn)+mul(y0,y0))<(65536) && ++i<maxiter)  
	srai	ra,ra,14	#, tmp172, tmp171
# mandelfp.c:52:             while ((mul(xn,xn)+mul(y0,y0))<(65536) && ++i<maxiter)  
	add	t2,t2,ra	# tmp172, tmp173, tmp170
# mandelfp.c:52:             while ((mul(xn,xn)+mul(y0,y0))<(65536) && ++i<maxiter)  
	blt	t2,a0,.L16	#, tmp173, tmp174,
	#andi	a3,a3,0xff	# _170, i
	#a3 is i
	#shift 5+6 and add
	#shift 6 and add
	#add
	
	#slli	a5,a3,1	#, tmp176, _170
	andi	a3,a3,0b1111
	#li a5,0b0000000001 #green
    #li a5,0b0000010000 #red
	#li a5,0b1000000000 #blue
    li a5,0b1000010001 #blue
	mul a5,a3,a5
	#add a5,x0,a3
	#slli a3,a3,5
	#add a5,a5,a3
	#slli a3,a3,6
	#add a5,a5,a3
	
	#andi	a5,a5,0xff	# _172, tmp176
.L4:
# mandelfp.c:65:                 linebuf.buf[y*160*2+x*2]=i;
	#sb	a3,0(a6)	# _170, MEM[base: _88, offset: 0B]
	sh  a5,0(a6)
# mandelfp.c:66:                 linebuf.buf[y*160*2+x*2+1]=i*2;
	#sb	a5,1(a6)	# _172, MEM[base: _88, offset: 1B]
	addi	a6,a6,2	#, ivtmp.13, ivtmp.13
	add	a7,a7,t3	# xs, ivtmp.12, ivtmp.12
# mandelfp.c:45:       for (x=0;x<SCREEN_WIDTH;x++) {                        
	bne	t1,a6,.L5	#, ivtmp.23, ivtmp.13,
# mandelfp.c:43:     for (y=0;y<SCREEN_HEIGHT;y++) {
	li	a5,24576		# tmp282,
	addi	a5,a5,1344	#, tmp281, tmp282
	addi	a4,sp,16	#, tmp286,
	addi	t1,t1,320	#, ivtmp.23, ivtmp.23
	add	a5,a5,a4	# tmp286, tmp281, tmp281
	add	t5,t5,t0	# _79, ivtmp.22, ivtmp.22
	bne	a5,t1,.L6	#, tmp281, ivtmp.23,
# mandelfp.c:70:     dp_imagefill565(linebuf.buf);
	mv	a0,s2	#, _75
	sw	t4,12(sp)	# ymax, %sfp
	addi	s9,s9,-1	#, ivtmp_108, ivtmp_108
	call	dp_imagefill565		#
	sub	s4,s4,s5	# ivtmp.31, ivtmp.31, s
# mandelfp.c:34: for (z=0;z<200;z++)
	lw	t4,12(sp)		# ymax, %sfp
	li	t6,10		# tmp141,
	bne	s9,zero,.L7	#, ivtmp_108,,
	li	a4,20480		# tmp181,
	li	a5,-20480		# tmp183,
	addi	a4,a4,-580	#, tmp180, tmp181
	addi	a5,a5,580	#, tmp182, tmp183
	mul	a4,s5,a4	# _164, s, tmp180
	mv	t5,s2	# _75, _75
	mv	s2,s3	# xmin, xmin
	mv	s3,s8	# ymin, ymin
	mul	a5,s5,a5	# _160, s, tmp182
	add	s2,s2,a4	# _164, xmin, xmin
	add	s3,s3,a4	# _164, ymin, ymin
# mandelfp.c:33:     s=s*-1;
	lw	s5,8(sp)		# s, %sfp
	add	s7,s7,a5	# _160, xmax, xmax
	add	s8,t4,a5	# _160, ymax, ymax
	j	.L8		#
.L15:
	li	a5,2		# _172,
	li	a3,1		# _170,
	j	.L4		#
	.size	mandelfp, .-mandelfp
	.ident	"GCC: (SiFive GCC 8.3.0-2019.08.0) 8.3.0"
