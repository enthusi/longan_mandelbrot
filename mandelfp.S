	.file	"mandelfp.c"
	.option nopic
	.attribute arch, "rv32i2p0_m2p0_a2p0_c2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16

	.text
	.align	1
	.globl	mandelfp
	.type	mandelfp, @function

 

mandelfp:
     li t0,-25700
	 add	sp,sp,t0
	 
	 
	 li a1,-20666 #xmin -1.26136183
	 li a2,-20441 #xmax -1.24763480
	 li a3,  6168 #ymin 0.37648215
	 li a4,  6337 #ymax 0.38676353
	 li a5,  1 #s zoom direction toggle
	 

turnloop:	 
	 li a6,0 #z
mainloop:
     
     mul a7, a5, a6 #z*s
     sub a1,a1,a7 #xmin-=z*s;
     add a2,a2,a7 #xmax+=z*s;
     sub a3,a3,a7 #ymin-=z*s;
     add a4,a4,a7 #ymax+=z*s;
     
     #s2=xs
     #s3=ys
     #s4 divider 5
     li s4,5
     sub s2,a2,a1 #(xmax-xmin)
     div s2,s2,s4 #32/SCREEN_WIDTH = /5
     
     sub s3,a4,a3 #(xmax-xmin)
     div s3,s3,s4 #32/SCREEN_WIDTH = /5
     
     #s5 =y
     li s5,0
loopy:
     #s7 = q
     mul s7,s5,s3 #y*ys
     srai s7,s7,4 #/16
     add s7,s7,a3 #+ymin

     #s6 =x
	 li s6,0

loopx:
     #s8 = p
     mul s8,s6,s2 #x*xs
     srai s8,s8,5 #/32
     add s8,s8,a1 #+xmin
     
     li s9,0#xn
     li s10,0#x0
     li s11,0#y0
     
     li t2,64 #maxiter
innerloop:
     #xn=mul((x0+y0),(x0-y0)) +p;
     add t0,s10,s11
     sub t1,s10,s11
     mul s9,t0,t1
     srai s9,s9,14
     add s9,s9,s8
     
     #y0=mul(32768,mul(x0,y0)) +q;
     mul t0,s10,s11
     srai t0,t0,14
     li t1,32768
     mul s11,t1,t0
     srai s11,s11,14
     add s11,s11,s7
     
     #x0=xn;
     mv s10,s9 
     
     #((mul(xn,xn)+mul(y0,y0))<(65536)
     mul t0,s9,s9 #xn**2
     #srai t0,t0,14
     mul t1,s11,s11 #y0**2
     #srai t1,t1,14
     add t0,t0,t1
     srai t0,t0,14
     #OR AFTER ADD? srai t0,t0,14 #this could overflow!!
     
     li	t1,65536		# tmp201,
	 bgt t0,t1, exitloop
     
     add t2,t2,-1
     bne t2,zero,innerloop
     
exitloop:
#somehow store to linebuffer, urks
        #y*320+x*2
     li t1,320
     mul a0,t1,s5
     add a0,a0,s6
     add a0,a0,s6 #+2*x
     
     mv t1,sp#buffer
     add a0,a0,t1 #add that to buffer
     
     sb t2,0(a0)
     add t2,t2,t2
     sb t2,1(a0)
     
     #next x
     add s6,s6,1
     li t0,160
     bne s6,t0,loopx
     
     #next y
     add s5,s5,1
     li t0,80
     bne s5,t0,loopy

     
     #put linebuffer adress to a0 first
     addi    sp, sp, -96
    sw      a1, 0(sp)
    sw      a2, 4(sp)
    sw      a3, 8(sp)
    sw      a4, 12(sp)
    sw      a5, 16(sp)
    sw      a6, 20(sp)
    sw      a7, 24(sp)
    sw      s2, 28(sp)
    sw      s3, 32(sp)
    sw      s4, 36(sp)
    sw      s5, 40(sp)
    sw      s6, 44(sp)
    sw      s7, 48(sp)
    sw      s8, 52(sp)
    sw      s9, 56(sp)
    sw      s10, 60(sp)
    sw      s11, 64(sp)
    sw      t0, 68(sp)
    sw      t1, 72(sp)
    sw      t2, 76(sp)
    
     mv a0, sp
     addi a0,a0,96
     call	dp_imagefill565	

    lw      a1, 0(sp)
    lw      a2, 4(sp)
    lw      a3, 8(sp)
    lw      a4, 12(sp)
    lw      a5, 16(sp)
    lw      a6, 20(sp)
    lw      a7, 24(sp)
    lw      s2, 28(sp)
    lw      s3, 32(sp)
    lw      s4, 36(sp)
    lw      s5, 40(sp)
    lw      s6, 44(sp)
    lw      s7, 48(sp)
    lw      s8, 52(sp)
    lw      s9, 56(sp)
    lw      s10, 60(sp)
    lw      s11, 64(sp)
    lw      t0, 68(sp)
    lw      t1, 72(sp)
    lw      t2, 76(sp)
     addi    sp, sp, 96
     
     #keep zooming
     add a6,a6,1
     li t0,200
     bne a6,t0, mainloop
     
     
     li t0,-1
     mul a5,a5,t0
     j turnloop

	  
	 #li t0,25700
	 #add	sp,sp,t0
	 
	#.size	mandelfp, .-mandelfp
	#.ident	"GCC: (SiFive GCC 8.3.0-2019.08.0) 8.3.0"

     
#.data     
#buffer:
#.zero 25700
	  
