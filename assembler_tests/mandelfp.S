	.file	"mandelfp.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_a2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.globl	__floatsidf
	.globl	__divdf3
	.globl	__muldf3
	.globl	__extendsfdf2
	.globl	__subdf3
	.globl	__truncdfsf2
	.globl	__adddf3
	.globl	__subsf3
	.globl	__divsf3
	.globl	__floatsisf
	.globl	__mulsf3
	.globl	__addsf3
	.globl	__fixsfsi
	.section	.text.mandelfp,"ax",@progbits
	.align	1
	.globl	mandelfp
	.type	mandelfp, @function
mandelfp:
.LFB0:
	.file 1 "mandelfp.c"
	.loc 1 13 1
	.cfi_startproc
	.loc 1 14 1
.LVL0:
	.loc 1 15 1
	.loc 1 16 1
	.loc 1 17 1
	.loc 1 19 1
	.loc 1 20 1
	.loc 1 21 1
	.loc 1 22 1
	.loc 1 23 1
	.loc 1 13 1 is_stmt 0
	addi	sp,sp,-1152
	.cfi_def_cfa_offset 1152
	lui	a5,%hi(.LC7)
	sw	s1,1140(sp)
	.cfi_offset 9, -12
	.loc 1 40 15
	lw	s1,%lo(.LC7)(a5)
	.loc 1 22 5
	lui	a5,%hi(.LC0)
	lw	a5,%lo(.LC0)(a5)
	.loc 1 13 1
	li	t1,-24576
	sw	s0,1144(sp)
	sw	s9,1108(sp)
	sw	s11,1100(sp)
	sw	ra,1148(sp)
	sw	s2,1136(sp)
	sw	s3,1132(sp)
	sw	s4,1128(sp)
	sw	s5,1124(sp)
	sw	s6,1120(sp)
	sw	s7,1116(sp)
	sw	s8,1112(sp)
	sw	s10,1104(sp)
	add	sp,sp,t1
	.cfi_def_cfa_offset 25728
	.cfi_offset 8, -8
	.cfi_offset 25, -44
	.cfi_offset 27, -52
	.cfi_offset 1, -4
	.cfi_offset 18, -16
	.cfi_offset 19, -20
	.cfi_offset 20, -24
	.cfi_offset 21, -28
	.cfi_offset 22, -32
	.cfi_offset 23, -36
	.cfi_offset 24, -40
	.cfi_offset 26, -48
	.loc 1 22 5
	sw	a5,16(sp)
	.loc 1 20 5
	
	#this seems to load the constants xmin ...
	lui	a5,%hi(.LC1)
	lw	a5,%lo(.LC1)(a5)
	.loc 1 23 5
	li	a4,-1
	sw	a4,20(sp)
	.loc 1 20 5
	sw	a5,12(sp)
	.loc 1 21 5
	lui	a5,%hi(.LC2)
	lw	s11,%lo(.LC2)(a5)
	.loc 1 19 5
	lui	a5,%hi(.LC3)
	lw	s0,%lo(.LC3)(a5)
	.loc 1 32 12
	lui	a5,%hi(.LC4)
	lw	a6,%lo(.LC4+4)(a5)
	lw	a5,%lo(.LC4)(a5)
	.loc 1 61 5
	li	a4,24576
	addi	a4,a4,1024
	.loc 1 32 12
	sw	a5,40(sp)
	.loc 1 36 7
	lui	a5,%hi(.LC5)
	lw	a5,%lo(.LC5)(a5)
	.loc 1 61 5
	addi	a3,sp,64
	add	a4,a4,a3
	.loc 1 36 7
	sw	a5,52(sp)
	.loc 1 37 7
	lui	a5,%hi(.LC6)
	lw	a5,%lo(.LC6)(a5)
	.loc 1 40 15
	sw	s1,48(sp)
	.loc 1 32 12
	sw	a6,44(sp)
	.loc 1 37 7
	sw	a5,56(sp)
	li	a5,-24576
	addi	a5,a5,-1024
	.loc 1 61 5
	add	s9,a4,a5
	sw	a5,36(sp)
	sw	s9,60(sp)
.LVL1:
.L8:
	.loc 1 25 1 is_stmt 1
	.loc 1 27 1
	.loc 1 29 5
	.loc 1 29 6 is_stmt 0
	lw	a5,20(sp)
	.loc 1 30 7
	li	s4,0
	.loc 1 29 6
	neg	a5,a5
	mv	a0,a5
	sw	a5,20(sp)
.LVL2:
	.loc 1 30 1 is_stmt 1
	call	__floatsidf
.LVL3:
	sw	a0,24(sp)
	sw	a1,28(sp)
.LVL4:
.L7:
	.loc 1 32 5
	.loc 1 32 12 is_stmt 0
	mv	a0,s4
	call	__floatsidf
.LVL5:
	lw	a2,40(sp)
	lw	a3,44(sp)
	.loc 1 48 19
	
	#s8 is 4<<13 at line 51
	li	s8,32768
	.loc 1 48 57
	
	#s7 is maxiter
	li	s7,30
	.loc 1 32 12
	call	__divdf3
.LVL6:
	.loc 1 32 20
	lw	a2,24(sp)
	lw	a3,28(sp)
	call	__muldf3
.LVL7:
	mv	s2,a0
	.loc 1 32 9
	mv	a0,s0
	.loc 1 32 20
	mv	s3,a1
	.loc 1 32 9
	call	__extendsfdf2
.LVL8:
	mv	a2,s2
	mv	a3,s3
	call	__subdf3
.LVL9:
	call	__truncdfsf2
.LVL10:
	mv	s0,a0
.LVL11:
	.loc 1 33 5 is_stmt 1
	.loc 1 33 9 is_stmt 0
	lw	a0,12(sp)
	call	__extendsfdf2
.LVL12:
	mv	a2,s2
	mv	a3,s3
	call	__adddf3
.LVL13:
	call	__truncdfsf2
.LVL14:
	mv	s5,a0
	sw	a0,12(sp)
.LVL15:
	.loc 1 34 5 is_stmt 1
	.loc 1 34 9 is_stmt 0
	mv	a0,s11
.LVL16:
	call	__extendsfdf2
.LVL17:
	mv	a2,s2
	mv	a3,s3
	call	__subdf3
.LVL18:
	call	__truncdfsf2
.LVL19:
	mv	s11,a0
.LVL20:
	.loc 1 35 5 is_stmt 1
	.loc 1 35 9 is_stmt 0
	lw	a0,16(sp)
.LVL21:
	call	__extendsfdf2
.LVL22:
	mv	a2,s2
	mv	a3,s3
	call	__adddf3
.LVL23:
	call	__truncdfsf2
.LVL24:
	mv	s2,a0
	sw	a0,16(sp)
.LVL25:
	.loc 1 36 5 is_stmt 1
	.loc 1 36 13 is_stmt 0
	mv	a1,s0
	mv	a0,s5
.LVL26:
	call	__subsf3
.LVL27:
	.loc 1 36 7
	lw	a1,52(sp)
	.loc 1 39 11
	li	s5,0
.LVL28:
	.loc 1 36 7
	call	__divsf3
.LVL29:
	.loc 1 37 13
	mv	a1,s11
	.loc 1 36 7
	mv	s3,a0
.LVL30:
	.loc 1 37 5 is_stmt 1
	.loc 1 37 13 is_stmt 0
	mv	a0,s2
.LVL31:
	call	__subsf3
.LVL32:
	.loc 1 37 7
	lw	a1,56(sp)
	.loc 1 41 7
	li	s2,160
.LVL33:
	.loc 1 37 7
	call	__divsf3
.LVL34:
	li	a5,24576
	addi	a4,sp,64
	addi	a5,a5,1024
	add	a5,a5,a4
	lw	a4,36(sp)
	sw	a0,32(sp)
.LVL35:
	.loc 1 39 5 is_stmt 1
	add	a5,a5,a4
	sw	a5,8(sp)
.LVL36:
.L6:
	.loc 1 40 7
	.loc 1 40 15 is_stmt 0
	mv	a0,s5
	call	__floatsisf
.LVL37:
	lw	a1,32(sp)
	.loc 1 41 13
	li	s10,0
	.loc 1 40 15
	call	__mulsf3
.LVL38:
	mv	a1,s11
	call	__addsf3
.LVL39:
	lw	a1,48(sp)
	call	__mulsf3
.LVL40:
	.loc 1 40 8
	call	__fixsfsi
.LVL41:
	lw	s6,8(sp)
	mv	s9,a0
.LVL42:
	.loc 1 41 7 is_stmt 1
.L5:
	.loc 1 42 9
	.loc 1 42 17 is_stmt 0
	mv	a0,s10
	call	__floatsisf
.LVL43:
	mv	a1,s3
	call	__mulsf3
.LVL44:
	mv	a1,s0
	call	__addsf3
.LVL45:
	mv	a1,s1
	call	__mulsf3
.LVL46:
	.loc 1 42 10
	call	__fixsfsi
.LVL47:
	.loc 1 44 13 is_stmt 1
	.loc 1 45 13
	.loc 1 46 13
	.loc 1 47 13
	.loc 1 48 13
	.loc 1 46 15 is_stmt 0
	
	#-------------------------------
	li	a5,0
	.loc 1 48 57
	li	a1,1
	.loc 1 45 15
	li	a3,0
	mv	a4,a5
	j	.L3
.LVL48:
.L16:
	.loc 1 48 57 discriminator 1
	addi	a1,a1,1
.LVL49:
	beq	a1,s7,.L15  #s7 is max iter
.LVL50:


.L3:
	.loc 1 50 17 is_stmt 1
	.loc 1 51 20 is_stmt 0
	mul	a5,a3,a4
	.loc 1 50 20
	add	a2,a3,a4
	sub	a3,a3,a4
.LVL51:
	mul	a3,a2,a3
	.loc 1 51 20
	srai	a5,a5,13
	;slli	a5,a5,14
	;srai	a5,a5,13
	.loc 1 51 19
	add	a4,a5,s9
.LVL52:
	.loc 1 50 20
	srai	a3,a3,13
	.loc 1 50 19
	add	a3,a3,a0
.LVL53:
	.loc 1 51 17 is_stmt 1
	.loc 1 52 17
	.loc 1 48 21 is_stmt 0
	mul	a5,a3,a3
	.loc 1 48 32
	mul	a2,a4,a4
	.loc 1 48 21
	srai	a5,a5,13
	.loc 1 48 32
	srai	a2,a2,13
	.loc 1 48 31
	add	a5,a5,a2
	.loc 1 48 19
	blt	a5,s8,.L16
	;andi	a1,a1,0xff
.LVL54:
	slli	a5,a1,1
	;andi	a5,a5,0xff
.L4:
	.loc 1 56 17 is_stmt 1 discriminator 2
	.loc 1 56 41 is_stmt 0 discriminator 2
	sb	a1,0(s6)
	.loc 1 57 17 is_stmt 1 discriminator 2
	.loc 1 57 43 is_stmt 0 discriminator 2
	sb	a5,1(s6)
	.loc 1 41 32 discriminator 2
	addi	s10,s10,1
.LVL55:
	addi	s6,s6,2
	.loc 1 41 7 discriminator 2
	bne	s10,s2,.L5
	lw	a5,8(sp)
	.loc 1 39 31 discriminator 2
	addi	s5,s5,1
.LVL56:
	addi	a5,a5,320
	sw	a5,8(sp)
	.loc 1 39 5 discriminator 2
	li	a5,80
	bne	s5,a5,.L6
	.loc 1 61 5 is_stmt 1 discriminator 2
	lw	a0,60(sp)
.LVL57:
	.loc 1 30 17 is_stmt 0 discriminator 2
	addi	s4,s4,1
.LVL58:
	.loc 1 61 5 discriminator 2
	call	dp_imagefill565
.LVL59:
	.loc 1 30 1 discriminator 2
	li	a5,200
	bne	s4,a5,.L7
	j	.L8
.LVL60:
.L15:
	li	a5,2
	li	a1,1
.LVL61:
	j	.L4
	.cfi_endproc
.LFE0:
	.size	mandelfp, .-mandelfp
	.section	.rodata.mandelfp.cst4,"aM",@progbits,4
	.align	2
.LC0:
	.word	1053165023
.LC1:
	.word	3214914175
.LC2:
	.word	1052820037
.LC3:
	.word	3215029326
.LC5:
	.word	1126170624
.LC6:
	.word	1117782016
.LC7:
	.word	1174405120
	.section	.rodata.mandelfp.cst8,"aM",@progbits,8
	.align	3
.LC4:
	.word	0
	.word	1086556160
	.text
.Letext0:
	.file 2 "/home/grus/mwendt/2019/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/lib/gcc/riscv64-unknown-elf/8.3.0/include/stdint-gcc.h"
	.file 3 "mandelfp.h"
	.file 4 "display.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x1ec
	.2byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0x4
	.byte	0x1
	.4byte	.LASF17
	.byte	0xc
	.4byte	.LASF18
	.4byte	.LASF19
	.4byte	.Ldebug_ranges0+0
	.4byte	0
	.4byte	.Ldebug_line0
	.byte	0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF0
	.byte	0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF1
	.byte	0x2
	.byte	0x4
	.byte	0x5
	.4byte	.LASF2
	.byte	0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF3
	.byte	0x3
	.4byte	.LASF20
	.byte	0x2
	.byte	0x2e
	.byte	0x18
	.4byte	0x4d
	.byte	0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF4
	.byte	0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF5
	.byte	0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF6
	.byte	0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF7
	.byte	0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.byte	0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF8
	.byte	0x2
	.byte	0x10
	.byte	0x4
	.4byte	.LASF9
	.byte	0x5
	.4byte	.LASF15
	.2byte	0x6400
	.byte	0x3
	.byte	0x3
	.byte	0x8
	.4byte	0x9a
	.byte	0x6
	.string	"buf"
	.byte	0x3
	.byte	0x5
	.byte	0xa
	.4byte	0x9a
	.byte	0
	.byte	0
	.byte	0x7
	.4byte	0x41
	.4byte	0xab
	.byte	0x8
	.4byte	0x70
	.2byte	0x63ff
	.byte	0
	.byte	0x9
	.4byte	.LASF21
	.byte	0x1
	.byte	0xc
	.byte	0x6
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.byte	0x1
	.byte	0x9c
	.4byte	0x1dc
	.byte	0xa
	.4byte	.LASF10
	.byte	0x1
	.byte	0xe
	.byte	0x7
	.4byte	0x1dc
	.4byte	.LLST0
	.byte	0xa
	.4byte	.LASF11
	.byte	0x1
	.byte	0xe
	.byte	0x11
	.4byte	0x1dc
	.4byte	.LLST1
	.byte	0xa
	.4byte	.LASF12
	.byte	0x1
	.byte	0xe
	.byte	0x1b
	.4byte	0x1dc
	.4byte	.LLST2
	.byte	0xa
	.4byte	.LASF13
	.byte	0x1
	.byte	0xe
	.byte	0x24
	.4byte	0x1dc
	.4byte	.LLST3
	.byte	0xb
	.string	"xs"
	.byte	0x1
	.byte	0xe
	.byte	0x2d
	.4byte	0x1dc
	.4byte	.LLST4
	.byte	0xb
	.string	"ys"
	.byte	0x1
	.byte	0xe
	.byte	0x30
	.4byte	0x1dc
	.4byte	.LLST5
	.byte	0xb
	.string	"x0"
	.byte	0x1
	.byte	0xf
	.byte	0x5
	.4byte	0x69
	.4byte	.LLST6
	.byte	0xb
	.string	"y0"
	.byte	0x1
	.byte	0xf
	.byte	0x8
	.4byte	0x69
	.4byte	.LLST7
	.byte	0xb
	.string	"p"
	.byte	0x1
	.byte	0xf
	.byte	0xb
	.4byte	0x69
	.4byte	.LLST8
	.byte	0xc
	.string	"q"
	.byte	0x1
	.byte	0xf
	.byte	0xd
	.4byte	0x69
	.byte	0x1
	.byte	0x69
	.byte	0xb
	.string	"xn"
	.byte	0x1
	.byte	0xf
	.byte	0xf
	.4byte	0x69
	.4byte	.LLST6
	.byte	0xb
	.string	"i"
	.byte	0x1
	.byte	0x10
	.byte	0x5
	.4byte	0x69
	.4byte	.LLST10
	.byte	0xc
	.string	"x"
	.byte	0x1
	.byte	0x10
	.byte	0x7
	.4byte	0x69
	.byte	0x1
	.byte	0x6a
	.byte	0xb
	.string	"y"
	.byte	0x1
	.byte	0x10
	.byte	0x9
	.4byte	0x69
	.4byte	.LLST11
	.byte	0xb
	.string	"z"
	.byte	0x1
	.byte	0x10
	.byte	0xb
	.4byte	0x69
	.4byte	.LLST12
	.byte	0xd
	.4byte	.LASF14
	.byte	0x1
	.byte	0x11
	.byte	0x5
	.4byte	0x69
	.byte	0x1e
	.byte	0xb
	.string	"s"
	.byte	0x1
	.byte	0x17
	.byte	0x5
	.4byte	0x69
	.4byte	.LLST13
	.byte	0xe
	.4byte	.LASF15
	.byte	0x1
	.byte	0x19
	.byte	0x10
	.4byte	0x7e
	.byte	0x4
	.byte	0x91
	.byte	0xc0,0xb7,0x7e
	.byte	0xf
	.4byte	.LVL59
	.4byte	0x1e3
	.byte	0x10
	.byte	0x1
	.byte	0x5a
	.byte	0x5
	.byte	0x91
	.byte	0xbc,0xb7,0x7e
	.byte	0x6
	.byte	0
	.byte	0
	.byte	0x2
	.byte	0x4
	.byte	0x4
	.4byte	.LASF16
	.byte	0x11
	.4byte	.LASF22
	.4byte	.LASF22
	.byte	0x4
	.byte	0x4e
	.byte	0x6
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x25
	.byte	0xe
	.byte	0x13
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0x1b
	.byte	0xe
	.byte	0x55
	.byte	0x17
	.byte	0x11
	.byte	0x1
	.byte	0x10
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0x2
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0
	.byte	0
	.byte	0x3
	.byte	0x16
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x4
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0x8
	.byte	0
	.byte	0
	.byte	0x5
	.byte	0x13
	.byte	0x1
	.byte	0x3
	.byte	0xe
	.byte	0xb
	.byte	0x5
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x6
	.byte	0xd
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x38
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0x7
	.byte	0x1
	.byte	0x1
	.byte	0x49
	.byte	0x13
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x8
	.byte	0x21
	.byte	0
	.byte	0x49
	.byte	0x13
	.byte	0x2f
	.byte	0x5
	.byte	0
	.byte	0
	.byte	0x9
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x96,0x42
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xa
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0xb
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0xc
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0xd
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x1c
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0xe
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0xf
	.byte	0x89,0x82,0x1
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x31
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x10
	.byte	0x8a,0x82,0x1
	.byte	0
	.byte	0x2
	.byte	0x18
	.byte	0x91,0x42
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x11
	.byte	0x2e
	.byte	0
	.byte	0x3f
	.byte	0x19
	.byte	0x3c
	.byte	0x19
	.byte	0x6e
	.byte	0xe
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.4byte	.LVL0
	.4byte	.LVL1
	.2byte	0x6
	.byte	0x9e
	.byte	0x4
	.4byte	0xbfa1744e
	.4byte	.LVL1
	.4byte	.LFE0
	.2byte	0x1
	.byte	0x58
	.4byte	0
	.4byte	0
.LLST1:
	.4byte	.LVL0
	.4byte	.LVL1
	.2byte	0x6
	.byte	0x9e
	.byte	0x4
	.4byte	0x3ec0c245
	.4byte	.LVL1
	.4byte	.LVL20
	.2byte	0x1
	.byte	0x6b
	.4byte	.LVL20
	.4byte	.LVL21
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL21
	.4byte	.LFE0
	.2byte	0x1
	.byte	0x6b
	.4byte	0
	.4byte	0
.LLST2:
	.4byte	.LVL0
	.4byte	.LVL1
	.2byte	0x6
	.byte	0x9e
	.byte	0x4
	.4byte	0xbf9fb27f
	.4byte	.LVL1
	.4byte	.LVL15
	.2byte	0x4
	.byte	0x91
	.byte	0x8c,0xb7,0x7e
	.4byte	.LVL15
	.4byte	.LVL16
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL16
	.4byte	.LVL28
	.2byte	0x1
	.byte	0x65
	.4byte	.LVL28
	.4byte	.LFE0
	.2byte	0x4
	.byte	0x91
	.byte	0x8c,0xb7,0x7e
	.4byte	0
	.4byte	0
.LLST3:
	.4byte	.LVL0
	.4byte	.LVL1
	.2byte	0x6
	.byte	0x9e
	.byte	0x4
	.4byte	0x3ec605df
	.4byte	.LVL1
	.4byte	.LVL25
	.2byte	0x4
	.byte	0x91
	.byte	0x90,0xb7,0x7e
	.4byte	.LVL25
	.4byte	.LVL26
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL26
	.4byte	.LVL33
	.2byte	0x1
	.byte	0x62
	.4byte	.LVL33
	.4byte	.LFE0
	.2byte	0x4
	.byte	0x91
	.byte	0x90,0xb7,0x7e
	.4byte	0
	.4byte	0
.LLST4:
	.4byte	.LVL30
	.4byte	.LVL31
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL31
	.4byte	.LFE0
	.2byte	0x1
	.byte	0x63
	.4byte	0
	.4byte	0
.LLST5:
	.4byte	.LVL35
	.4byte	.LVL36
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL36
	.4byte	.LFE0
	.2byte	0x4
	.byte	0x91
	.byte	0xa0,0xb7,0x7e
	.4byte	0
	.4byte	0
.LLST6:
	.4byte	.LVL47
	.4byte	.LVL48
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL48
	.4byte	.LVL51
	.2byte	0x1
	.byte	0x5d
	.4byte	.LVL53
	.4byte	.LVL59-1
	.2byte	0x1
	.byte	0x5d
	.4byte	.LVL60
	.4byte	.LFE0
	.2byte	0x1
	.byte	0x5d
	.4byte	0
	.4byte	0
.LLST7:
	.4byte	.LVL47
	.4byte	.LVL48
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL48
	.4byte	.LVL52
	.2byte	0x1
	.byte	0x5e
	.4byte	.LVL53
	.4byte	.LVL59-1
	.2byte	0x1
	.byte	0x5e
	.4byte	.LVL60
	.4byte	.LFE0
	.2byte	0x1
	.byte	0x5e
	.4byte	0
	.4byte	0
.LLST8:
	.4byte	.LVL47
	.4byte	.LVL57
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL60
	.4byte	.LFE0
	.2byte	0x1
	.byte	0x5a
	.4byte	0
	.4byte	0
.LLST10:
	.4byte	.LVL47
	.4byte	.LVL48
	.2byte	0x2
	.byte	0x31
	.byte	0x9f
	.4byte	.LVL48
	.4byte	.LVL54
	.2byte	0x1
	.byte	0x5b
	.4byte	.LVL60
	.4byte	.LVL61
	.2byte	0x1
	.byte	0x5b
	.4byte	0
	.4byte	0
.LLST11:
	.4byte	.LVL35
	.4byte	.LVL36
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL36
	.4byte	.LFE0
	.2byte	0x1
	.byte	0x65
	.4byte	0
	.4byte	0
.LLST12:
	.4byte	.LVL2
	.4byte	.LVL4
	.2byte	0x2
	.byte	0x30
	.byte	0x9f
	.4byte	.LVL4
	.4byte	.LVL58
	.2byte	0x1
	.byte	0x64
	.4byte	.LVL58
	.4byte	.LVL59
	.2byte	0x3
	.byte	0x84
	.byte	0x7f
	.byte	0x9f
	.4byte	.LVL59
	.4byte	.LFE0
	.2byte	0x1
	.byte	0x64
	.4byte	0
	.4byte	0
.LLST13:
	.4byte	.LVL0
	.4byte	.LVL1
	.2byte	0x3
	.byte	0x9
	.byte	0xff
	.byte	0x9f
	.4byte	.LVL1
	.4byte	.LVL2
	.2byte	0x4
	.byte	0x91
	.byte	0x94,0xb7,0x7e
	.4byte	.LVL2
	.4byte	.LVL3-1
	.2byte	0x1
	.byte	0x5a
	.4byte	.LVL3-1
	.4byte	.LFE0
	.2byte	0x4
	.byte	0x91
	.byte	0x94,0xb7,0x7e
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.LFB0
	.4byte	.LFE0-.LFB0
	.4byte	0
	.4byte	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.4byte	.LFB0
	.4byte	.LFE0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF11:
	.string	"ymin"
.LASF21:
	.string	"mandelfp"
.LASF16:
	.string	"float"
.LASF12:
	.string	"xmax"
.LASF4:
	.string	"unsigned char"
.LASF6:
	.string	"long unsigned int"
.LASF5:
	.string	"short unsigned int"
.LASF22:
	.string	"dp_imagefill565"
.LASF14:
	.string	"maxiter"
.LASF8:
	.string	"unsigned int"
.LASF7:
	.string	"long long unsigned int"
.LASF20:
	.string	"uint8_t"
.LASF15:
	.string	"linebuf"
.LASF3:
	.string	"long long int"
.LASF18:
	.string	"mandelfp.c"
.LASF1:
	.string	"short int"
.LASF17:
	.string	"GNU C11 8.3.0 -march=rv32imac -mabi=ilp32 -mcmodel=medlow -ggdb -O2 -std=gnu11 -fno-pie -fno-common -ffunction-sections -fdata-sections -ffreestanding -ftls-model=local-exec"
.LASF19:
	.string	"/home/grus/mwendt/open/2020/riscv/longan_mandelbrot"
.LASF10:
	.string	"xmin"
.LASF2:
	.string	"long int"
.LASF9:
	.string	"long double"
.LASF0:
	.string	"signed char"
.LASF13:
	.string	"ymax"
	.ident	"GCC: (SiFive GCC 8.3.0-2019.08.0) 8.3.0"
