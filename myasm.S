	#.file	"snip1.c"
	#.option nopic
	.attribute arch, "rv32i2p0_m2p0_a2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	myasm
	.type	myasm, @function
	
	#a0,a1,... are input
	#a0 is return
	
myasm:
    #mul((x0+y0),(x0-y0))
    #a0=x0
    #a1=y0
    #a2=p
    
    addi	sp,sp,-16

    #sw	a2,0(sp)
    sw	a3,4(sp)
    
    add a3,a0,a1
    sub a1,a0,a1
    mul a0,a1,a3
	srai a0,a0,14 #BECAUSE: mul(a,b) ((((int)a)*(b))>>FIXSIZE)
	add a0,a0,a2
	
	#sw	s0,44(sp) #;@backup s0
	#addi	s0,sp,48 #use s0 as stackpointer
	
	#move a0 and a1 to a4,a5 via stack?
	#sw	a0,-36(s0)
	#sw	a1,-40(s0)
	
	#lw	a4,-36(s0)
	#lw	a5,-40(s0)
	
	#add	a5,a4,a5
	#add a0,a1,a0
	
	#sw	a5,-20(s0)
	#lw	a5,-20(s0)
	#mv	a0,a5
	
	#lw	s0,44(sp) #restore s0
    #lw	a2,0(sp)
    lw	a3,4(sp)
    #li a0,0
	addi	sp,sp,16
	ret#jr	ra
	
	
	.size	myasm, .-myasm
	.ident	"GCC: (SiFive GCC 8.3.0-2019.08.0) 8.3.0"
