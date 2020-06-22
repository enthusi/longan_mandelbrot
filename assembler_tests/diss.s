
build/code.elf:     file format elf32-littleriscv


Disassembly of section .init:

08001000 <vector_base>:
/* this chip has 87 interrupts and hence need 512-byte alignment
 * for the vector table */
.align 9
vector_base:
	/* save some power by disabling these counters */
	csrs	CSR_MCOUNTINHIBIT, CSR_MCOUNTINHIBIT_IR | CSR_MCOUNTINHIBIT_CY
 8001000:	73 e0 02 32 37 15 00 08 67 00 25 24 8e 12 00 08     s..27...g.%$....
	...
	/* the gd32vf103 has its flash at 0x08000000, but also mapped to 0,
	 * but if the pc is in a different range from where the code is linked
	 * things break, so jump to the absolute address of _start */
	lui	a0, %hi(_start)
	jalr	zero, a0, %lo(_start)
 800101c:	a6 1e 00 08 00 00 00 00 00 00 00 00 00 00 00 00     ................
	...
 8001044:	8e 12 00 08 8e 12 00 08 8e 12 00 08 8e 12 00 08     ................
 8001054:	8e 12 00 08 8e 12 00 08 8e 12 00 08 8e 12 00 08     ................
 8001064:	8e 12 00 08 8e 12 00 08 8e 12 00 08 8e 12 00 08     ................
 8001074:	8e 12 00 08 8e 12 00 08 8e 12 00 08 8e 12 00 08     ................
 8001084:	8e 12 00 08 8e 12 00 08 8e 12 00 08 8e 12 00 08     ................
 8001094:	8e 12 00 08 8e 12 00 08 8e 12 00 08 8e 12 00 08     ................
 80010a4:	8e 12 00 08 8e 12 00 08 8e 12 00 08 8e 12 00 08     ................
 80010b4:	8e 12 00 08 8e 12 00 08 8e 12 00 08 8e 12 00 08     ................
 80010c4:	8e 12 00 08 8e 12 00 08 8e 12 00 08 8e 12 00 08     ................
 80010d4:	8e 12 00 08 8e 12 00 08 8e 12 00 08 8e 12 00 08     ................
 80010e4:	8e 12 00 08 8e 12 00 08 8e 12 00 08 8e 12 00 08     ................
 80010f4:	8e 12 00 08 00 00 00 00 00 00 00 00 00 00 00 00     ................
	...
 800110c:	8e 12 00 08 00 00 00 00 8e 12 00 08 8e 12 00 08     ................
 800111c:	8e 12 00 08 8e 12 00 08 8e 12 00 08 8e 12 00 08     ................
 800112c:	8e 12 00 08 8e 12 00 08 8e 12 00 08 8e 12 00 08     ................
 800113c:	8e 12 00 08 00 00 00 00 00 00 00 00 8e 12 00 08     ................
 800114c:	8e 12 00 08 8e 12 00 08 8e 12 00 08 dc 1e 00 08     ................

0800115c <irq_entry>:
.weak irq_entry
.type irq_entry, %function
.func irq_entry
.align 2
irq_entry:
	addi	sp, sp, -20*REGBYTES
 800115c:	715d                	addi	sp,sp,-80
	STORE	ra, 0*REGBYTES(sp)
 800115e:	c006                	sw	ra,0(sp)
	STORE	tp, 1*REGBYTES(sp)
 8001160:	c212                	sw	tp,4(sp)
	STORE	t0, 2*REGBYTES(sp)
 8001162:	c416                	sw	t0,8(sp)
	STORE	t1, 3*REGBYTES(sp)
 8001164:	c61a                	sw	t1,12(sp)
	STORE	t2, 4*REGBYTES(sp)
 8001166:	c81e                	sw	t2,16(sp)
	STORE	a0, 5*REGBYTES(sp)
 8001168:	ca2a                	sw	a0,20(sp)
	STORE	a1, 6*REGBYTES(sp)
 800116a:	cc2e                	sw	a1,24(sp)
	STORE	a2, 7*REGBYTES(sp)
 800116c:	ce32                	sw	a2,28(sp)
	STORE	a3, 8*REGBYTES(sp)
 800116e:	d036                	sw	a3,32(sp)
	STORE	a4, 9*REGBYTES(sp)
 8001170:	d23a                	sw	a4,36(sp)
	STORE	a5, 10*REGBYTES(sp)
 8001172:	d43e                	sw	a5,40(sp)
	STORE	a6, 11*REGBYTES(sp)
 8001174:	d642                	sw	a6,44(sp)
	STORE	a7, 12*REGBYTES(sp)
 8001176:	d846                	sw	a7,48(sp)
	STORE	t3, 13*REGBYTES(sp)
 8001178:	da72                	sw	t3,52(sp)
	STORE	t4, 14*REGBYTES(sp)
 800117a:	dc76                	sw	t4,56(sp)
	STORE	t5, 15*REGBYTES(sp)
 800117c:	de7a                	sw	t5,60(sp)
	STORE	t6, 16*REGBYTES(sp)
 800117e:	c0fe                	sw	t6,64(sp)

	/* use special CSR to push mcause to the stack */
	csrwi	CSR_PUSHMCAUSE, 17
 8001180:	7ee8d073          	csrwi	0x7ee,17
	/* use special CSR to push mepc to the stack */
	csrwi	CSR_PUSHMEPC, 18
 8001184:	7ef95073          	csrwi	0x7ef,18
	/* use special CSR to push msubm to the stack */
	csrwi	CSR_PUSHMSUBM, 19
 8001188:	7eb9d073          	csrwi	0x7eb,19

	/* use special CSR to repeatedly jump to handlers in
	 * the vector table until there are no more pending requests.
	 * this also enable the global interrupt flag, so higher level
	 * interrupts can preempt us */
	csrrw	ra, CSR_JALMNXTI, ra
 800118c:	7ed090f3          	csrrw	ra,0x7ed,ra

	/* disable interrupts before restoring CSRs */
	csrc	CSR_MSTATUS, CSR_MSTATUS_MIE
 8001190:	30047073          	csrci	mstatus,8

	LOAD	t0, 19*REGBYTES(sp)
 8001194:	42b6                	lw	t0,76(sp)
	csrw	CSR_MSUBM, t0
 8001196:	7c429073          	csrw	0x7c4,t0
	LOAD	t0, 18*REGBYTES(sp)
 800119a:	42a6                	lw	t0,72(sp)
	csrw	CSR_MEPC, t0
 800119c:	34129073          	csrw	mepc,t0
	LOAD	t0, 17*REGBYTES(sp)
 80011a0:	4296                	lw	t0,68(sp)
	csrw	CSR_MCAUSE, t0
 80011a2:	34229073          	csrw	mcause,t0

	LOAD	ra, 0*REGBYTES(sp)
 80011a6:	4082                	lw	ra,0(sp)
	LOAD	tp, 1*REGBYTES(sp)
 80011a8:	4212                	lw	tp,4(sp)
	LOAD	t0, 2*REGBYTES(sp)
 80011aa:	42a2                	lw	t0,8(sp)
	LOAD	t1, 3*REGBYTES(sp)
 80011ac:	4332                	lw	t1,12(sp)
	LOAD	t2, 4*REGBYTES(sp)
 80011ae:	43c2                	lw	t2,16(sp)
	LOAD	a0, 5*REGBYTES(sp)
 80011b0:	4552                	lw	a0,20(sp)
	LOAD	a1, 6*REGBYTES(sp)
 80011b2:	45e2                	lw	a1,24(sp)
	LOAD	a2, 7*REGBYTES(sp)
 80011b4:	4672                	lw	a2,28(sp)
	LOAD	a3, 8*REGBYTES(sp)
 80011b6:	5682                	lw	a3,32(sp)
	LOAD	a4, 9*REGBYTES(sp)
 80011b8:	5712                	lw	a4,36(sp)
	LOAD	a5, 10*REGBYTES(sp)
 80011ba:	57a2                	lw	a5,40(sp)
	LOAD	a6, 11*REGBYTES(sp)
 80011bc:	5832                	lw	a6,44(sp)
	LOAD	a7, 12*REGBYTES(sp)
 80011be:	58c2                	lw	a7,48(sp)
	LOAD	t3, 13*REGBYTES(sp)
 80011c0:	5e52                	lw	t3,52(sp)
	LOAD	t4, 14*REGBYTES(sp)
 80011c2:	5ee2                	lw	t4,56(sp)
	LOAD	t5, 15*REGBYTES(sp)
 80011c4:	5f72                	lw	t5,60(sp)
	LOAD	t6, 16*REGBYTES(sp)
 80011c6:	4f86                	lw	t6,64(sp)
	addi	sp, sp, 20*REGBYTES
 80011c8:	6161                	addi	sp,sp,80
	mret
 80011ca:	30200073          	mret
	...

08001200 <trap_entry>:
.weak trap_entry
.type trap_entry, %function
.func trap_entry
.align 6
trap_entry:
	j	trap_entry
 8001200:	0000006f          	j	8001200 <trap_entry>
	...

Disassembly of section .text:

08001242 <_start>:
	mret
0:
#endif
.option push
.option norelax
	laa	gp, __global_pointer$
 8001242:	200011b7          	lui	gp,0x20001
 8001246:	80018193          	addi	gp,gp,-2048 # 20000800 <__global_pointer$>
.option pop
	laa	sp, __stack
 800124a:	20008137          	lui	sp,0x20008
 800124e:	00010113          	mv	sp,sp

	/* load data with *a3++ = *a4++ while a3 < a5 */
	la	a4, __data_source
 8001252:	00002717          	auipc	a4,0x2
 8001256:	cea70713          	addi	a4,a4,-790 # 8002f3c <__data_source>
	laa	a3, __data_start
 800125a:	200006b7          	lui	a3,0x20000
 800125e:	00068693          	mv	a3,a3
	laa	a5, __data_end
 8001262:	200007b7          	lui	a5,0x20000
 8001266:	00078793          	mv	a5,a5
	bgeu	a3, a5, 2f
 800126a:	00f6f863          	bgeu	a3,a5,800127a <_start+0x38>
1:
	lw	a0, 0(a4)
 800126e:	4308                	lw	a0,0(a4)
	addi	a4, a4, 4
 8001270:	0711                	addi	a4,a4,4
	sw	a0, 0(a3)
 8001272:	c288                	sw	a0,0(a3)
	addi	a3, a3, 4
 8001274:	0691                	addi	a3,a3,4
	bltu	a3, a5, 1b
 8001276:	fef6ece3          	bltu	a3,a5,800126e <_start+0x2c>
2:
	/* clear bss with *a3++ = a0 (== 0) while a3 < a5 */
	li	a0, 0
 800127a:	4501                	li	a0,0
	/* just clear all memory from __data_end up until __bss_end
	laa	a3, __bss_start
	*/
	laa	a5, __bss_end
 800127c:	200007b7          	lui	a5,0x20000
 8001280:	0ac78793          	addi	a5,a5,172 # 200000ac <__bss_end>
	 * whatever follows. that should be the bottom
	 * of stack or start of heap which is fine
	bgeu	a3, a5, 4f
	 */
3:
	sw	a0, 0(a3)
 8001284:	c288                	sw	a0,0(a3)
	addi	a3, a3, 4
 8001286:	0691                	addi	a3,a3,4
	bltu	a3, a5, 3b
 8001288:	fef6eee3          	bltu	a3,a5,8001284 <_start+0x42>
4:
	call	main
 800128c:	2029                	jal	8001296 <main>

0800128e <ADC0_1_IRQHandler>:
.global default_handler
.weak default_handler
.type default_handler, %function
.func default_handler
default_handler:
	csrc	CSR_MSTATUS, 0xf
 800128e:	3007f073          	csrci	mstatus,15
	j	default_handler
 8001292:	ffdff06f          	j	800128e <ADC0_1_IRQHandler>

08001296 <main>:
 8001296:	400217b7          	lui	a5,0x40021
 800129a:	4398                	lw	a4,0(a5)
 800129c:	1101                	addi	sp,sp,-32
 800129e:	66c1                	lui	a3,0x10
 80012a0:	ce06                	sw	ra,28(sp)
 80012a2:	cc22                	sw	s0,24(sp)
 80012a4:	ca26                	sw	s1,20(sp)
 80012a6:	c84a                	sw	s2,16(sp)
 80012a8:	c64e                	sw	s3,12(sp)
 80012aa:	8f55                	or	a4,a4,a3
 80012ac:	c398                	sw	a4,0(a5)
 80012ae:	43d8                	lw	a4,4(a5)
 80012b0:	20dd06b7          	lui	a3,0x20dd0
 80012b4:	40068693          	addi	a3,a3,1024 # 20dd0400 <__stack+0xdc8400>
 80012b8:	8f55                	or	a4,a4,a3
 80012ba:	c3d8                	sw	a4,4(a5)
 80012bc:	57d8                	lw	a4,44(a5)
 80012be:	00176713          	ori	a4,a4,1
 80012c2:	d7d8                	sw	a4,44(a5)
 80012c4:	4398                	lw	a4,0(a5)
 80012c6:	00e71693          	slli	a3,a4,0xe
 80012ca:	fe06dde3          	bgez	a3,80012c4 <main+0x2e>
 80012ce:	4398                	lw	a4,0(a5)
 80012d0:	010006b7          	lui	a3,0x1000
 80012d4:	8f55                	or	a4,a4,a3
 80012d6:	c398                	sw	a4,0(a5)
 80012d8:	40021737          	lui	a4,0x40021
 80012dc:	431c                	lw	a5,0(a4)
 80012de:	00679693          	slli	a3,a5,0x6
 80012e2:	fe06dde3          	bgez	a3,80012dc <main+0x46>
 80012e6:	435c                	lw	a5,4(a4)
 80012e8:	400216b7          	lui	a3,0x40021
 80012ec:	9bf1                	andi	a5,a5,-4
 80012ee:	0027e793          	ori	a5,a5,2
 80012f2:	c35c                	sw	a5,4(a4)
 80012f4:	4721                	li	a4,8
 80012f6:	42dc                	lw	a5,4(a3)
 80012f8:	8bb1                	andi	a5,a5,12
 80012fa:	fee79ee3          	bne	a5,a4,80012f6 <main+0x60>
 80012fe:	d20007b7          	lui	a5,0xd2000
 8001302:	00e78023          	sb	a4,0(a5) # d2000000 <__stack+0xb1ff8000>
 8001306:	d2000637          	lui	a2,0xd2000
 800130a:	4701                	li	a4,0
 800130c:	6685                	lui	a3,0x1
 800130e:	05700593          	li	a1,87
 8001312:	00271793          	slli	a5,a4,0x2
 8001316:	97b2                	add	a5,a5,a2
 8001318:	97b6                	add	a5,a5,a3
 800131a:	000780a3          	sb	zero,1(a5)
 800131e:	00078023          	sb	zero,0(a5)
 8001322:	0705                	addi	a4,a4,1
 8001324:	feb717e3          	bne	a4,a1,8001312 <main+0x7c>
 8001328:	000605a3          	sb	zero,11(a2) # d200000b <__stack+0xb1ff800b>
 800132c:	20000793          	li	a5,512
 8001330:	7d07a073          	csrs	0x7d0,a5
 8001334:	080017b7          	lui	a5,0x8001
 8001338:	00078793          	mv	a5,a5
 800133c:	30779073          	csrw	mtvt,a5
 8001340:	080017b7          	lui	a5,0x8001
 8001344:	15d78793          	addi	a5,a5,349 # 800115d <irq_entry+0x1>
 8001348:	7ec79073          	csrw	0x7ec,a5
 800134c:	080017b7          	lui	a5,0x8001
 8001350:	20378793          	addi	a5,a5,515 # 8001203 <trap_entry+0x3>
 8001354:	30579073          	csrw	mtvec,a5
 8001358:	30046073          	csrsi	mstatus,8
 800135c:	400217b7          	lui	a5,0x40021
 8001360:	4bd8                	lw	a4,20(a5)
 8001362:	50000437          	lui	s0,0x50000
 8001366:	8f55                	or	a4,a4,a3
 8001368:	cbd8                	sw	a4,20(a5)
 800136a:	4f98                	lw	a4,24(a5)
 800136c:	00576713          	ori	a4,a4,5
 8001370:	cf98                	sw	a4,24(a5)
 8001372:	5798                	lw	a4,40(a5)
 8001374:	8f55                	or	a4,a4,a3
 8001376:	d798                	sw	a4,40(a5)
 8001378:	5798                	lw	a4,40(a5)
 800137a:	76fd                	lui	a3,0xfffff
 800137c:	16fd                	addi	a3,a3,-1
 800137e:	8f75                	and	a4,a4,a3
 8001380:	d798                	sw	a4,40(a5)
 8001382:	500007b7          	lui	a5,0x50000
 8001386:	0007a423          	sw	zero,8(a5) # 50000008 <__stack+0x2fff8008>
 800138a:	00200737          	lui	a4,0x200
 800138e:	df98                	sw	a4,56(a5)
 8001390:	4705                	li	a4,1
 8001392:	cb98                	sw	a4,16(a5)
 8001394:	481c                	lw	a5,16(s0)
 8001396:	8b85                	andi	a5,a5,1
 8001398:	fff5                	bnez	a5,8001394 <main+0xfe>
 800139a:	450d                	li	a0,3
 800139c:	2645                	jal	800173c <dp_udelay>
 800139e:	445c                	lw	a5,12(s0)
 80013a0:	40000737          	lui	a4,0x40000
 80013a4:	8fd9                	or	a5,a5,a4
 80013a6:	c45c                	sw	a5,12(s0)
 80013a8:	50000437          	lui	s0,0x50000
 80013ac:	485c                	lw	a5,20(s0)
 80013ae:	8b85                	andi	a5,a5,1
 80013b0:	fff5                	bnez	a5,80013ac <main+0x116>
 80013b2:	6519                	lui	a0,0x6
 80013b4:	1a850513          	addi	a0,a0,424 # 61a8 <__bootloader+0x51a8>
 80013b8:	2651                	jal	800173c <dp_udelay>
 80013ba:	500017b7          	lui	a5,0x50001
 80013be:	470d                	li	a4,3
 80013c0:	80e7a023          	sw	a4,-2048(a5) # 50000800 <__stack+0x2fff8800>
 80013c4:	4709                	li	a4,2
 80013c6:	80e7a223          	sw	a4,-2044(a5)
 80013ca:	002907b7          	lui	a5,0x290
 80013ce:	dc1c                	sw	a5,56(s0)
 80013d0:	08000793          	li	a5,128
 80013d4:	d05c                	sw	a5,36(s0)
 80013d6:	004007b7          	lui	a5,0x400
 80013da:	08078713          	addi	a4,a5,128 # 400080 <__flash_size+0x3e0080>
 80013de:	d418                	sw	a4,40(s0)
 80013e0:	0c078793          	addi	a5,a5,192
 80013e4:	10f42223          	sw	a5,260(s0) # 50000104 <__stack+0x2fff8104>
 80013e8:	001007b7          	lui	a5,0x100
 80013ec:	10078793          	addi	a5,a5,256 # 100100 <__flash_size+0xe0100>
 80013f0:	10f42423          	sw	a5,264(s0)
 80013f4:	11000793          	li	a5,272
 80013f8:	10f42623          	sw	a5,268(s0)
 80013fc:	70e000ef          	jal	ra,8001b0a <usbfs_txfifos_flush>
 8001400:	481c                	lw	a5,16(s0)
 8001402:	500004b7          	lui	s1,0x50000
 8001406:	0107e793          	ori	a5,a5,16
 800140a:	c81c                	sw	a5,16(s0)
 800140c:	489c                	lw	a5,16(s1)
 800140e:	8bc1                	andi	a5,a5,16
 8001410:	fff5                	bnez	a5,800140c <main+0x176>
 8001412:	50001437          	lui	s0,0x50001
 8001416:	450d                	li	a0,3
 8001418:	2615                	jal	800173c <dp_udelay>
 800141a:	80042823          	sw	zero,-2032(s0) # 50000810 <__stack+0x2fff8810>
 800141e:	80042a23          	sw	zero,-2028(s0)
 8001422:	80042e23          	sw	zero,-2020(s0)
 8001426:	2dad                	jal	8001aa0 <usbfs_ep_reset>
 8001428:	f03107b7          	lui	a5,0xf0310
 800142c:	c0a78793          	addi	a5,a5,-1014 # f030fc0a <__stack+0xd0307c0a>
 8001430:	c8dc                	sw	a5,20(s1)
 8001432:	800c47b7          	lui	a5,0x800c4
 8001436:	81078793          	addi	a5,a5,-2032 # 800c3810 <__stack+0x600bb810>
 800143a:	cc9c                	sw	a5,24(s1)
 800143c:	d20017b7          	lui	a5,0xd2001
 8001440:	14078d23          	sb	zero,346(a5) # d200115a <__stack+0xb1ff915a>
 8001444:	04000713          	li	a4,64
 8001448:	14e78da3          	sb	a4,347(a5)
 800144c:	4705                	li	a4,1
 800144e:	14e78ca3          	sb	a4,345(a5)
 8001452:	449c                	lw	a5,8(s1)
 8001454:	d10006b7          	lui	a3,0xd1000
 8001458:	0017e793          	ori	a5,a5,1
 800145c:	c49c                	sw	a5,8(s1)
 800145e:	80442783          	lw	a5,-2044(s0)
 8001462:	9bf5                	andi	a5,a5,-3
 8001464:	80f42223          	sw	a5,-2044(s0)
 8001468:	42d0                	lw	a2,4(a3)
 800146a:	4298                	lw	a4,0(a3)
 800146c:	42dc                	lw	a5,4(a3)
 800146e:	fef61de3          	bne	a2,a5,8001468 <main+0x1d2>
 8001472:	016e37b7          	lui	a5,0x16e3
 8001476:	60078793          	addi	a5,a5,1536 # 16e3600 <__flash_size+0x16c3600>
 800147a:	97ba                	add	a5,a5,a4
 800147c:	00e7b733          	sltu	a4,a5,a4
 8001480:	9732                	add	a4,a4,a2
 8001482:	c6d8                	sw	a4,12(a3)
 8001484:	c69c                	sw	a5,8(a3)
 8001486:	d20017b7          	lui	a5,0xd2001
 800148a:	00078f23          	sb	zero,30(a5) # d200101e <__stack+0xb1ff901e>
 800148e:	4741                	li	a4,16
 8001490:	00e78fa3          	sb	a4,31(a5)
 8001494:	4e05                	li	t3,1
 8001496:	01c78ea3          	sb	t3,29(a5)
 800149a:	40021737          	lui	a4,0x40021
 800149e:	4f1c                	lw	a5,24(a4)
 80014a0:	6689                	lui	a3,0x2
 80014a2:	4909                	li	s2,2
 80014a4:	0147e793          	ori	a5,a5,20
 80014a8:	cf1c                	sw	a5,24(a4)
 80014aa:	400117b7          	lui	a5,0x40011
 80014ae:	cb94                	sw	a3,16(a5)
 80014b0:	8127a823          	sw	s2,-2032(a5) # 40010810 <__stack+0x20008810>
 80014b4:	4491                	li	s1,4
 80014b6:	8097a823          	sw	s1,-2032(a5)
 80014ba:	43d0                	lw	a2,4(a5)
 80014bc:	ff1006b7          	lui	a3,0xff100
 80014c0:	fff68313          	addi	t1,a3,-1 # ff0fffff <__stack+0xdf0f7fff>
 80014c4:	00667633          	and	a2,a2,t1
 80014c8:	006006b7          	lui	a3,0x600
 80014cc:	8e55                	or	a2,a2,a3
 80014ce:	c3d0                	sw	a2,4(a5)
 80014d0:	8007a603          	lw	a2,-2048(a5)
 80014d4:	78fd                	lui	a7,0xfffff
 80014d6:	0ff88e93          	addi	t4,a7,255 # fffff0ff <__stack+0xdfff70ff>
 80014da:	f0f67613          	andi	a2,a2,-241
 80014de:	06066613          	ori	a2,a2,96
 80014e2:	80c7a023          	sw	a2,-2048(a5)
 80014e6:	8007a583          	lw	a1,-2048(a5)
 80014ea:	6505                	lui	a0,0x1
 80014ec:	00150613          	addi	a2,a0,1 # 1001 <__bootloader+0x1>
 80014f0:	01d5f5b3          	and	a1,a1,t4
 80014f4:	6005e593          	ori	a1,a1,1536
 80014f8:	80b7a023          	sw	a1,-2048(a5)
 80014fc:	4f14                	lw	a3,24(a4)
 80014fe:	c0078413          	addi	s0,a5,-1024
 8001502:	18fd                	addi	a7,a7,-1
 8001504:	00c6e693          	ori	a3,a3,12
 8001508:	cf14                	sw	a3,24(a4)
 800150a:	4f14                	lw	a3,24(a4)
 800150c:	8ed1                	or	a3,a3,a2
 800150e:	cf14                	sw	a3,24(a4)
 8001510:	c097a823          	sw	s1,-1008(a5)
 8001514:	c007a603          	lw	a2,-1024(a5)
 8001518:	02000693          	li	a3,32
 800151c:	01d67633          	and	a2,a2,t4
 8001520:	30066613          	ori	a2,a2,768
 8001524:	c0c7a023          	sw	a2,-1024(a5)
 8001528:	c127aa23          	sw	s2,-1004(a5)
 800152c:	c007a603          	lw	a2,-1024(a5)
 8001530:	f0f67613          	andi	a2,a2,-241
 8001534:	03066613          	ori	a2,a2,48
 8001538:	c0c7a023          	sw	a2,-1024(a5)
 800153c:	c1c7a823          	sw	t3,-1008(a5)
 8001540:	c007a603          	lw	a2,-1024(a5)
 8001544:	9a41                	andi	a2,a2,-16
 8001546:	00366613          	ori	a2,a2,3
 800154a:	c0c7a023          	sw	a2,-1024(a5)
 800154e:	80d7a823          	sw	a3,-2032(a5)
 8001552:	8007a683          	lw	a3,-2048(a5)
 8001556:	00b00637          	lui	a2,0xb00
 800155a:	0066f6b3          	and	a3,a3,t1
 800155e:	8ed1                	or	a3,a3,a2
 8001560:	80d7a023          	sw	a3,-2048(a5)
 8001564:	08000693          	li	a3,128
 8001568:	80d7aa23          	sw	a3,-2028(a5)
 800156c:	8007a683          	lw	a3,-2048(a5)
 8001570:	b0000637          	lui	a2,0xb0000
 8001574:	0692                	slli	a3,a3,0x4
 8001576:	8291                	srli	a3,a3,0x4
 8001578:	8ed1                	or	a3,a3,a2
 800157a:	80d7a023          	sw	a3,-2048(a5)
 800157e:	475c                	lw	a5,12(a4)
 8001580:	8d5d                	or	a0,a0,a5
 8001582:	c748                	sw	a0,12(a4)
 8001584:	475c                	lw	a5,12(a4)
 8001586:	453d                	li	a0,15
 8001588:	0117f8b3          	and	a7,a5,a7
 800158c:	67b1                	lui	a5,0xc
 800158e:	01172623          	sw	a7,12(a4) # 4002100c <__stack+0x2001900c>
 8001592:	31778693          	addi	a3,a5,791 # c317 <__ram_size+0x4317>
 8001596:	40013737          	lui	a4,0x40013
 800159a:	c314                	sw	a3,0(a4)
 800159c:	00072223          	sw	zero,4(a4) # 40013004 <__stack+0x2000b004>
 80015a0:	35778793          	addi	a5,a5,855
 80015a4:	c31c                	sw	a5,0(a4)
 80015a6:	2a59                	jal	800173c <dp_udelay>
 80015a8:	01242823          	sw	s2,16(s0)
 80015ac:	6975                	lui	s2,0x1d
 80015ae:	4c090513          	addi	a0,s2,1216 # 1d4c0 <__ram_size+0x154c0>
 80015b2:	2269                	jal	800173c <dp_udelay>
 80015b4:	4545                	li	a0,17
 80015b6:	c844                	sw	s1,20(s0)
 80015b8:	20c9                	jal	800167a <dp__cmd>
 80015ba:	28c5                	jal	80016aa <dp_cs_disable>
 80015bc:	4c090513          	addi	a0,s2,1216
 80015c0:	2ab5                	jal	800173c <dp_udelay>
 80015c2:	c844                	sw	s1,20(s0)
 80015c4:	08003437          	lui	s0,0x8003
 80015c8:	cf540413          	addi	s0,s0,-779 # 8002cf5 <initdata.1314+0x1>
 80015cc:	4485                	li	s1,1
 80015ce:	00044503          	lbu	a0,0(s0)
 80015d2:	00140993          	addi	s3,s0,1
 80015d6:	894e                	mv	s2,s3
 80015d8:	204d                	jal	800167a <dp__cmd>
 80015da:	9426                	add	s0,s0,s1
 80015dc:	00094503          	lbu	a0,0(s2)
 80015e0:	02891163          	bne	s2,s0,8001602 <main+0x36c>
 80015e4:	00998433          	add	s0,s3,s1
 80015e8:	84aa                	mv	s1,a0
 80015ea:	f175                	bnez	a0,80015ce <main+0x338>
 80015ec:	287d                	jal	80016aa <dp_cs_disable>
 80015ee:	400117b7          	lui	a5,0x40011
 80015f2:	4711                	li	a4,4
 80015f4:	c0e7aa23          	sw	a4,-1004(a5) # 40010c14 <__stack+0x20008c14>
 80015f8:	02900513          	li	a0,41
 80015fc:	28bd                	jal	800167a <dp__cmd>
 80015fe:	2075                	jal	80016aa <dp_cs_disable>
 8001600:	2aa1                	jal	8001758 <mandelfp>
 8001602:	20ad                	jal	800166c <dp__write>
 8001604:	0905                	addi	s2,s2,1
 8001606:	bfd9                	j	80015dc <main+0x346>

08001608 <usbfs_setup_handler_run.constprop.2>:
 8001608:	20000737          	lui	a4,0x20000
 800160c:	01470793          	addi	a5,a4,20 # 20000014 <usbfs_outbuf>
 8001610:	0047c803          	lbu	a6,4(a5)
 8001614:	0007d883          	lhu	a7,0(a5)
 8001618:	080037b7          	lui	a5,0x8003
 800161c:	c1c78793          	addi	a5,a5,-996 # 8002c1c <usbfs_setup_handlers>
 8001620:	85aa                	mv	a1,a0
 8001622:	0ff00313          	li	t1,255
 8001626:	01470513          	addi	a0,a4,20
 800162a:	06878613          	addi	a2,a5,104
 800162e:	0007d683          	lhu	a3,0(a5)
 8001632:	03169363          	bne	a3,a7,8001658 <usbfs_setup_handler_run.constprop.2+0x50>
 8001636:	0027c683          	lbu	a3,2(a5)
 800163a:	00669d63          	bne	a3,t1,8001654 <usbfs_setup_handler_run.constprop.2+0x4c>
 800163e:	0037c683          	lbu	a3,3(a5)
 8001642:	0ff00613          	li	a2,255
 8001646:	00c69d63          	bne	a3,a2,8001660 <usbfs_setup_handler_run.constprop.2+0x58>
 800164a:	0047a303          	lw	t1,4(a5)
 800164e:	01470513          	addi	a0,a4,20
 8001652:	8302                	jr	t1
 8001654:	fed805e3          	beq	a6,a3,800163e <usbfs_setup_handler_run.constprop.2+0x36>
 8001658:	07a1                	addi	a5,a5,8
 800165a:	fcc79ae3          	bne	a5,a2,800162e <usbfs_setup_handler_run.constprop.2+0x26>
 800165e:	a029                	j	8001668 <usbfs_setup_handler_run.constprop.2+0x60>
 8001660:	00655603          	lhu	a2,6(a0)
 8001664:	fed603e3          	beq	a2,a3,800164a <usbfs_setup_handler_run.constprop.2+0x42>
 8001668:	557d                	li	a0,-1
 800166a:	8082                	ret

0800166c <dp__write>:
 800166c:	40013737          	lui	a4,0x40013
 8001670:	471c                	lw	a5,8(a4)
 8001672:	8b89                	andi	a5,a5,2
 8001674:	dff5                	beqz	a5,8001670 <dp__write+0x4>
 8001676:	c748                	sw	a0,12(a4)
 8001678:	8082                	ret

0800167a <dp__cmd>:
 800167a:	40013737          	lui	a4,0x40013
 800167e:	471c                	lw	a5,8(a4)
 8001680:	0807f793          	andi	a5,a5,128
 8001684:	ffed                	bnez	a5,800167e <dp__cmd+0x4>
 8001686:	400117b7          	lui	a5,0x40011
 800168a:	4685                	li	a3,1
 800168c:	c0d7aa23          	sw	a3,-1004(a5) # 40010c14 <__stack+0x20008c14>
 8001690:	c748                	sw	a0,12(a4)
 8001692:	40013737          	lui	a4,0x40013
 8001696:	471c                	lw	a5,8(a4)
 8001698:	0807f793          	andi	a5,a5,128
 800169c:	ffed                	bnez	a5,8001696 <dp__cmd+0x1c>
 800169e:	400117b7          	lui	a5,0x40011
 80016a2:	4705                	li	a4,1
 80016a4:	c0e7a823          	sw	a4,-1008(a5) # 40010c10 <__stack+0x20008c10>
 80016a8:	8082                	ret

080016aa <dp_cs_disable>:
 80016aa:	40013737          	lui	a4,0x40013
 80016ae:	471c                	lw	a5,8(a4)
 80016b0:	0807f793          	andi	a5,a5,128
 80016b4:	ffed                	bnez	a5,80016ae <dp_cs_disable+0x4>
 80016b6:	400117b7          	lui	a5,0x40011
 80016ba:	4711                	li	a4,4
 80016bc:	c0e7a823          	sw	a4,-1008(a5) # 40010c10 <__stack+0x20008c10>
 80016c0:	8082                	ret

080016c2 <dp_imagefill565>:
 80016c2:	1141                	addi	sp,sp,-16
 80016c4:	c606                	sw	ra,12(sp)
 80016c6:	400117b7          	lui	a5,0x40011
 80016ca:	4711                	li	a4,4
 80016cc:	c422                	sw	s0,8(sp)
 80016ce:	c226                	sw	s1,4(sp)
 80016d0:	c04a                	sw	s2,0(sp)
 80016d2:	c0e7aa23          	sw	a4,-1004(a5) # 40010c14 <__stack+0x20008c14>
 80016d6:	892a                	mv	s2,a0
 80016d8:	03a00513          	li	a0,58
 80016dc:	3f79                	jal	800167a <dp__cmd>
 80016de:	4515                	li	a0,5
 80016e0:	3771                	jal	800166c <dp__write>
 80016e2:	02a00513          	li	a0,42
 80016e6:	3f51                	jal	800167a <dp__cmd>
 80016e8:	4501                	li	a0,0
 80016ea:	3749                	jal	800166c <dp__write>
 80016ec:	4505                	li	a0,1
 80016ee:	3fbd                	jal	800166c <dp__write>
 80016f0:	4501                	li	a0,0
 80016f2:	3fad                	jal	800166c <dp__write>
 80016f4:	0a000513          	li	a0,160
 80016f8:	3f95                	jal	800166c <dp__write>
 80016fa:	02b00513          	li	a0,43
 80016fe:	3fb5                	jal	800167a <dp__cmd>
 8001700:	4501                	li	a0,0
 8001702:	37ad                	jal	800166c <dp__write>
 8001704:	4569                	li	a0,26
 8001706:	379d                	jal	800166c <dp__write>
 8001708:	4501                	li	a0,0
 800170a:	378d                	jal	800166c <dp__write>
 800170c:	06900513          	li	a0,105
 8001710:	3fb1                	jal	800166c <dp__write>
 8001712:	02c00513          	li	a0,44
 8001716:	6499                	lui	s1,0x6
 8001718:	378d                	jal	800167a <dp__cmd>
 800171a:	4401                	li	s0,0
 800171c:	40048493          	addi	s1,s1,1024 # 6400 <__bootloader+0x5400>
 8001720:	008907b3          	add	a5,s2,s0
 8001724:	0007c503          	lbu	a0,0(a5)
 8001728:	0405                	addi	s0,s0,1
 800172a:	3789                	jal	800166c <dp__write>
 800172c:	fe941ae3          	bne	s0,s1,8001720 <dp_imagefill565+0x5e>
 8001730:	4422                	lw	s0,8(sp)
 8001732:	40b2                	lw	ra,12(sp)
 8001734:	4492                	lw	s1,4(sp)
 8001736:	4902                	lw	s2,0(sp)
 8001738:	0141                	addi	sp,sp,16
 800173a:	bf85                	j	80016aa <dp_cs_disable>

0800173c <dp_udelay>:
 800173c:	d10007b7          	lui	a5,0xd1000
 8001740:	4398                	lw	a4,0(a5)
 8001742:	47e1                	li	a5,24
 8001744:	02f50533          	mul	a0,a0,a5
 8001748:	d10006b7          	lui	a3,0xd1000
 800174c:	0505                	addi	a0,a0,1
 800174e:	429c                	lw	a5,0(a3)
 8001750:	8f99                	sub	a5,a5,a4
 8001752:	fea7eee3          	bltu	a5,a0,800174e <dp_udelay+0x12>
 8001756:	8082                	ret

08001758 <mandelfp>:
 8001758:	b9010113          	addi	sp,sp,-1136 # 20007b90 <__global_pointer$+0x7390>
 800175c:	080037b7          	lui	a5,0x8003
 8001760:	45512a23          	sw	s5,1108(sp)
 8001764:	ed87aa83          	lw	s5,-296(a5) # 8002ed8 <__clz_tab+0x100>
 8001768:	080037b7          	lui	a5,0x8003
 800176c:	45412c23          	sw	s4,1112(sp)
 8001770:	edc7aa03          	lw	s4,-292(a5) # 8002edc <__clz_tab+0x104>
 8001774:	080037b7          	lui	a5,0x8003
 8001778:	46912223          	sw	s1,1124(sp)
 800177c:	ee07a483          	lw	s1,-288(a5) # 8002ee0 <__clz_tab+0x108>
 8001780:	080037b7          	lui	a5,0x8003
 8001784:	46812423          	sw	s0,1128(sp)
 8001788:	ee47a403          	lw	s0,-284(a5) # 8002ee4 <__clz_tab+0x10c>
 800178c:	080037b7          	lui	a5,0x8003
 8001790:	ee87a783          	lw	a5,-280(a5) # 8002ee8 <__clz_tab+0x110>
 8001794:	7369                	lui	t1,0xffffa
 8001796:	45612823          	sw	s6,1104(sp)
 800179a:	45712623          	sw	s7,1100(sp)
 800179e:	46112623          	sw	ra,1132(sp)
 80017a2:	47212023          	sw	s2,1120(sp)
 80017a6:	45312e23          	sw	s3,1116(sp)
 80017aa:	45812423          	sw	s8,1096(sp)
 80017ae:	45912223          	sw	s9,1092(sp)
 80017b2:	45a12023          	sw	s10,1088(sp)
 80017b6:	43b12e23          	sw	s11,1084(sp)
 80017ba:	911a                	add	sp,sp,t1
 80017bc:	ca3e                	sw	a5,20(sp)
 80017be:	080037b7          	lui	a5,0x8003
 80017c2:	eec7a783          	lw	a5,-276(a5) # 8002eec <__clz_tab+0x114>
 80017c6:	5b7d                	li	s6,-1
 80017c8:	cc3e                	sw	a5,24(sp)
 80017ca:	080037b7          	lui	a5,0x8003
 80017ce:	ef07a783          	lw	a5,-272(a5) # 8002ef0 <__clz_tab+0x118>
 80017d2:	ce3e                	sw	a5,28(sp)
 80017d4:	080037b7          	lui	a5,0x8003
 80017d8:	ef47ab83          	lw	s7,-268(a5) # 8002ef4 <__clz_tab+0x11c>
 80017dc:	6799                	lui	a5,0x6
 80017de:	79e9                	lui	s3,0xffffa
 80017e0:	40078793          	addi	a5,a5,1024 # 6400 <__bootloader+0x5400>
 80017e4:	1818                	addi	a4,sp,48
 80017e6:	c0098993          	addi	s3,s3,-1024 # ffff9c00 <__stack+0xdfff1c00>
 80017ea:	97ba                	add	a5,a5,a4
 80017ec:	97ce                	add	a5,a5,s3
 80017ee:	41600b33          	neg	s6,s6
 80017f2:	4901                	li	s2,0
 80017f4:	d03e                	sw	a5,32(sp)
 80017f6:	854a                	mv	a0,s2
 80017f8:	32c010ef          	jal	ra,8002b24 <__floatsisf>
 80017fc:	45d2                	lw	a1,20(sp)
 80017fe:	4d79                	li	s10,30
 8001800:	0a000d93          	li	s11,160
 8001804:	33d000ef          	jal	ra,8002340 <__divsf3>
 8001808:	8c2a                	mv	s8,a0
 800180a:	855a                	mv	a0,s6
 800180c:	318010ef          	jal	ra,8002b24 <__floatsisf>
 8001810:	85aa                	mv	a1,a0
 8001812:	8562                	mv	a0,s8
 8001814:	579000ef          	jal	ra,800258c <__mulsf3>
 8001818:	8c2a                	mv	s8,a0
 800181a:	85aa                	mv	a1,a0
 800181c:	8522                	mv	a0,s0
 800181e:	78b000ef          	jal	ra,80027a8 <__subsf3>
 8001822:	85e2                	mv	a1,s8
 8001824:	842a                	mv	s0,a0
 8001826:	8552                	mv	a0,s4
 8001828:	00b000ef          	jal	ra,8002032 <__addsf3>
 800182c:	85e2                	mv	a1,s8
 800182e:	8a2a                	mv	s4,a0
 8001830:	8526                	mv	a0,s1
 8001832:	777000ef          	jal	ra,80027a8 <__subsf3>
 8001836:	85e2                	mv	a1,s8
 8001838:	84aa                	mv	s1,a0
 800183a:	8556                	mv	a0,s5
 800183c:	7f6000ef          	jal	ra,8002032 <__addsf3>
 8001840:	8aaa                	mv	s5,a0
 8001842:	85a2                	mv	a1,s0
 8001844:	8552                	mv	a0,s4
 8001846:	763000ef          	jal	ra,80027a8 <__subsf3>
 800184a:	45e2                	lw	a1,24(sp)
 800184c:	4c01                	li	s8,0
 800184e:	2f3000ef          	jal	ra,8002340 <__divsf3>
 8001852:	c62a                	sw	a0,12(sp)
 8001854:	85a6                	mv	a1,s1
 8001856:	8556                	mv	a0,s5
 8001858:	751000ef          	jal	ra,80027a8 <__subsf3>
 800185c:	45f2                	lw	a1,28(sp)
 800185e:	2e3000ef          	jal	ra,8002340 <__divsf3>
 8001862:	6799                	lui	a5,0x6
 8001864:	40078793          	addi	a5,a5,1024 # 6400 <__bootloader+0x5400>
 8001868:	1818                	addi	a4,sp,48
 800186a:	97ba                	add	a5,a5,a4
 800186c:	c82a                	sw	a0,16(sp)
 800186e:	01378cb3          	add	s9,a5,s3
 8001872:	8562                	mv	a0,s8
 8001874:	2b0010ef          	jal	ra,8002b24 <__floatsisf>
 8001878:	45c2                	lw	a1,16(sp)
 800187a:	513000ef          	jal	ra,800258c <__mulsf3>
 800187e:	85a6                	mv	a1,s1
 8001880:	7b2000ef          	jal	ra,8002032 <__addsf3>
 8001884:	85de                	mv	a1,s7
 8001886:	507000ef          	jal	ra,800258c <__mulsf3>
 800188a:	23a010ef          	jal	ra,8002ac4 <__fixsfsi>
 800188e:	832a                	mv	t1,a0
 8001890:	8866                	mv	a6,s9
 8001892:	4601                	li	a2,0
 8001894:	8532                	mv	a0,a2
 8001896:	d642                	sw	a6,44(sp)
 8001898:	d41a                	sw	t1,40(sp)
 800189a:	d232                	sw	a2,36(sp)
 800189c:	288010ef          	jal	ra,8002b24 <__floatsisf>
 80018a0:	45b2                	lw	a1,12(sp)
 80018a2:	4eb000ef          	jal	ra,800258c <__mulsf3>
 80018a6:	85a2                	mv	a1,s0
 80018a8:	78a000ef          	jal	ra,8002032 <__addsf3>
 80018ac:	080037b7          	lui	a5,0x8003
 80018b0:	ef47a583          	lw	a1,-268(a5) # 8002ef4 <__clz_tab+0x11c>
 80018b4:	4d9000ef          	jal	ra,800258c <__mulsf3>
 80018b8:	20c010ef          	jal	ra,8002ac4 <__fixsfsi>
 80018bc:	5612                	lw	a2,36(sp)
 80018be:	5322                	lw	t1,40(sp)
 80018c0:	5832                	lw	a6,44(sp)
 80018c2:	4701                	li	a4,0
 80018c4:	4781                	li	a5,0
 80018c6:	4581                	li	a1,0
 80018c8:	0705                	addi	a4,a4,1
 80018ca:	01a71463          	bne	a4,s10,80018d2 <mandelfp+0x17a>
 80018ce:	4705                	li	a4,1
 80018d0:	a815                	j	8001904 <mandelfp+0x1ac>
 80018d2:	00b78e33          	add	t3,a5,a1
 80018d6:	8d9d                	sub	a1,a1,a5
 80018d8:	02be05b3          	mul	a1,t3,a1
 80018dc:	66a1                	lui	a3,0x8
 80018de:	85b5                	srai	a1,a1,0xd
 80018e0:	95aa                	add	a1,a1,a0
 80018e2:	02b787b3          	mul	a5,a5,a1
 80018e6:	87b5                	srai	a5,a5,0xd
 80018e8:	07ba                	slli	a5,a5,0xe
 80018ea:	87b5                	srai	a5,a5,0xd
 80018ec:	979a                	add	a5,a5,t1
 80018ee:	02b58e33          	mul	t3,a1,a1
 80018f2:	02f78eb3          	mul	t4,a5,a5
 80018f6:	40de5e13          	srai	t3,t3,0xd
 80018fa:	40dede93          	srai	t4,t4,0xd
 80018fe:	9e76                	add	t3,t3,t4
 8001900:	fcde44e3          	blt	t3,a3,80018c8 <mandelfp+0x170>
 8001904:	0ff77793          	andi	a5,a4,255
 8001908:	00f80023          	sb	a5,0(a6)
 800190c:	0786                	slli	a5,a5,0x1
 800190e:	00f800a3          	sb	a5,1(a6)
 8001912:	0605                	addi	a2,a2,1
 8001914:	0809                	addi	a6,a6,2
 8001916:	f7b61fe3          	bne	a2,s11,8001894 <mandelfp+0x13c>
 800191a:	0c05                	addi	s8,s8,1
 800191c:	05000793          	li	a5,80
 8001920:	140c8c93          	addi	s9,s9,320
 8001924:	f4fc17e3          	bne	s8,a5,8001872 <mandelfp+0x11a>
 8001928:	5502                	lw	a0,32(sp)
 800192a:	0905                	addi	s2,s2,1
 800192c:	3b59                	jal	80016c2 <dp_imagefill565>
 800192e:	0c800793          	li	a5,200
 8001932:	ecf912e3          	bne	s2,a5,80017f6 <mandelfp+0x9e>
 8001936:	b55d                	j	80017dc <mandelfp+0x84>

08001938 <acm_handle_rx>:
 8001938:	200007b7          	lui	a5,0x20000
 800193c:	05c78793          	addi	a5,a5,92 # 2000005c <acm_outbuf>
 8001940:	50002737          	lui	a4,0x50002
 8001944:	4691                	li	a3,4
 8001946:	4310                	lw	a2,0(a4)
 8001948:	c390                	sw	a2,0(a5)
 800194a:	00b6f563          	bgeu	a3,a1,8001954 <acm_handle_rx+0x1c>
 800194e:	15f1                	addi	a1,a1,-4
 8001950:	0791                	addi	a5,a5,4
 8001952:	bfd5                	j	8001946 <acm_handle_rx+0xe>
 8001954:	8082                	ret

08001956 <usbfs_handle_rx0>:
 8001956:	c50d                	beqz	a0,8001980 <usbfs_handle_rx0+0x2a>
 8001958:	47a1                	li	a5,8
 800195a:	50001737          	lui	a4,0x50001
 800195e:	04b7e763          	bltu	a5,a1,80019ac <usbfs_handle_rx0+0x56>
 8001962:	50001737          	lui	a4,0x50001
 8001966:	4314                	lw	a3,0(a4)
 8001968:	200007b7          	lui	a5,0x20000
 800196c:	01478793          	addi	a5,a5,20 # 20000014 <usbfs_outbuf>
 8001970:	c394                	sw	a3,0(a5)
 8001972:	4318                	lw	a4,0(a4)
 8001974:	00878693          	addi	a3,a5,8
 8001978:	08d7a423          	sw	a3,136(a5)
 800197c:	c3d8                	sw	a4,4(a5)
 800197e:	8082                	ret
 8001980:	20000737          	lui	a4,0x20000
 8001984:	01470793          	addi	a5,a4,20 # 20000014 <usbfs_outbuf>
 8001988:	0887a783          	lw	a5,136(a5)
 800198c:	01470713          	addi	a4,a4,20
 8001990:	50001637          	lui	a2,0x50001
 8001994:	0791                	addi	a5,a5,4
 8001996:	4511                	li	a0,4
 8001998:	00062803          	lw	a6,0(a2) # 50001000 <__stack+0x2fff9000>
 800199c:	86be                	mv	a3,a5
 800199e:	0791                	addi	a5,a5,4
 80019a0:	ff07ac23          	sw	a6,-8(a5)
 80019a4:	00b57763          	bgeu	a0,a1,80019b2 <usbfs_handle_rx0+0x5c>
 80019a8:	15f1                	addi	a1,a1,-4
 80019aa:	b7fd                	j	8001998 <usbfs_handle_rx0+0x42>
 80019ac:	4314                	lw	a3,0(a4)
 80019ae:	15f1                	addi	a1,a1,-4
 80019b0:	b77d                	j	800195e <usbfs_handle_rx0+0x8>
 80019b2:	08d72423          	sw	a3,136(a4)
 80019b6:	8082                	ret

080019b8 <acm_get_line_coding>:
 80019b8:	200007b7          	lui	a5,0x20000
 80019bc:	00878793          	addi	a5,a5,8 # 20000008 <acm_line_coding>
 80019c0:	c19c                	sw	a5,0(a1)
 80019c2:	451d                	li	a0,7
 80019c4:	8082                	ret

080019c6 <acm_set_line_coding>:
 80019c6:	4198                	lw	a4,0(a1)
 80019c8:	200007b7          	lui	a5,0x20000
 80019cc:	00878793          	addi	a5,a5,8 # 20000008 <acm_line_coding>
 80019d0:	4314                	lw	a3,0(a4)
 80019d2:	4501                	li	a0,0
 80019d4:	c394                	sw	a3,0(a5)
 80019d6:	00474683          	lbu	a3,4(a4)
 80019da:	00d78223          	sb	a3,4(a5)
 80019de:	00574683          	lbu	a3,5(a4)
 80019e2:	00674703          	lbu	a4,6(a4)
 80019e6:	00d782a3          	sb	a3,5(a5)
 80019ea:	00e78323          	sb	a4,6(a5)
 80019ee:	8082                	ret

080019f0 <acm_set_control_line_state>:
 80019f0:	4501                	li	a0,0
 80019f2:	8082                	ret

080019f4 <usbfs_handle_clear_feature_endpoint>:
 80019f4:	557d                	li	a0,-1
 80019f6:	8082                	ret

080019f8 <usbfs_handle_set_interface0>:
 80019f8:	00255503          	lhu	a0,2(a0)
 80019fc:	00a03533          	snez	a0,a0
 8001a00:	40a00533          	neg	a0,a0
 8001a04:	8082                	ret

08001a06 <usbfs_handle_get_configuration>:
 8001a06:	080037b7          	lui	a5,0x8003
 8001a0a:	c8978793          	addi	a5,a5,-887 # 8002c89 <usbfs_descriptor_configuration1+0x5>
 8001a0e:	c19c                	sw	a5,0(a1)
 8001a10:	4505                	li	a0,1
 8001a12:	8082                	ret

08001a14 <usbfs_handle_get_descriptor>:
 8001a14:	00255783          	lhu	a5,2(a0)
 8001a18:	4689                	li	a3,2
 8001a1a:	0087d713          	srli	a4,a5,0x8
 8001a1e:	0ff7f793          	andi	a5,a5,255
 8001a22:	02d70163          	beq	a4,a3,8001a44 <usbfs_handle_get_descriptor+0x30>
 8001a26:	468d                	li	a3,3
 8001a28:	02d70863          	beq	a4,a3,8001a58 <usbfs_handle_get_descriptor+0x44>
 8001a2c:	4685                	li	a3,1
 8001a2e:	557d                	li	a0,-1
 8001a30:	04d71263          	bne	a4,a3,8001a74 <usbfs_handle_get_descriptor+0x60>
 8001a34:	e3a1                	bnez	a5,8001a74 <usbfs_handle_get_descriptor+0x60>
 8001a36:	080037b7          	lui	a5,0x8003
 8001a3a:	cd078793          	addi	a5,a5,-816 # 8002cd0 <usbfs_descriptor_device>
 8001a3e:	c19c                	sw	a5,0(a1)
 8001a40:	4549                	li	a0,18
 8001a42:	8082                	ret
 8001a44:	557d                	li	a0,-1
 8001a46:	e79d                	bnez	a5,8001a74 <usbfs_handle_get_descriptor+0x60>
 8001a48:	080037b7          	lui	a5,0x8003
 8001a4c:	c8478793          	addi	a5,a5,-892 # 8002c84 <usbfs_descriptor_configuration1>
 8001a50:	c19c                	sw	a5,0(a1)
 8001a52:	04b00513          	li	a0,75
 8001a56:	8082                	ret
 8001a58:	557d                	li	a0,-1
 8001a5a:	00f76d63          	bltu	a4,a5,8001a74 <usbfs_handle_get_descriptor+0x60>
 8001a5e:	08003737          	lui	a4,0x8003
 8001a62:	078a                	slli	a5,a5,0x2
 8001a64:	c1c70713          	addi	a4,a4,-996 # 8002c1c <usbfs_setup_handlers>
 8001a68:	97ba                	add	a5,a5,a4
 8001a6a:	0c87a783          	lw	a5,200(a5)
 8001a6e:	c19c                	sw	a5,0(a1)
 8001a70:	0007c503          	lbu	a0,0(a5)
 8001a74:	8082                	ret

08001a76 <usbfs_handle_set_address>:
 8001a76:	500016b7          	lui	a3,0x50001
 8001a7a:	00255783          	lhu	a5,2(a0)
 8001a7e:	8006a703          	lw	a4,-2048(a3) # 50000800 <__stack+0x2fff8800>
 8001a82:	4501                	li	a0,0
 8001a84:	0792                	slli	a5,a5,0x4
 8001a86:	80f77713          	andi	a4,a4,-2033
 8001a8a:	8fd9                	or	a5,a5,a4
 8001a8c:	80f6a023          	sw	a5,-2048(a3)
 8001a90:	8082                	ret

08001a92 <usbfs_handle_get_status_device>:
 8001a92:	200007b7          	lui	a5,0x20000
 8001a96:	00478793          	addi	a5,a5,4 # 20000004 <usbfs_status>
 8001a9a:	c19c                	sw	a5,0(a1)
 8001a9c:	4509                	li	a0,2
 8001a9e:	8082                	ret

08001aa0 <usbfs_ep_reset>:
 8001aa0:	500017b7          	lui	a5,0x50001
 8001aa4:	00200637          	lui	a2,0x200
 8001aa8:	90c7a023          	sw	a2,-1792(a5) # 50000900 <__stack+0x2fff8900>
 8001aac:	05b00713          	li	a4,91
 8001ab0:	90e7a423          	sw	a4,-1784(a5)
 8001ab4:	080006b7          	lui	a3,0x8000
 8001ab8:	92d7a023          	sw	a3,-1760(a5)
 8001abc:	92e7a423          	sw	a4,-1752(a5)
 8001ac0:	9207a823          	sw	zero,-1744(a5)
 8001ac4:	94d7a023          	sw	a3,-1728(a5)
 8001ac8:	94e7a423          	sw	a4,-1720(a5)
 8001acc:	9407a823          	sw	zero,-1712(a5)
 8001ad0:	96d7a023          	sw	a3,-1696(a5)
 8001ad4:	96e7a423          	sw	a4,-1688(a5)
 8001ad8:	9607a823          	sw	zero,-1680(a5)
 8001adc:	b0c7a023          	sw	a2,-1280(a5)
 8001ae0:	b0e7a423          	sw	a4,-1272(a5)
 8001ae4:	b2d7a023          	sw	a3,-1248(a5)
 8001ae8:	b2e7a423          	sw	a4,-1240(a5)
 8001aec:	b207a823          	sw	zero,-1232(a5)
 8001af0:	b4d7a023          	sw	a3,-1216(a5)
 8001af4:	b4e7a423          	sw	a4,-1208(a5)
 8001af8:	b407a823          	sw	zero,-1200(a5)
 8001afc:	b6d7a023          	sw	a3,-1184(a5)
 8001b00:	b6e7a423          	sw	a4,-1176(a5)
 8001b04:	b607a823          	sw	zero,-1168(a5)
 8001b08:	8082                	ret

08001b0a <usbfs_txfifos_flush>:
 8001b0a:	50000737          	lui	a4,0x50000
 8001b0e:	4b1c                	lw	a5,16(a4)
 8001b10:	4207e793          	ori	a5,a5,1056
 8001b14:	cb1c                	sw	a5,16(a4)
 8001b16:	4b1c                	lw	a5,16(a4)
 8001b18:	0207f793          	andi	a5,a5,32
 8001b1c:	ffed                	bnez	a5,8001b16 <usbfs_txfifos_flush+0xc>
 8001b1e:	450d                	li	a0,3
 8001b20:	b931                	j	800173c <dp_udelay>

08001b22 <usbfs_ep0out_prepare_out>:
 8001b22:	200007b7          	lui	a5,0x20000
 8001b26:	0a87a783          	lw	a5,168(a5) # 200000a8 <usbfs_state+0xc>
 8001b2a:	60080737          	lui	a4,0x60080
 8001b2e:	840006b7          	lui	a3,0x84000
 8001b32:	8f5d                	or	a4,a4,a5
 8001b34:	500017b7          	lui	a5,0x50001
 8001b38:	b0e7a823          	sw	a4,-1264(a5) # 50000b10 <__stack+0x2fff8b10>
 8001b3c:	b007a703          	lw	a4,-1280(a5)
 8001b40:	8f55                	or	a4,a4,a3
 8001b42:	b0e7a023          	sw	a4,-1280(a5)
 8001b46:	8082                	ret

08001b48 <usbfs_ep0out_prepare_setup>:
 8001b48:	500017b7          	lui	a5,0x50001
 8001b4c:	60000737          	lui	a4,0x60000
 8001b50:	b0e7a823          	sw	a4,-1264(a5) # 50000b10 <__stack+0x2fff8b10>
 8001b54:	b007a703          	lw	a4,-1280(a5)
 8001b58:	802006b7          	lui	a3,0x80200
 8001b5c:	8f55                	or	a4,a4,a3
 8001b5e:	b0e7a023          	sw	a4,-1280(a5)
 8001b62:	8082                	ret

08001b64 <usbfs_ep0in_transfer>:
 8001b64:	20000737          	lui	a4,0x20000
 8001b68:	01470713          	addi	a4,a4,20 # 20000014 <usbfs_outbuf>
 8001b6c:	09072683          	lw	a3,144(a4)
 8001b70:	08c72783          	lw	a5,140(a4)
 8001b74:	09472703          	lw	a4,148(a4)
 8001b78:	00e6f363          	bgeu	a3,a4,8001b7e <usbfs_ep0in_transfer+0x1a>
 8001b7c:	8736                	mv	a4,a3
 8001b7e:	000806b7          	lui	a3,0x80
 8001b82:	00e78533          	add	a0,a5,a4
 8001b86:	8f55                	or	a4,a4,a3
 8001b88:	500016b7          	lui	a3,0x50001
 8001b8c:	90e6a823          	sw	a4,-1776(a3) # 50000910 <__stack+0x2fff8910>
 8001b90:	9006a703          	lw	a4,-1792(a3)
 8001b94:	84000637          	lui	a2,0x84000
 8001b98:	50001837          	lui	a6,0x50001
 8001b9c:	8f51                	or	a4,a4,a2
 8001b9e:	90e6a023          	sw	a4,-1792(a3)
 8001ba2:	00a7e363          	bltu	a5,a0,8001ba8 <usbfs_ep0in_transfer+0x44>
 8001ba6:	8082                	ret
 8001ba8:	00178693          	addi	a3,a5,1
 8001bac:	0007c703          	lbu	a4,0(a5)
 8001bb0:	02a6f663          	bgeu	a3,a0,8001bdc <usbfs_ep0in_transfer+0x78>
 8001bb4:	0017c603          	lbu	a2,1(a5)
 8001bb8:	00278693          	addi	a3,a5,2
 8001bbc:	0622                	slli	a2,a2,0x8
 8001bbe:	00e665b3          	or	a1,a2,a4
 8001bc2:	01059713          	slli	a4,a1,0x10
 8001bc6:	8341                	srli	a4,a4,0x10
 8001bc8:	00a6fa63          	bgeu	a3,a0,8001bdc <usbfs_ep0in_transfer+0x78>
 8001bcc:	0027c603          	lbu	a2,2(a5)
 8001bd0:	00378693          	addi	a3,a5,3
 8001bd4:	0642                	slli	a2,a2,0x10
 8001bd6:	00a6e763          	bltu	a3,a0,8001be4 <usbfs_ep0in_transfer+0x80>
 8001bda:	8f51                	or	a4,a4,a2
 8001bdc:	00e82023          	sw	a4,0(a6) # 50001000 <__stack+0x2fff9000>
 8001be0:	87b6                	mv	a5,a3
 8001be2:	b7c1                	j	8001ba2 <usbfs_ep0in_transfer+0x3e>
 8001be4:	0037c703          	lbu	a4,3(a5)
 8001be8:	00478693          	addi	a3,a5,4
 8001bec:	8e4d                	or	a2,a2,a1
 8001bee:	0762                	slli	a4,a4,0x18
 8001bf0:	b7ed                	j	8001bda <usbfs_ep0in_transfer+0x76>

08001bf2 <usbfs_handle_ep0>:
 8001bf2:	1101                	addi	sp,sp,-32
 8001bf4:	ca26                	sw	s1,20(sp)
 8001bf6:	500014b7          	lui	s1,0x50001
 8001bfa:	b084a783          	lw	a5,-1272(s1) # 50000b08 <__stack+0x2fff8b08>
 8001bfe:	9084a703          	lw	a4,-1784(s1)
 8001c02:	cc22                	sw	s0,24(sp)
 8001c04:	ce06                	sw	ra,28(sp)
 8001c06:	c84a                	sw	s2,16(sp)
 8001c08:	b0f4a423          	sw	a5,-1272(s1)
 8001c0c:	20000437          	lui	s0,0x20000
 8001c10:	90e4a423          	sw	a4,-1784(s1)
 8001c14:	0087f693          	andi	a3,a5,8
 8001c18:	01440413          	addi	s0,s0,20 # 20000014 <usbfs_outbuf>
 8001c1c:	c6c1                	beqz	a3,8001ca4 <usbfs_handle_ep0+0xb2>
 8001c1e:	00040783          	lb	a5,0(s0)
 8001c22:	08042823          	sw	zero,144(s0)
 8001c26:	0207d363          	bgez	a5,8001c4c <usbfs_handle_ep0+0x5a>
 8001c2a:	0068                	addi	a0,sp,12
 8001c2c:	3af1                	jal	8001608 <usbfs_setup_handler_run.constprop.2>
 8001c2e:	06054063          	bltz	a0,8001c8e <usbfs_handle_ep0+0x9c>
 8001c32:	00645783          	lhu	a5,6(s0)
 8001c36:	00f55363          	bge	a0,a5,8001c3c <usbfs_handle_ep0+0x4a>
 8001c3a:	87aa                	mv	a5,a0
 8001c3c:	4732                	lw	a4,12(sp)
 8001c3e:	08f42823          	sw	a5,144(s0)
 8001c42:	08e42623          	sw	a4,140(s0)
 8001c46:	3f39                	jal	8001b64 <usbfs_ep0in_transfer>
 8001c48:	3de9                	jal	8001b22 <usbfs_ep0out_prepare_out>
 8001c4a:	a825                	j	8001c82 <usbfs_handle_ep0+0x90>
 8001c4c:	00645783          	lhu	a5,6(s0)
 8001c50:	e385                	bnez	a5,8001c70 <usbfs_handle_ep0+0x7e>
 8001c52:	0068                	addi	a0,sp,12
 8001c54:	3a55                	jal	8001608 <usbfs_setup_handler_run.constprop.2>
 8001c56:	ed05                	bnez	a0,8001c8e <usbfs_handle_ep0+0x9c>
 8001c58:	000807b7          	lui	a5,0x80
 8001c5c:	90f4a823          	sw	a5,-1776(s1)
 8001c60:	9004a783          	lw	a5,-1792(s1)
 8001c64:	84000737          	lui	a4,0x84000
 8001c68:	8fd9                	or	a5,a5,a4
 8001c6a:	90f4a023          	sw	a5,-1792(s1)
 8001c6e:	a80d                	j	8001ca0 <usbfs_handle_ep0+0xae>
 8001c70:	04000713          	li	a4,64
 8001c74:	00f76d63          	bltu	a4,a5,8001c8e <usbfs_handle_ep0+0x9c>
 8001c78:	356d                	jal	8001b22 <usbfs_ep0out_prepare_out>
 8001c7a:	00645783          	lhu	a5,6(s0)
 8001c7e:	08f42823          	sw	a5,144(s0)
 8001c82:	40f2                	lw	ra,28(sp)
 8001c84:	4462                	lw	s0,24(sp)
 8001c86:	44d2                	lw	s1,20(sp)
 8001c88:	4942                	lw	s2,16(sp)
 8001c8a:	6105                	addi	sp,sp,32
 8001c8c:	8082                	ret
 8001c8e:	50001737          	lui	a4,0x50001
 8001c92:	90072783          	lw	a5,-1792(a4) # 50000900 <__stack+0x2fff8900>
 8001c96:	002006b7          	lui	a3,0x200
 8001c9a:	8fd5                	or	a5,a5,a3
 8001c9c:	90f72023          	sw	a5,-1792(a4)
 8001ca0:	3565                	jal	8001b48 <usbfs_ep0out_prepare_setup>
 8001ca2:	b7c5                	j	8001c82 <usbfs_handle_ep0+0x90>
 8001ca4:	09042683          	lw	a3,144(s0)
 8001ca8:	dee9                	beqz	a3,8001c82 <usbfs_handle_ep0+0x90>
 8001caa:	8b05                	andi	a4,a4,1
 8001cac:	c31d                	beqz	a4,8001cd2 <usbfs_handle_ep0+0xe0>
 8001cae:	09442783          	lw	a5,148(s0)
 8001cb2:	00d7fd63          	bgeu	a5,a3,8001ccc <usbfs_handle_ep0+0xda>
 8001cb6:	08c42703          	lw	a4,140(s0)
 8001cba:	973e                	add	a4,a4,a5
 8001cbc:	40f687b3          	sub	a5,a3,a5
 8001cc0:	08e42623          	sw	a4,140(s0)
 8001cc4:	08f42823          	sw	a5,144(s0)
 8001cc8:	3d71                	jal	8001b64 <usbfs_ep0in_transfer>
 8001cca:	bf65                	j	8001c82 <usbfs_handle_ep0+0x90>
 8001ccc:	08042823          	sw	zero,144(s0)
 8001cd0:	bf4d                	j	8001c82 <usbfs_handle_ep0+0x90>
 8001cd2:	8b85                	andi	a5,a5,1
 8001cd4:	d7dd                	beqz	a5,8001c82 <usbfs_handle_ep0+0x90>
 8001cd6:	b104a703          	lw	a4,-1264(s1)
 8001cda:	09442603          	lw	a2,148(s0)
 8001cde:	00080937          	lui	s2,0x80
 8001ce2:	fff90793          	addi	a5,s2,-1 # 7ffff <__flash_size+0x5ffff>
 8001ce6:	8ff9                	and	a5,a5,a4
 8001ce8:	40f60733          	sub	a4,a2,a5
 8001cec:	00d77763          	bgeu	a4,a3,8001cfa <usbfs_handle_ep0+0x108>
 8001cf0:	8f91                	sub	a5,a5,a2
 8001cf2:	97b6                	add	a5,a5,a3
 8001cf4:	08f42823          	sw	a5,144(s0)
 8001cf8:	bf81                	j	8001c48 <usbfs_handle_ep0+0x56>
 8001cfa:	00840793          	addi	a5,s0,8
 8001cfe:	0068                	addi	a0,sp,12
 8001d00:	c63e                	sw	a5,12(sp)
 8001d02:	08042823          	sw	zero,144(s0)
 8001d06:	3209                	jal	8001608 <usbfs_setup_handler_run.constprop.2>
 8001d08:	e501                	bnez	a0,8001d10 <usbfs_handle_ep0+0x11e>
 8001d0a:	9124a823          	sw	s2,-1776(s1)
 8001d0e:	bf89                	j	8001c60 <usbfs_handle_ep0+0x6e>
 8001d10:	9004a783          	lw	a5,-1792(s1)
 8001d14:	00200737          	lui	a4,0x200
 8001d18:	bf81                	j	8001c68 <usbfs_handle_ep0+0x76>

08001d1a <acm_send>:
 8001d1a:	200006b7          	lui	a3,0x20000
 8001d1e:	200007b7          	lui	a5,0x20000
 8001d22:	0026d703          	lhu	a4,2(a3) # 20000002 <acm_inhead>
 8001d26:	0007d783          	lhu	a5,0(a5) # 20000000 <__data_end>
 8001d2a:	8636                	mv	a2,a3
 8001d2c:	0742                	slli	a4,a4,0x10
 8001d2e:	07c2                	slli	a5,a5,0x10
 8001d30:	8341                	srli	a4,a4,0x10
 8001d32:	83c1                	srli	a5,a5,0x10
 8001d34:	00f71863          	bne	a4,a5,8001d44 <acm_send+0x2a>
 8001d38:	200007b7          	lui	a5,0x20000
 8001d3c:	4705                	li	a4,1
 8001d3e:	00e78323          	sb	a4,6(a5) # 20000006 <acm_inidle>
 8001d42:	8082                	ret
 8001d44:	8f99                	sub	a5,a5,a4
 8001d46:	07c2                	slli	a5,a5,0x10
 8001d48:	83c1                	srli	a5,a5,0x10
 8001d4a:	3007f693          	andi	a3,a5,768
 8001d4e:	e2c1                	bnez	a3,8001dce <acm_send+0xb4>
 8001d50:	3ff7f793          	andi	a5,a5,1023
 8001d54:	0bf00693          	li	a3,191
 8001d58:	08f6e063          	bltu	a3,a5,8001dd8 <acm_send+0xbe>
 8001d5c:	07f00693          	li	a3,127
 8001d60:	08f6e163          	bltu	a3,a5,8001de2 <acm_send+0xc8>
 8001d64:	04000693          	li	a3,64
 8001d68:	00f6f463          	bgeu	a3,a5,8001d70 <acm_send+0x56>
 8001d6c:	04000793          	li	a5,64
 8001d70:	000806b7          	lui	a3,0x80
 8001d74:	8edd                	or	a3,a3,a5
 8001d76:	97ba                	add	a5,a5,a4
 8001d78:	3ff7f793          	andi	a5,a5,1023
 8001d7c:	01079593          	slli	a1,a5,0x10
 8001d80:	81c1                	srli	a1,a1,0x10
 8001d82:	00b61123          	sh	a1,2(a2) # 84000002 <__stack+0x63ff8002>
 8001d86:	50001637          	lui	a2,0x50001
 8001d8a:	92d62823          	sw	a3,-1744(a2) # 50000930 <__stack+0x2fff8930>
 8001d8e:	92062683          	lw	a3,-1760(a2)
 8001d92:	840005b7          	lui	a1,0x84000
 8001d96:	8ecd                	or	a3,a3,a1
 8001d98:	92d62023          	sw	a3,-1760(a2)
 8001d9c:	500026b7          	lui	a3,0x50002
 8001da0:	0705                	addi	a4,a4,1
 8001da2:	3ff77713          	andi	a4,a4,1023
 8001da6:	00e78f63          	beq	a5,a4,8001dc4 <acm_send+0xaa>
 8001daa:	0705                	addi	a4,a4,1
 8001dac:	3ff77713          	andi	a4,a4,1023
 8001db0:	00e78a63          	beq	a5,a4,8001dc4 <acm_send+0xaa>
 8001db4:	0705                	addi	a4,a4,1
 8001db6:	3ff77713          	andi	a4,a4,1023
 8001dba:	00e78563          	beq	a5,a4,8001dc4 <acm_send+0xaa>
 8001dbe:	0705                	addi	a4,a4,1
 8001dc0:	3ff77713          	andi	a4,a4,1023
 8001dc4:	0006a023          	sw	zero,0(a3) # 50002000 <__stack+0x2fffa000>
 8001dc8:	fcf71ce3          	bne	a4,a5,8001da0 <acm_send+0x86>
 8001dcc:	8082                	ret
 8001dce:	002006b7          	lui	a3,0x200
 8001dd2:	10000793          	li	a5,256
 8001dd6:	bf79                	j	8001d74 <acm_send+0x5a>
 8001dd8:	001806b7          	lui	a3,0x180
 8001ddc:	0c000793          	li	a5,192
 8001de0:	bf51                	j	8001d74 <acm_send+0x5a>
 8001de2:	001006b7          	lui	a3,0x100
 8001de6:	08000793          	li	a5,128
 8001dea:	b769                	j	8001d74 <acm_send+0x5a>

08001dec <acm_handle_ep>:
 8001dec:	50001737          	lui	a4,0x50001
 8001df0:	b2872783          	lw	a5,-1240(a4) # 50000b28 <__stack+0x2fff8b28>
 8001df4:	b2f72423          	sw	a5,-1240(a4)
 8001df8:	8b85                	andi	a5,a5,1
 8001dfa:	cf81                	beqz	a5,8001e12 <acm_handle_ep+0x26>
 8001dfc:	b3072703          	lw	a4,-1232(a4)
 8001e00:	04000793          	li	a5,64
 8001e04:	8f99                	sub	a5,a5,a4
 8001e06:	0ff7f793          	andi	a5,a5,255
 8001e0a:	20000737          	lui	a4,0x20000
 8001e0e:	00f70823          	sb	a5,16(a4) # 20000010 <acm_outbytes>
 8001e12:	50001737          	lui	a4,0x50001
 8001e16:	92872783          	lw	a5,-1752(a4) # 50000928 <__stack+0x2fff8928>
 8001e1a:	92f72423          	sw	a5,-1752(a4)
 8001e1e:	8b85                	andi	a5,a5,1
 8001e20:	c391                	beqz	a5,8001e24 <acm_handle_ep+0x38>
 8001e22:	bde5                	j	8001d1a <acm_send>
 8001e24:	8082                	ret

08001e26 <usbfs_handle_set_configuration>:
 8001e26:	00255603          	lhu	a2,2(a0)
 8001e2a:	4785                	li	a5,1
 8001e2c:	06f61b63          	bne	a2,a5,8001ea2 <usbfs_handle_set_configuration+0x7c>
 8001e30:	1141                	addi	sp,sp,-16
 8001e32:	080c8737          	lui	a4,0x80c8
 8001e36:	c606                	sw	ra,12(sp)
 8001e38:	500017b7          	lui	a5,0x50001
 8001e3c:	0721                	addi	a4,a4,8
 8001e3e:	94e7a023          	sw	a4,-1728(a5) # 50000940 <__stack+0x2fff8940>
 8001e42:	08088737          	lui	a4,0x8088
 8001e46:	04070713          	addi	a4,a4,64 # 8088040 <__data_source+0x85104>
 8001e4a:	92e7a023          	sw	a4,-1760(a5)
 8001e4e:	00080737          	lui	a4,0x80
 8001e52:	04070713          	addi	a4,a4,64 # 80040 <__flash_size+0x60040>
 8001e56:	b2e7a823          	sw	a4,-1232(a5)
 8001e5a:	84088737          	lui	a4,0x84088
 8001e5e:	04070713          	addi	a4,a4,64 # 84088040 <__stack+0x64080040>
 8001e62:	b2e7a023          	sw	a4,-1248(a5)
 8001e66:	81c7a703          	lw	a4,-2020(a5)
 8001e6a:	000206b7          	lui	a3,0x20
 8001e6e:	0689                	addi	a3,a3,2
 8001e70:	8f55                	or	a4,a4,a3
 8001e72:	80e7ae23          	sw	a4,-2020(a5)
 8001e76:	200007b7          	lui	a5,0x20000
 8001e7a:	6709                	lui	a4,0x2
 8001e7c:	00878793          	addi	a5,a5,8 # 20000008 <acm_line_coding>
 8001e80:	58070713          	addi	a4,a4,1408 # 2580 <__bootloader+0x1580>
 8001e84:	c398                	sw	a4,0(a5)
 8001e86:	4721                	li	a4,8
 8001e88:	00079223          	sh	zero,4(a5)
 8001e8c:	00e78323          	sb	a4,6(a5)
 8001e90:	200007b7          	lui	a5,0x20000
 8001e94:	00c78323          	sb	a2,6(a5) # 20000006 <acm_inidle>
 8001e98:	3549                	jal	8001d1a <acm_send>
 8001e9a:	40b2                	lw	ra,12(sp)
 8001e9c:	4501                	li	a0,0
 8001e9e:	0141                	addi	sp,sp,16
 8001ea0:	8082                	ret
 8001ea2:	557d                	li	a0,-1
 8001ea4:	8082                	ret

08001ea6 <MTIMER_IRQHandler>:
 8001ea6:	400117b7          	lui	a5,0x40011
 8001eaa:	80078793          	addi	a5,a5,-2048 # 40010800 <__stack+0x20008800>
 8001eae:	47d8                	lw	a4,12(a5)
 8001eb0:	8b11                	andi	a4,a4,4
 8001eb2:	c315                	beqz	a4,8001ed6 <MTIMER_IRQHandler+0x30>
 8001eb4:	4711                	li	a4,4
 8001eb6:	cbd8                	sw	a4,20(a5)
 8001eb8:	d10006b7          	lui	a3,0xd1000
 8001ebc:	46d0                	lw	a2,12(a3)
 8001ebe:	4698                	lw	a4,8(a3)
 8001ec0:	016e37b7          	lui	a5,0x16e3
 8001ec4:	60078793          	addi	a5,a5,1536 # 16e3600 <__flash_size+0x16c3600>
 8001ec8:	97ba                	add	a5,a5,a4
 8001eca:	00e7b733          	sltu	a4,a5,a4
 8001ece:	9732                	add	a4,a4,a2
 8001ed0:	c6d8                	sw	a4,12(a3)
 8001ed2:	c69c                	sw	a5,8(a3)
 8001ed4:	8082                	ret
 8001ed6:	4711                	li	a4,4
 8001ed8:	cb98                	sw	a4,16(a5)
 8001eda:	bff9                	j	8001eb8 <MTIMER_IRQHandler+0x12>

08001edc <USBFS_IRQHandler>:
 8001edc:	1101                	addi	sp,sp,-32
 8001ede:	500007b7          	lui	a5,0x50000
 8001ee2:	cc22                	sw	s0,24(sp)
 8001ee4:	4bc0                	lw	s0,20(a5)
 8001ee6:	ca26                	sw	s1,20(sp)
 8001ee8:	080034b7          	lui	s1,0x8003
 8001eec:	c84a                	sw	s2,16(sp)
 8001eee:	c64e                	sw	s3,12(sp)
 8001ef0:	c452                	sw	s4,8(sp)
 8001ef2:	ce06                	sw	ra,28(sp)
 8001ef4:	50000937          	lui	s2,0x50000
 8001ef8:	001e09b7          	lui	s3,0x1e0
 8001efc:	fff40a37          	lui	s4,0xfff40
 8001f00:	c1c48493          	addi	s1,s1,-996 # 8002c1c <usbfs_setup_handlers>
 8001f04:	01047793          	andi	a5,s0,16
 8001f08:	e7a9                	bnez	a5,8001f52 <USBFS_IRQHandler+0x76>
 8001f0a:	000c07b7          	lui	a5,0xc0
 8001f0e:	8fe1                	and	a5,a5,s0
 8001f10:	c385                	beqz	a5,8001f30 <USBFS_IRQHandler+0x54>
 8001f12:	500017b7          	lui	a5,0x50001
 8001f16:	8187a483          	lw	s1,-2024(a5) # 50000818 <__stack+0x2fff8818>
 8001f1a:	67c1                	lui	a5,0x10
 8001f1c:	0785                	addi	a5,a5,1
 8001f1e:	8fe5                	and	a5,a5,s1
 8001f20:	c391                	beqz	a5,8001f24 <USBFS_IRQHandler+0x48>
 8001f22:	39c1                	jal	8001bf2 <usbfs_handle_ep0>
 8001f24:	000207b7          	lui	a5,0x20
 8001f28:	0789                	addi	a5,a5,2
 8001f2a:	8cfd                	and	s1,s1,a5
 8001f2c:	c091                	beqz	s1,8001f30 <USBFS_IRQHandler+0x54>
 8001f2e:	3d7d                	jal	8001dec <acm_handle_ep>
 8001f30:	6785                	lui	a5,0x1
 8001f32:	80078793          	addi	a5,a5,-2048 # 800 <__tbss_size+0x800>
 8001f36:	00f47733          	and	a4,s0,a5
 8001f3a:	c329                	beqz	a4,8001f7c <USBFS_IRQHandler+0xa0>
 8001f3c:	50000737          	lui	a4,0x50000
 8001f40:	cb5c                	sw	a5,20(a4)
 8001f42:	40f2                	lw	ra,28(sp)
 8001f44:	4462                	lw	s0,24(sp)
 8001f46:	44d2                	lw	s1,20(sp)
 8001f48:	4942                	lw	s2,16(sp)
 8001f4a:	49b2                	lw	s3,12(sp)
 8001f4c:	4a22                	lw	s4,8(sp)
 8001f4e:	6105                	addi	sp,sp,32
 8001f50:	8082                	ret
 8001f52:	02092783          	lw	a5,32(s2) # 50000020 <__stack+0x2fff8020>
 8001f56:	0047d593          	srli	a1,a5,0x4
 8001f5a:	7ff5f593          	andi	a1,a1,2047
 8001f5e:	cd81                	beqz	a1,8001f76 <USBFS_IRQHandler+0x9a>
 8001f60:	0137f533          	and	a0,a5,s3
 8001f64:	8bbd                	andi	a5,a5,15
 8001f66:	078e                	slli	a5,a5,0x3
 8001f68:	97a6                	add	a5,a5,s1
 8001f6a:	1347a783          	lw	a5,308(a5)
 8001f6e:	9552                	add	a0,a0,s4
 8001f70:	00153513          	seqz	a0,a0
 8001f74:	9782                	jalr	a5
 8001f76:	01492403          	lw	s0,20(s2)
 8001f7a:	b769                	j	8001f04 <USBFS_IRQHandler+0x28>
 8001f7c:	00045763          	bgez	s0,8001f8a <USBFS_IRQHandler+0xae>
 8001f80:	500007b7          	lui	a5,0x50000
 8001f84:	80000737          	lui	a4,0x80000
 8001f88:	cbd8                	sw	a4,20(a5)
 8001f8a:	01341793          	slli	a5,s0,0x13
 8001f8e:	0407d963          	bgez	a5,8001fe0 <USBFS_IRQHandler+0x104>
 8001f92:	500014b7          	lui	s1,0x50001
 8001f96:	8044a783          	lw	a5,-2044(s1) # 50000804 <__stack+0x2fff8804>
 8001f9a:	9bf9                	andi	a5,a5,-2
 8001f9c:	80f4a223          	sw	a5,-2044(s1)
 8001fa0:	36ad                	jal	8001b0a <usbfs_txfifos_flush>
 8001fa2:	3cfd                	jal	8001aa0 <usbfs_ep_reset>
 8001fa4:	8004a783          	lw	a5,-2048(s1)
 8001fa8:	04000713          	li	a4,64
 8001fac:	80f7f793          	andi	a5,a5,-2033
 8001fb0:	80f4a023          	sw	a5,-2048(s1)
 8001fb4:	67c1                	lui	a5,0x10
 8001fb6:	0785                	addi	a5,a5,1
 8001fb8:	80f4ae23          	sw	a5,-2020(s1)
 8001fbc:	47a5                	li	a5,9
 8001fbe:	80f4aa23          	sw	a5,-2028(s1)
 8001fc2:	4785                	li	a5,1
 8001fc4:	80f4a823          	sw	a5,-2032(s1)
 8001fc8:	200007b7          	lui	a5,0x20000
 8001fcc:	01478793          	addi	a5,a5,20 # 20000014 <usbfs_outbuf>
 8001fd0:	08e7aa23          	sw	a4,148(a5)
 8001fd4:	0807a823          	sw	zero,144(a5)
 8001fd8:	6705                	lui	a4,0x1
 8001fda:	500007b7          	lui	a5,0x50000
 8001fde:	cbd8                	sw	a4,20(a5)
 8001fe0:	01241793          	slli	a5,s0,0x12
 8001fe4:	f407dfe3          	bgez	a5,8001f42 <USBFS_IRQHandler+0x66>
 8001fe8:	500017b7          	lui	a5,0x50001
 8001fec:	8047a703          	lw	a4,-2044(a5) # 50000804 <__stack+0x2fff8804>
 8001ff0:	4699                	li	a3,6
 8001ff2:	10076713          	ori	a4,a4,256
 8001ff6:	80e7a223          	sw	a4,-2044(a5)
 8001ffa:	8087a703          	lw	a4,-2040(a5)
 8001ffe:	8b19                	andi	a4,a4,6
 8002000:	02d70363          	beq	a4,a3,8002026 <USBFS_IRQHandler+0x14a>
 8002004:	9007a703          	lw	a4,-1792(a5)
 8002008:	00376713          	ori	a4,a4,3
 800200c:	90e7a023          	sw	a4,-1792(a5)
 8002010:	b007a703          	lw	a4,-1280(a5)
 8002014:	00376713          	ori	a4,a4,3
 8002018:	b0e7a023          	sw	a4,-1280(a5)
 800201c:	200007b7          	lui	a5,0x20000
 8002020:	4721                	li	a4,8
 8002022:	0ae7a423          	sw	a4,168(a5) # 200000a8 <usbfs_state+0xc>
 8002026:	360d                	jal	8001b48 <usbfs_ep0out_prepare_setup>
 8002028:	500007b7          	lui	a5,0x50000
 800202c:	6709                	lui	a4,0x2
 800202e:	cbd8                	sw	a4,20(a5)
 8002030:	bf09                	j	8001f42 <USBFS_IRQHandler+0x66>

08002032 <__addsf3>:
 8002032:	00800737          	lui	a4,0x800
 8002036:	1141                	addi	sp,sp,-16
 8002038:	177d                	addi	a4,a4,-1
 800203a:	00a777b3          	and	a5,a4,a0
 800203e:	c226                	sw	s1,4(sp)
 8002040:	c04a                	sw	s2,0(sp)
 8002042:	01f55493          	srli	s1,a0,0x1f
 8002046:	01755913          	srli	s2,a0,0x17
 800204a:	0175d513          	srli	a0,a1,0x17
 800204e:	8f6d                	and	a4,a4,a1
 8002050:	0ff97913          	andi	s2,s2,255
 8002054:	0ff57513          	andi	a0,a0,255
 8002058:	c606                	sw	ra,12(sp)
 800205a:	c422                	sw	s0,8(sp)
 800205c:	81fd                	srli	a1,a1,0x1f
 800205e:	078e                	slli	a5,a5,0x3
 8002060:	070e                	slli	a4,a4,0x3
 8002062:	40a906b3          	sub	a3,s2,a0
 8002066:	12b49263          	bne	s1,a1,800218a <__addsf3+0x158>
 800206a:	06d05a63          	blez	a3,80020de <__addsf3+0xac>
 800206e:	e121                	bnez	a0,80020ae <__addsf3+0x7c>
 8002070:	26070963          	beqz	a4,80022e2 <__addsf3+0x2b0>
 8002074:	16fd                	addi	a3,a3,-1
 8002076:	e68d                	bnez	a3,80020a0 <__addsf3+0x6e>
 8002078:	97ba                	add	a5,a5,a4
 800207a:	854a                	mv	a0,s2
 800207c:	00579713          	slli	a4,a5,0x5
 8002080:	0c075963          	bgez	a4,8002152 <__addsf3+0x120>
 8002084:	0505                	addi	a0,a0,1
 8002086:	0ff00713          	li	a4,255
 800208a:	26e50263          	beq	a0,a4,80022ee <__addsf3+0x2bc>
 800208e:	7e000737          	lui	a4,0x7e000
 8002092:	0017f693          	andi	a3,a5,1
 8002096:	177d                	addi	a4,a4,-1
 8002098:	8385                	srli	a5,a5,0x1
 800209a:	8ff9                	and	a5,a5,a4
 800209c:	8fd5                	or	a5,a5,a3
 800209e:	a855                	j	8002152 <__addsf3+0x120>
 80020a0:	0ff00613          	li	a2,255
 80020a4:	00c91c63          	bne	s2,a2,80020bc <__addsf3+0x8a>
 80020a8:	0ff00513          	li	a0,255
 80020ac:	a05d                	j	8002152 <__addsf3+0x120>
 80020ae:	0ff00613          	li	a2,255
 80020b2:	fec90be3          	beq	s2,a2,80020a8 <__addsf3+0x76>
 80020b6:	04000637          	lui	a2,0x4000
 80020ba:	8f51                	or	a4,a4,a2
 80020bc:	466d                	li	a2,27
 80020be:	00d65463          	bge	a2,a3,80020c6 <__addsf3+0x94>
 80020c2:	4705                	li	a4,1
 80020c4:	bf55                	j	8002078 <__addsf3+0x46>
 80020c6:	02000613          	li	a2,32
 80020ca:	00d755b3          	srl	a1,a4,a3
 80020ce:	40d606b3          	sub	a3,a2,a3
 80020d2:	00d71733          	sll	a4,a4,a3
 80020d6:	00e03733          	snez	a4,a4
 80020da:	8f4d                	or	a4,a4,a1
 80020dc:	bf71                	j	8002078 <__addsf3+0x46>
 80020de:	c6b9                	beqz	a3,800212c <__addsf3+0xfa>
 80020e0:	41250633          	sub	a2,a0,s2
 80020e4:	00091d63          	bnez	s2,80020fe <__addsf3+0xcc>
 80020e8:	cb89                	beqz	a5,80020fa <__addsf3+0xc8>
 80020ea:	167d                	addi	a2,a2,-1
 80020ec:	e219                	bnez	a2,80020f2 <__addsf3+0xc0>
 80020ee:	97ba                	add	a5,a5,a4
 80020f0:	b771                	j	800207c <__addsf3+0x4a>
 80020f2:	0ff00693          	li	a3,255
 80020f6:	00d51b63          	bne	a0,a3,800210c <__addsf3+0xda>
 80020fa:	87ba                	mv	a5,a4
 80020fc:	a899                	j	8002152 <__addsf3+0x120>
 80020fe:	0ff00693          	li	a3,255
 8002102:	fed50ce3          	beq	a0,a3,80020fa <__addsf3+0xc8>
 8002106:	040006b7          	lui	a3,0x4000
 800210a:	8fd5                	or	a5,a5,a3
 800210c:	46ed                	li	a3,27
 800210e:	00c6d463          	bge	a3,a2,8002116 <__addsf3+0xe4>
 8002112:	4785                	li	a5,1
 8002114:	bfe9                	j	80020ee <__addsf3+0xbc>
 8002116:	02000693          	li	a3,32
 800211a:	8e91                	sub	a3,a3,a2
 800211c:	00c7d5b3          	srl	a1,a5,a2
 8002120:	00d797b3          	sll	a5,a5,a3
 8002124:	00f037b3          	snez	a5,a5
 8002128:	8fcd                	or	a5,a5,a1
 800212a:	b7d1                	j	80020ee <__addsf3+0xbc>
 800212c:	00190693          	addi	a3,s2,1
 8002130:	0fe6f513          	andi	a0,a3,254
 8002134:	e139                	bnez	a0,800217a <__addsf3+0x148>
 8002136:	02091963          	bnez	s2,8002168 <__addsf3+0x136>
 800213a:	d3e1                	beqz	a5,80020fa <__addsf3+0xc8>
 800213c:	cb19                	beqz	a4,8002152 <__addsf3+0x120>
 800213e:	97ba                	add	a5,a5,a4
 8002140:	00579713          	slli	a4,a5,0x5
 8002144:	00075763          	bgez	a4,8002152 <__addsf3+0x120>
 8002148:	fc000737          	lui	a4,0xfc000
 800214c:	177d                	addi	a4,a4,-1
 800214e:	8ff9                	and	a5,a5,a4
 8002150:	4505                	li	a0,1
 8002152:	0077f713          	andi	a4,a5,7
 8002156:	18070d63          	beqz	a4,80022f0 <__addsf3+0x2be>
 800215a:	00f7f713          	andi	a4,a5,15
 800215e:	4691                	li	a3,4
 8002160:	18d70863          	beq	a4,a3,80022f0 <__addsf3+0x2be>
 8002164:	0791                	addi	a5,a5,4
 8002166:	a269                	j	80022f0 <__addsf3+0x2be>
 8002168:	16078f63          	beqz	a5,80022e6 <__addsf3+0x2b4>
 800216c:	df15                	beqz	a4,80020a8 <__addsf3+0x76>
 800216e:	4481                	li	s1,0
 8002170:	020007b7          	lui	a5,0x2000
 8002174:	0ff00513          	li	a0,255
 8002178:	aaa5                	j	80022f0 <__addsf3+0x2be>
 800217a:	0ff00613          	li	a2,255
 800217e:	16c68663          	beq	a3,a2,80022ea <__addsf3+0x2b8>
 8002182:	97ba                	add	a5,a5,a4
 8002184:	8385                	srli	a5,a5,0x1
 8002186:	8536                	mv	a0,a3
 8002188:	b7e9                	j	8002152 <__addsf3+0x120>
 800218a:	06d05563          	blez	a3,80021f4 <__addsf3+0x1c2>
 800218e:	e91d                	bnez	a0,80021c4 <__addsf3+0x192>
 8002190:	854a                	mv	a0,s2
 8002192:	d361                	beqz	a4,8002152 <__addsf3+0x120>
 8002194:	16fd                	addi	a3,a3,-1
 8002196:	ee81                	bnez	a3,80021ae <__addsf3+0x17c>
 8002198:	8f99                	sub	a5,a5,a4
 800219a:	00579713          	slli	a4,a5,0x5
 800219e:	fa075ae3          	bgez	a4,8002152 <__addsf3+0x120>
 80021a2:	04000437          	lui	s0,0x4000
 80021a6:	147d                	addi	s0,s0,-1
 80021a8:	8c7d                	and	s0,s0,a5
 80021aa:	892a                	mv	s2,a0
 80021ac:	a8c5                	j	800229c <__addsf3+0x26a>
 80021ae:	0ff00613          	li	a2,255
 80021b2:	0ff00513          	li	a0,255
 80021b6:	f8c90ee3          	beq	s2,a2,8002152 <__addsf3+0x120>
 80021ba:	466d                	li	a2,27
 80021bc:	00d65e63          	bge	a2,a3,80021d8 <__addsf3+0x1a6>
 80021c0:	4705                	li	a4,1
 80021c2:	a035                	j	80021ee <__addsf3+0x1bc>
 80021c4:	0ff00613          	li	a2,255
 80021c8:	0ff00513          	li	a0,255
 80021cc:	f8c903e3          	beq	s2,a2,8002152 <__addsf3+0x120>
 80021d0:	04000637          	lui	a2,0x4000
 80021d4:	8f51                	or	a4,a4,a2
 80021d6:	b7d5                	j	80021ba <__addsf3+0x188>
 80021d8:	02000613          	li	a2,32
 80021dc:	00d755b3          	srl	a1,a4,a3
 80021e0:	40d606b3          	sub	a3,a2,a3
 80021e4:	00d71733          	sll	a4,a4,a3
 80021e8:	00e03733          	snez	a4,a4
 80021ec:	8f4d                	or	a4,a4,a1
 80021ee:	8f99                	sub	a5,a5,a4
 80021f0:	854a                	mv	a0,s2
 80021f2:	b765                	j	800219a <__addsf3+0x168>
 80021f4:	cab9                	beqz	a3,800224a <__addsf3+0x218>
 80021f6:	41250633          	sub	a2,a0,s2
 80021fa:	02091063          	bnez	s2,800221a <__addsf3+0x1e8>
 80021fe:	cb99                	beqz	a5,8002214 <__addsf3+0x1e2>
 8002200:	167d                	addi	a2,a2,-1
 8002202:	e609                	bnez	a2,800220c <__addsf3+0x1da>
 8002204:	40f707b3          	sub	a5,a4,a5
 8002208:	84ae                	mv	s1,a1
 800220a:	bf41                	j	800219a <__addsf3+0x168>
 800220c:	0ff00693          	li	a3,255
 8002210:	00d51c63          	bne	a0,a3,8002228 <__addsf3+0x1f6>
 8002214:	87ba                	mv	a5,a4
 8002216:	84ae                	mv	s1,a1
 8002218:	bf2d                	j	8002152 <__addsf3+0x120>
 800221a:	0ff00693          	li	a3,255
 800221e:	fed50be3          	beq	a0,a3,8002214 <__addsf3+0x1e2>
 8002222:	040006b7          	lui	a3,0x4000
 8002226:	8fd5                	or	a5,a5,a3
 8002228:	46ed                	li	a3,27
 800222a:	00c6d463          	bge	a3,a2,8002232 <__addsf3+0x200>
 800222e:	4785                	li	a5,1
 8002230:	bfd1                	j	8002204 <__addsf3+0x1d2>
 8002232:	02000693          	li	a3,32
 8002236:	8e91                	sub	a3,a3,a2
 8002238:	00c7d833          	srl	a6,a5,a2
 800223c:	00d797b3          	sll	a5,a5,a3
 8002240:	00f037b3          	snez	a5,a5
 8002244:	00f867b3          	or	a5,a6,a5
 8002248:	bf75                	j	8002204 <__addsf3+0x1d2>
 800224a:	00190513          	addi	a0,s2,1
 800224e:	0fe57513          	andi	a0,a0,254
 8002252:	ed05                	bnez	a0,800228a <__addsf3+0x258>
 8002254:	02091463          	bnez	s2,800227c <__addsf3+0x24a>
 8002258:	e789                	bnez	a5,8002262 <__addsf3+0x230>
 800225a:	ff4d                	bnez	a4,8002214 <__addsf3+0x1e2>
 800225c:	4781                	li	a5,0
 800225e:	4481                	li	s1,0
 8002260:	a841                	j	80022f0 <__addsf3+0x2be>
 8002262:	ee0708e3          	beqz	a4,8002152 <__addsf3+0x120>
 8002266:	40e786b3          	sub	a3,a5,a4
 800226a:	00569613          	slli	a2,a3,0x5
 800226e:	40f707b3          	sub	a5,a4,a5
 8002272:	fa0642e3          	bltz	a2,8002216 <__addsf3+0x1e4>
 8002276:	d2fd                	beqz	a3,800225c <__addsf3+0x22a>
 8002278:	87b6                	mv	a5,a3
 800227a:	bde1                	j	8002152 <__addsf3+0x120>
 800227c:	ee0798e3          	bnez	a5,800216c <__addsf3+0x13a>
 8002280:	ee0707e3          	beqz	a4,800216e <__addsf3+0x13c>
 8002284:	87ba                	mv	a5,a4
 8002286:	84ae                	mv	s1,a1
 8002288:	b505                	j	80020a8 <__addsf3+0x76>
 800228a:	40e78433          	sub	s0,a5,a4
 800228e:	00541693          	slli	a3,s0,0x5
 8002292:	0206dd63          	bgez	a3,80022cc <__addsf3+0x29a>
 8002296:	40f70433          	sub	s0,a4,a5
 800229a:	84ae                	mv	s1,a1
 800229c:	8522                	mv	a0,s0
 800229e:	141000ef          	jal	ra,8002bde <__clzsi2>
 80022a2:	156d                	addi	a0,a0,-5
 80022a4:	00a41433          	sll	s0,s0,a0
 80022a8:	03254663          	blt	a0,s2,80022d4 <__addsf3+0x2a2>
 80022ac:	41250533          	sub	a0,a0,s2
 80022b0:	0505                	addi	a0,a0,1
 80022b2:	02000713          	li	a4,32
 80022b6:	00a457b3          	srl	a5,s0,a0
 80022ba:	40a70533          	sub	a0,a4,a0
 80022be:	00a41433          	sll	s0,s0,a0
 80022c2:	00803433          	snez	s0,s0
 80022c6:	8fc1                	or	a5,a5,s0
 80022c8:	4501                	li	a0,0
 80022ca:	b561                	j	8002152 <__addsf3+0x120>
 80022cc:	f861                	bnez	s0,800229c <__addsf3+0x26a>
 80022ce:	4781                	li	a5,0
 80022d0:	4501                	li	a0,0
 80022d2:	b771                	j	800225e <__addsf3+0x22c>
 80022d4:	fc0007b7          	lui	a5,0xfc000
 80022d8:	17fd                	addi	a5,a5,-1
 80022da:	40a90533          	sub	a0,s2,a0
 80022de:	8fe1                	and	a5,a5,s0
 80022e0:	bd8d                	j	8002152 <__addsf3+0x120>
 80022e2:	854a                	mv	a0,s2
 80022e4:	b5bd                	j	8002152 <__addsf3+0x120>
 80022e6:	87ba                	mv	a5,a4
 80022e8:	b3c1                	j	80020a8 <__addsf3+0x76>
 80022ea:	0ff00513          	li	a0,255
 80022ee:	4781                	li	a5,0
 80022f0:	00579713          	slli	a4,a5,0x5
 80022f4:	00075b63          	bgez	a4,800230a <__addsf3+0x2d8>
 80022f8:	0505                	addi	a0,a0,1
 80022fa:	0ff00713          	li	a4,255
 80022fe:	02e50f63          	beq	a0,a4,800233c <__addsf3+0x30a>
 8002302:	fc000737          	lui	a4,0xfc000
 8002306:	177d                	addi	a4,a4,-1
 8002308:	8ff9                	and	a5,a5,a4
 800230a:	0ff00713          	li	a4,255
 800230e:	838d                	srli	a5,a5,0x3
 8002310:	00e51663          	bne	a0,a4,800231c <__addsf3+0x2ea>
 8002314:	c781                	beqz	a5,800231c <__addsf3+0x2ea>
 8002316:	004007b7          	lui	a5,0x400
 800231a:	4481                	li	s1,0
 800231c:	0ff57513          	andi	a0,a0,255
 8002320:	40b2                	lw	ra,12(sp)
 8002322:	4422                	lw	s0,8(sp)
 8002324:	07a6                	slli	a5,a5,0x9
 8002326:	01751713          	slli	a4,a0,0x17
 800232a:	0097d513          	srli	a0,a5,0x9
 800232e:	04fe                	slli	s1,s1,0x1f
 8002330:	8d59                	or	a0,a0,a4
 8002332:	8d45                	or	a0,a0,s1
 8002334:	4902                	lw	s2,0(sp)
 8002336:	4492                	lw	s1,4(sp)
 8002338:	0141                	addi	sp,sp,16
 800233a:	8082                	ret
 800233c:	4781                	li	a5,0
 800233e:	b7f1                	j	800230a <__addsf3+0x2d8>

08002340 <__divsf3>:
 8002340:	1101                	addi	sp,sp,-32
 8002342:	ca26                	sw	s1,20(sp)
 8002344:	01755493          	srli	s1,a0,0x17
 8002348:	c84a                	sw	s2,16(sp)
 800234a:	c64e                	sw	s3,12(sp)
 800234c:	c452                	sw	s4,8(sp)
 800234e:	00951993          	slli	s3,a0,0x9
 8002352:	ce06                	sw	ra,28(sp)
 8002354:	cc22                	sw	s0,24(sp)
 8002356:	c256                	sw	s5,4(sp)
 8002358:	0ff4f493          	andi	s1,s1,255
 800235c:	8a2e                	mv	s4,a1
 800235e:	0099d993          	srli	s3,s3,0x9
 8002362:	01f55913          	srli	s2,a0,0x1f
 8002366:	c4b5                	beqz	s1,80023d2 <__divsf3+0x92>
 8002368:	0ff00793          	li	a5,255
 800236c:	08f48063          	beq	s1,a5,80023ec <__divsf3+0xac>
 8002370:	098e                	slli	s3,s3,0x3
 8002372:	040007b7          	lui	a5,0x4000
 8002376:	00f9e9b3          	or	s3,s3,a5
 800237a:	f8148493          	addi	s1,s1,-127
 800237e:	4a81                	li	s5,0
 8002380:	017a5513          	srli	a0,s4,0x17
 8002384:	009a1413          	slli	s0,s4,0x9
 8002388:	0ff57513          	andi	a0,a0,255
 800238c:	8025                	srli	s0,s0,0x9
 800238e:	01fa5a13          	srli	s4,s4,0x1f
 8002392:	c53d                	beqz	a0,8002400 <__divsf3+0xc0>
 8002394:	0ff00793          	li	a5,255
 8002398:	08f50063          	beq	a0,a5,8002418 <__divsf3+0xd8>
 800239c:	040e                	slli	s0,s0,0x3
 800239e:	040007b7          	lui	a5,0x4000
 80023a2:	8c5d                	or	s0,s0,a5
 80023a4:	f8150513          	addi	a0,a0,-127
 80023a8:	4781                	li	a5,0
 80023aa:	002a9693          	slli	a3,s5,0x2
 80023ae:	8edd                	or	a3,a3,a5
 80023b0:	16fd                	addi	a3,a3,-1
 80023b2:	4739                	li	a4,14
 80023b4:	01494633          	xor	a2,s2,s4
 80023b8:	40a48533          	sub	a0,s1,a0
 80023bc:	06d76763          	bltu	a4,a3,800242a <__divsf3+0xea>
 80023c0:	00001597          	auipc	a1,0x1
 80023c4:	9a058593          	addi	a1,a1,-1632 # 8002d60 <usbfs_endpoints+0x10>
 80023c8:	068a                	slli	a3,a3,0x2
 80023ca:	96ae                	add	a3,a3,a1
 80023cc:	4298                	lw	a4,0(a3)
 80023ce:	972e                	add	a4,a4,a1
 80023d0:	8702                	jr	a4
 80023d2:	02098463          	beqz	s3,80023fa <__divsf3+0xba>
 80023d6:	854e                	mv	a0,s3
 80023d8:	007000ef          	jal	ra,8002bde <__clzsi2>
 80023dc:	ffb50793          	addi	a5,a0,-5
 80023e0:	f8a00493          	li	s1,-118
 80023e4:	00f999b3          	sll	s3,s3,a5
 80023e8:	8c89                	sub	s1,s1,a0
 80023ea:	bf51                	j	800237e <__divsf3+0x3e>
 80023ec:	0ff00493          	li	s1,255
 80023f0:	4a89                	li	s5,2
 80023f2:	f80987e3          	beqz	s3,8002380 <__divsf3+0x40>
 80023f6:	4a8d                	li	s5,3
 80023f8:	b761                	j	8002380 <__divsf3+0x40>
 80023fa:	4481                	li	s1,0
 80023fc:	4a85                	li	s5,1
 80023fe:	b749                	j	8002380 <__divsf3+0x40>
 8002400:	c015                	beqz	s0,8002424 <__divsf3+0xe4>
 8002402:	8522                	mv	a0,s0
 8002404:	2fe9                	jal	8002bde <__clzsi2>
 8002406:	ffb50793          	addi	a5,a0,-5
 800240a:	00f41433          	sll	s0,s0,a5
 800240e:	f8a00793          	li	a5,-118
 8002412:	40a78533          	sub	a0,a5,a0
 8002416:	bf49                	j	80023a8 <__divsf3+0x68>
 8002418:	0ff00513          	li	a0,255
 800241c:	4789                	li	a5,2
 800241e:	d451                	beqz	s0,80023aa <__divsf3+0x6a>
 8002420:	478d                	li	a5,3
 8002422:	b761                	j	80023aa <__divsf3+0x6a>
 8002424:	4501                	li	a0,0
 8002426:	4785                	li	a5,1
 8002428:	b749                	j	80023aa <__divsf3+0x6a>
 800242a:	00541813          	slli	a6,s0,0x5
 800242e:	0a89fe63          	bgeu	s3,s0,80024ea <__divsf3+0x1aa>
 8002432:	157d                	addi	a0,a0,-1
 8002434:	4681                	li	a3,0
 8002436:	01085413          	srli	s0,a6,0x10
 800243a:	0289d333          	divu	t1,s3,s0
 800243e:	67c1                	lui	a5,0x10
 8002440:	17fd                	addi	a5,a5,-1
 8002442:	00f877b3          	and	a5,a6,a5
 8002446:	82c1                	srli	a3,a3,0x10
 8002448:	0289f733          	remu	a4,s3,s0
 800244c:	859a                	mv	a1,t1
 800244e:	026788b3          	mul	a7,a5,t1
 8002452:	0742                	slli	a4,a4,0x10
 8002454:	8f55                	or	a4,a4,a3
 8002456:	01177c63          	bgeu	a4,a7,800246e <__divsf3+0x12e>
 800245a:	9742                	add	a4,a4,a6
 800245c:	fff30593          	addi	a1,t1,-1 # ffff9fff <__stack+0xdfff1fff>
 8002460:	01076763          	bltu	a4,a6,800246e <__divsf3+0x12e>
 8002464:	01177563          	bgeu	a4,a7,800246e <__divsf3+0x12e>
 8002468:	ffe30593          	addi	a1,t1,-2
 800246c:	9742                	add	a4,a4,a6
 800246e:	41170733          	sub	a4,a4,a7
 8002472:	028758b3          	divu	a7,a4,s0
 8002476:	02877733          	remu	a4,a4,s0
 800247a:	031786b3          	mul	a3,a5,a7
 800247e:	01071793          	slli	a5,a4,0x10
 8002482:	8746                	mv	a4,a7
 8002484:	00d7fc63          	bgeu	a5,a3,800249c <__divsf3+0x15c>
 8002488:	97c2                	add	a5,a5,a6
 800248a:	fff88713          	addi	a4,a7,-1
 800248e:	0107e763          	bltu	a5,a6,800249c <__divsf3+0x15c>
 8002492:	00d7f563          	bgeu	a5,a3,800249c <__divsf3+0x15c>
 8002496:	ffe88713          	addi	a4,a7,-2
 800249a:	97c2                	add	a5,a5,a6
 800249c:	01059413          	slli	s0,a1,0x10
 80024a0:	8f95                	sub	a5,a5,a3
 80024a2:	8c59                	or	s0,s0,a4
 80024a4:	00f037b3          	snez	a5,a5
 80024a8:	8c5d                	or	s0,s0,a5
 80024aa:	07f50713          	addi	a4,a0,127
 80024ae:	08e05a63          	blez	a4,8002542 <__divsf3+0x202>
 80024b2:	00747793          	andi	a5,s0,7
 80024b6:	c799                	beqz	a5,80024c4 <__divsf3+0x184>
 80024b8:	00f47793          	andi	a5,s0,15
 80024bc:	4691                	li	a3,4
 80024be:	00d78363          	beq	a5,a3,80024c4 <__divsf3+0x184>
 80024c2:	0411                	addi	s0,s0,4
 80024c4:	00441793          	slli	a5,s0,0x4
 80024c8:	0007d863          	bgez	a5,80024d8 <__divsf3+0x198>
 80024cc:	f80007b7          	lui	a5,0xf8000
 80024d0:	17fd                	addi	a5,a5,-1
 80024d2:	8c7d                	and	s0,s0,a5
 80024d4:	08050713          	addi	a4,a0,128
 80024d8:	0fe00793          	li	a5,254
 80024dc:	800d                	srli	s0,s0,0x3
 80024de:	02e7d963          	bge	a5,a4,8002510 <__divsf3+0x1d0>
 80024e2:	4401                	li	s0,0
 80024e4:	0ff00713          	li	a4,255
 80024e8:	a025                	j	8002510 <__divsf3+0x1d0>
 80024ea:	01f99693          	slli	a3,s3,0x1f
 80024ee:	0019d993          	srli	s3,s3,0x1
 80024f2:	b791                	j	8002436 <__divsf3+0xf6>
 80024f4:	864a                	mv	a2,s2
 80024f6:	844e                	mv	s0,s3
 80024f8:	87d6                	mv	a5,s5
 80024fa:	4709                	li	a4,2
 80024fc:	fee783e3          	beq	a5,a4,80024e2 <__divsf3+0x1a2>
 8002500:	470d                	li	a4,3
 8002502:	06e78f63          	beq	a5,a4,8002580 <__divsf3+0x240>
 8002506:	4705                	li	a4,1
 8002508:	fae791e3          	bne	a5,a4,80024aa <__divsf3+0x16a>
 800250c:	4401                	li	s0,0
 800250e:	4701                	li	a4,0
 8002510:	0426                	slli	s0,s0,0x9
 8002512:	0ff77713          	andi	a4,a4,255
 8002516:	075e                	slli	a4,a4,0x17
 8002518:	8025                	srli	s0,s0,0x9
 800251a:	8c59                	or	s0,s0,a4
 800251c:	01f61513          	slli	a0,a2,0x1f
 8002520:	8d41                	or	a0,a0,s0
 8002522:	40f2                	lw	ra,28(sp)
 8002524:	4462                	lw	s0,24(sp)
 8002526:	44d2                	lw	s1,20(sp)
 8002528:	4942                	lw	s2,16(sp)
 800252a:	49b2                	lw	s3,12(sp)
 800252c:	4a22                	lw	s4,8(sp)
 800252e:	4a92                	lw	s5,4(sp)
 8002530:	6105                	addi	sp,sp,32
 8002532:	8082                	ret
 8002534:	8652                	mv	a2,s4
 8002536:	b7d1                	j	80024fa <__divsf3+0x1ba>
 8002538:	00400437          	lui	s0,0x400
 800253c:	4601                	li	a2,0
 800253e:	478d                	li	a5,3
 8002540:	bf6d                	j	80024fa <__divsf3+0x1ba>
 8002542:	4785                	li	a5,1
 8002544:	8f99                	sub	a5,a5,a4
 8002546:	476d                	li	a4,27
 8002548:	fcf742e3          	blt	a4,a5,800250c <__divsf3+0x1cc>
 800254c:	09e50513          	addi	a0,a0,158
 8002550:	00f457b3          	srl	a5,s0,a5
 8002554:	00a41433          	sll	s0,s0,a0
 8002558:	00803433          	snez	s0,s0
 800255c:	8c5d                	or	s0,s0,a5
 800255e:	00747793          	andi	a5,s0,7
 8002562:	c799                	beqz	a5,8002570 <__divsf3+0x230>
 8002564:	00f47793          	andi	a5,s0,15
 8002568:	4711                	li	a4,4
 800256a:	00e78363          	beq	a5,a4,8002570 <__divsf3+0x230>
 800256e:	0411                	addi	s0,s0,4
 8002570:	00541793          	slli	a5,s0,0x5
 8002574:	800d                	srli	s0,s0,0x3
 8002576:	f807dce3          	bgez	a5,800250e <__divsf3+0x1ce>
 800257a:	4401                	li	s0,0
 800257c:	4705                	li	a4,1
 800257e:	bf49                	j	8002510 <__divsf3+0x1d0>
 8002580:	00400437          	lui	s0,0x400
 8002584:	0ff00713          	li	a4,255
 8002588:	4601                	li	a2,0
 800258a:	b759                	j	8002510 <__divsf3+0x1d0>

0800258c <__mulsf3>:
 800258c:	1101                	addi	sp,sp,-32
 800258e:	c84a                	sw	s2,16(sp)
 8002590:	01755913          	srli	s2,a0,0x17
 8002594:	ca26                	sw	s1,20(sp)
 8002596:	c64e                	sw	s3,12(sp)
 8002598:	c256                	sw	s5,4(sp)
 800259a:	00951493          	slli	s1,a0,0x9
 800259e:	ce06                	sw	ra,28(sp)
 80025a0:	cc22                	sw	s0,24(sp)
 80025a2:	c452                	sw	s4,8(sp)
 80025a4:	0ff97913          	andi	s2,s2,255
 80025a8:	8aae                	mv	s5,a1
 80025aa:	80a5                	srli	s1,s1,0x9
 80025ac:	01f55993          	srli	s3,a0,0x1f
 80025b0:	06090763          	beqz	s2,800261e <__mulsf3+0x92>
 80025b4:	0ff00793          	li	a5,255
 80025b8:	06f90f63          	beq	s2,a5,8002636 <__mulsf3+0xaa>
 80025bc:	048e                	slli	s1,s1,0x3
 80025be:	040007b7          	lui	a5,0x4000
 80025c2:	8cdd                	or	s1,s1,a5
 80025c4:	f8190913          	addi	s2,s2,-127
 80025c8:	4a01                	li	s4,0
 80025ca:	017ad513          	srli	a0,s5,0x17
 80025ce:	009a9413          	slli	s0,s5,0x9
 80025d2:	0ff57513          	andi	a0,a0,255
 80025d6:	8025                	srli	s0,s0,0x9
 80025d8:	01fada93          	srli	s5,s5,0x1f
 80025dc:	c535                	beqz	a0,8002648 <__mulsf3+0xbc>
 80025de:	0ff00793          	li	a5,255
 80025e2:	06f50f63          	beq	a0,a5,8002660 <__mulsf3+0xd4>
 80025e6:	040e                	slli	s0,s0,0x3
 80025e8:	040007b7          	lui	a5,0x4000
 80025ec:	8c5d                	or	s0,s0,a5
 80025ee:	f8150513          	addi	a0,a0,-127
 80025f2:	4781                	li	a5,0
 80025f4:	002a1713          	slli	a4,s4,0x2
 80025f8:	8f5d                	or	a4,a4,a5
 80025fa:	954a                	add	a0,a0,s2
 80025fc:	177d                	addi	a4,a4,-1
 80025fe:	45b9                	li	a1,14
 8002600:	0159c6b3          	xor	a3,s3,s5
 8002604:	00150613          	addi	a2,a0,1
 8002608:	06e5e563          	bltu	a1,a4,8002672 <__mulsf3+0xe6>
 800260c:	00000597          	auipc	a1,0x0
 8002610:	79058593          	addi	a1,a1,1936 # 8002d9c <usbfs_endpoints+0x4c>
 8002614:	070a                	slli	a4,a4,0x2
 8002616:	972e                	add	a4,a4,a1
 8002618:	4318                	lw	a4,0(a4)
 800261a:	972e                	add	a4,a4,a1
 800261c:	8702                	jr	a4
 800261e:	c095                	beqz	s1,8002642 <__mulsf3+0xb6>
 8002620:	8526                	mv	a0,s1
 8002622:	2b75                	jal	8002bde <__clzsi2>
 8002624:	ffb50793          	addi	a5,a0,-5
 8002628:	f8a00913          	li	s2,-118
 800262c:	00f494b3          	sll	s1,s1,a5
 8002630:	40a90933          	sub	s2,s2,a0
 8002634:	bf51                	j	80025c8 <__mulsf3+0x3c>
 8002636:	0ff00913          	li	s2,255
 800263a:	4a09                	li	s4,2
 800263c:	d4d9                	beqz	s1,80025ca <__mulsf3+0x3e>
 800263e:	4a0d                	li	s4,3
 8002640:	b769                	j	80025ca <__mulsf3+0x3e>
 8002642:	4901                	li	s2,0
 8002644:	4a05                	li	s4,1
 8002646:	b751                	j	80025ca <__mulsf3+0x3e>
 8002648:	c015                	beqz	s0,800266c <__mulsf3+0xe0>
 800264a:	8522                	mv	a0,s0
 800264c:	2b49                	jal	8002bde <__clzsi2>
 800264e:	ffb50793          	addi	a5,a0,-5
 8002652:	00f41433          	sll	s0,s0,a5
 8002656:	f8a00793          	li	a5,-118
 800265a:	40a78533          	sub	a0,a5,a0
 800265e:	bf51                	j	80025f2 <__mulsf3+0x66>
 8002660:	0ff00513          	li	a0,255
 8002664:	4789                	li	a5,2
 8002666:	d459                	beqz	s0,80025f4 <__mulsf3+0x68>
 8002668:	478d                	li	a5,3
 800266a:	b769                	j	80025f4 <__mulsf3+0x68>
 800266c:	4501                	li	a0,0
 800266e:	4785                	li	a5,1
 8002670:	b751                	j	80025f4 <__mulsf3+0x68>
 8002672:	67c1                	lui	a5,0x10
 8002674:	fff78313          	addi	t1,a5,-1 # ffff <__ram_size+0x7fff>
 8002678:	0104d713          	srli	a4,s1,0x10
 800267c:	01045593          	srli	a1,s0,0x10
 8002680:	0064f4b3          	and	s1,s1,t1
 8002684:	00647433          	and	s0,s0,t1
 8002688:	028488b3          	mul	a7,s1,s0
 800268c:	02870833          	mul	a6,a4,s0
 8002690:	02b70433          	mul	s0,a4,a1
 8002694:	029585b3          	mul	a1,a1,s1
 8002698:	0108d493          	srli	s1,a7,0x10
 800269c:	95c2                	add	a1,a1,a6
 800269e:	94ae                	add	s1,s1,a1
 80026a0:	0104f363          	bgeu	s1,a6,80026a6 <__mulsf3+0x11a>
 80026a4:	943e                	add	s0,s0,a5
 80026a6:	0064f7b3          	and	a5,s1,t1
 80026aa:	07c2                	slli	a5,a5,0x10
 80026ac:	0068f8b3          	and	a7,a7,t1
 80026b0:	97c6                	add	a5,a5,a7
 80026b2:	00679713          	slli	a4,a5,0x6
 80026b6:	80c1                	srli	s1,s1,0x10
 80026b8:	00e03733          	snez	a4,a4
 80026bc:	83e9                	srli	a5,a5,0x1a
 80026be:	9426                	add	s0,s0,s1
 80026c0:	8fd9                	or	a5,a5,a4
 80026c2:	041a                	slli	s0,s0,0x6
 80026c4:	8c5d                	or	s0,s0,a5
 80026c6:	00441793          	slli	a5,s0,0x4
 80026ca:	0607d763          	bgez	a5,8002738 <__mulsf3+0x1ac>
 80026ce:	00145793          	srli	a5,s0,0x1
 80026d2:	8805                	andi	s0,s0,1
 80026d4:	8c5d                	or	s0,s0,a5
 80026d6:	07f60713          	addi	a4,a2,127 # 400007f <__flash_size+0x3fe007f>
 80026da:	06e05163          	blez	a4,800273c <__mulsf3+0x1b0>
 80026de:	00747793          	andi	a5,s0,7
 80026e2:	c799                	beqz	a5,80026f0 <__mulsf3+0x164>
 80026e4:	00f47793          	andi	a5,s0,15
 80026e8:	4591                	li	a1,4
 80026ea:	00b78363          	beq	a5,a1,80026f0 <__mulsf3+0x164>
 80026ee:	0411                	addi	s0,s0,4
 80026f0:	00441793          	slli	a5,s0,0x4
 80026f4:	0007d863          	bgez	a5,8002704 <__mulsf3+0x178>
 80026f8:	f80007b7          	lui	a5,0xf8000
 80026fc:	17fd                	addi	a5,a5,-1
 80026fe:	8c7d                	and	s0,s0,a5
 8002700:	08060713          	addi	a4,a2,128
 8002704:	0fe00793          	li	a5,254
 8002708:	800d                	srli	s0,s0,0x3
 800270a:	06e7dd63          	bge	a5,a4,8002784 <__mulsf3+0x1f8>
 800270e:	4401                	li	s0,0
 8002710:	0ff00713          	li	a4,255
 8002714:	a885                	j	8002784 <__mulsf3+0x1f8>
 8002716:	86ce                	mv	a3,s3
 8002718:	8426                	mv	s0,s1
 800271a:	87d2                	mv	a5,s4
 800271c:	4709                	li	a4,2
 800271e:	fee788e3          	beq	a5,a4,800270e <__mulsf3+0x182>
 8002722:	470d                	li	a4,3
 8002724:	04e78b63          	beq	a5,a4,800277a <__mulsf3+0x1ee>
 8002728:	4705                	li	a4,1
 800272a:	fae796e3          	bne	a5,a4,80026d6 <__mulsf3+0x14a>
 800272e:	4401                	li	s0,0
 8002730:	4701                	li	a4,0
 8002732:	a889                	j	8002784 <__mulsf3+0x1f8>
 8002734:	86d6                	mv	a3,s5
 8002736:	b7dd                	j	800271c <__mulsf3+0x190>
 8002738:	862a                	mv	a2,a0
 800273a:	bf71                	j	80026d6 <__mulsf3+0x14a>
 800273c:	4785                	li	a5,1
 800273e:	8f99                	sub	a5,a5,a4
 8002740:	476d                	li	a4,27
 8002742:	fef746e3          	blt	a4,a5,800272e <__mulsf3+0x1a2>
 8002746:	09e60613          	addi	a2,a2,158
 800274a:	00f457b3          	srl	a5,s0,a5
 800274e:	00c41433          	sll	s0,s0,a2
 8002752:	00803433          	snez	s0,s0
 8002756:	8c5d                	or	s0,s0,a5
 8002758:	00747793          	andi	a5,s0,7
 800275c:	c799                	beqz	a5,800276a <__mulsf3+0x1de>
 800275e:	00f47793          	andi	a5,s0,15
 8002762:	4711                	li	a4,4
 8002764:	00e78363          	beq	a5,a4,800276a <__mulsf3+0x1de>
 8002768:	0411                	addi	s0,s0,4
 800276a:	00541793          	slli	a5,s0,0x5
 800276e:	800d                	srli	s0,s0,0x3
 8002770:	fc07d0e3          	bgez	a5,8002730 <__mulsf3+0x1a4>
 8002774:	4401                	li	s0,0
 8002776:	4705                	li	a4,1
 8002778:	a031                	j	8002784 <__mulsf3+0x1f8>
 800277a:	00400437          	lui	s0,0x400
 800277e:	0ff00713          	li	a4,255
 8002782:	4681                	li	a3,0
 8002784:	0426                	slli	s0,s0,0x9
 8002786:	0ff77713          	andi	a4,a4,255
 800278a:	075e                	slli	a4,a4,0x17
 800278c:	8025                	srli	s0,s0,0x9
 800278e:	8c59                	or	s0,s0,a4
 8002790:	01f69513          	slli	a0,a3,0x1f
 8002794:	8d41                	or	a0,a0,s0
 8002796:	40f2                	lw	ra,28(sp)
 8002798:	4462                	lw	s0,24(sp)
 800279a:	44d2                	lw	s1,20(sp)
 800279c:	4942                	lw	s2,16(sp)
 800279e:	49b2                	lw	s3,12(sp)
 80027a0:	4a22                	lw	s4,8(sp)
 80027a2:	4a92                	lw	s5,4(sp)
 80027a4:	6105                	addi	sp,sp,32
 80027a6:	8082                	ret

080027a8 <__subsf3>:
 80027a8:	00800737          	lui	a4,0x800
 80027ac:	1141                	addi	sp,sp,-16
 80027ae:	177d                	addi	a4,a4,-1
 80027b0:	01755693          	srli	a3,a0,0x17
 80027b4:	0175d813          	srli	a6,a1,0x17
 80027b8:	00a777b3          	and	a5,a4,a0
 80027bc:	c226                	sw	s1,4(sp)
 80027be:	8f6d                	and	a4,a4,a1
 80027c0:	c04a                	sw	s2,0(sp)
 80027c2:	0ff6f693          	andi	a3,a3,255
 80027c6:	0ff87813          	andi	a6,a6,255
 80027ca:	c606                	sw	ra,12(sp)
 80027cc:	c422                	sw	s0,8(sp)
 80027ce:	0ff00613          	li	a2,255
 80027d2:	01f55493          	srli	s1,a0,0x1f
 80027d6:	8936                	mv	s2,a3
 80027d8:	078e                	slli	a5,a5,0x3
 80027da:	8542                	mv	a0,a6
 80027dc:	81fd                	srli	a1,a1,0x1f
 80027de:	070e                	slli	a4,a4,0x3
 80027e0:	00c81363          	bne	a6,a2,80027e6 <__subsf3+0x3e>
 80027e4:	e319                	bnez	a4,80027ea <__subsf3+0x42>
 80027e6:	0015c593          	xori	a1,a1,1
 80027ea:	41068633          	sub	a2,a3,a6
 80027ee:	10959d63          	bne	a1,s1,8002908 <__subsf3+0x160>
 80027f2:	06c05b63          	blez	a2,8002868 <__subsf3+0xc0>
 80027f6:	04081163          	bnez	a6,8002838 <__subsf3+0x90>
 80027fa:	26070463          	beqz	a4,8002a62 <__subsf3+0x2ba>
 80027fe:	167d                	addi	a2,a2,-1
 8002800:	e60d                	bnez	a2,800282a <__subsf3+0x82>
 8002802:	97ba                	add	a5,a5,a4
 8002804:	8536                	mv	a0,a3
 8002806:	00579713          	slli	a4,a5,0x5
 800280a:	0c075963          	bgez	a4,80028dc <__subsf3+0x134>
 800280e:	0505                	addi	a0,a0,1
 8002810:	0ff00713          	li	a4,255
 8002814:	24e50d63          	beq	a0,a4,8002a6e <__subsf3+0x2c6>
 8002818:	7e000737          	lui	a4,0x7e000
 800281c:	0017f693          	andi	a3,a5,1
 8002820:	177d                	addi	a4,a4,-1
 8002822:	8385                	srli	a5,a5,0x1
 8002824:	8ff9                	and	a5,a5,a4
 8002826:	8fd5                	or	a5,a5,a3
 8002828:	a855                	j	80028dc <__subsf3+0x134>
 800282a:	0ff00593          	li	a1,255
 800282e:	00b69c63          	bne	a3,a1,8002846 <__subsf3+0x9e>
 8002832:	0ff00513          	li	a0,255
 8002836:	a05d                	j	80028dc <__subsf3+0x134>
 8002838:	0ff00593          	li	a1,255
 800283c:	feb68be3          	beq	a3,a1,8002832 <__subsf3+0x8a>
 8002840:	040005b7          	lui	a1,0x4000
 8002844:	8f4d                	or	a4,a4,a1
 8002846:	45ed                	li	a1,27
 8002848:	00c5d463          	bge	a1,a2,8002850 <__subsf3+0xa8>
 800284c:	4705                	li	a4,1
 800284e:	bf55                	j	8002802 <__subsf3+0x5a>
 8002850:	02000593          	li	a1,32
 8002854:	00c75533          	srl	a0,a4,a2
 8002858:	40c58633          	sub	a2,a1,a2
 800285c:	00c71733          	sll	a4,a4,a2
 8002860:	00e03733          	snez	a4,a4
 8002864:	8f49                	or	a4,a4,a0
 8002866:	bf71                	j	8002802 <__subsf3+0x5a>
 8002868:	c639                	beqz	a2,80028b6 <__subsf3+0x10e>
 800286a:	40d80633          	sub	a2,a6,a3
 800286e:	ee89                	bnez	a3,8002888 <__subsf3+0xe0>
 8002870:	1e078b63          	beqz	a5,8002a66 <__subsf3+0x2be>
 8002874:	167d                	addi	a2,a2,-1
 8002876:	e219                	bnez	a2,800287c <__subsf3+0xd4>
 8002878:	97ba                	add	a5,a5,a4
 800287a:	b771                	j	8002806 <__subsf3+0x5e>
 800287c:	0ff00693          	li	a3,255
 8002880:	00d81b63          	bne	a6,a3,8002896 <__subsf3+0xee>
 8002884:	87ba                	mv	a5,a4
 8002886:	b775                	j	8002832 <__subsf3+0x8a>
 8002888:	0ff00693          	li	a3,255
 800288c:	fed80ce3          	beq	a6,a3,8002884 <__subsf3+0xdc>
 8002890:	040006b7          	lui	a3,0x4000
 8002894:	8fd5                	or	a5,a5,a3
 8002896:	46ed                	li	a3,27
 8002898:	00c6d463          	bge	a3,a2,80028a0 <__subsf3+0xf8>
 800289c:	4785                	li	a5,1
 800289e:	bfe9                	j	8002878 <__subsf3+0xd0>
 80028a0:	02000693          	li	a3,32
 80028a4:	8e91                	sub	a3,a3,a2
 80028a6:	00c7d5b3          	srl	a1,a5,a2
 80028aa:	00d797b3          	sll	a5,a5,a3
 80028ae:	00f037b3          	snez	a5,a5
 80028b2:	8fcd                	or	a5,a5,a1
 80028b4:	b7d1                	j	8002878 <__subsf3+0xd0>
 80028b6:	00168613          	addi	a2,a3,1 # 4000001 <__flash_size+0x3fe0001>
 80028ba:	0fe67513          	andi	a0,a2,254
 80028be:	ed0d                	bnez	a0,80028f8 <__subsf3+0x150>
 80028c0:	ea8d                	bnez	a3,80028f2 <__subsf3+0x14a>
 80028c2:	1a078263          	beqz	a5,8002a66 <__subsf3+0x2be>
 80028c6:	cb19                	beqz	a4,80028dc <__subsf3+0x134>
 80028c8:	97ba                	add	a5,a5,a4
 80028ca:	00579713          	slli	a4,a5,0x5
 80028ce:	00075763          	bgez	a4,80028dc <__subsf3+0x134>
 80028d2:	fc000737          	lui	a4,0xfc000
 80028d6:	177d                	addi	a4,a4,-1
 80028d8:	8ff9                	and	a5,a5,a4
 80028da:	4505                	li	a0,1
 80028dc:	0077f713          	andi	a4,a5,7
 80028e0:	18070863          	beqz	a4,8002a70 <__subsf3+0x2c8>
 80028e4:	00f7f713          	andi	a4,a5,15
 80028e8:	4691                	li	a3,4
 80028ea:	18d70363          	beq	a4,a3,8002a70 <__subsf3+0x2c8>
 80028ee:	0791                	addi	a5,a5,4
 80028f0:	a241                	j	8002a70 <__subsf3+0x2c8>
 80028f2:	dbc9                	beqz	a5,8002884 <__subsf3+0xdc>
 80028f4:	df1d                	beqz	a4,8002832 <__subsf3+0x8a>
 80028f6:	a229                	j	8002a00 <__subsf3+0x258>
 80028f8:	0ff00693          	li	a3,255
 80028fc:	16d60763          	beq	a2,a3,8002a6a <__subsf3+0x2c2>
 8002900:	97ba                	add	a5,a5,a4
 8002902:	8385                	srli	a5,a5,0x1
 8002904:	8532                	mv	a0,a2
 8002906:	bfd9                	j	80028dc <__subsf3+0x134>
 8002908:	06c05663          	blez	a2,8002974 <__subsf3+0x1cc>
 800290c:	02081c63          	bnez	a6,8002944 <__subsf3+0x19c>
 8002910:	8536                	mv	a0,a3
 8002912:	d769                	beqz	a4,80028dc <__subsf3+0x134>
 8002914:	167d                	addi	a2,a2,-1
 8002916:	ee01                	bnez	a2,800292e <__subsf3+0x186>
 8002918:	8f99                	sub	a5,a5,a4
 800291a:	00579713          	slli	a4,a5,0x5
 800291e:	fa075fe3          	bgez	a4,80028dc <__subsf3+0x134>
 8002922:	04000437          	lui	s0,0x4000
 8002926:	147d                	addi	s0,s0,-1
 8002928:	8c7d                	and	s0,s0,a5
 800292a:	892a                	mv	s2,a0
 800292c:	a8cd                	j	8002a1e <__subsf3+0x276>
 800292e:	0ff00593          	li	a1,255
 8002932:	0ff00513          	li	a0,255
 8002936:	fab683e3          	beq	a3,a1,80028dc <__subsf3+0x134>
 800293a:	45ed                	li	a1,27
 800293c:	00c5de63          	bge	a1,a2,8002958 <__subsf3+0x1b0>
 8002940:	4705                	li	a4,1
 8002942:	a035                	j	800296e <__subsf3+0x1c6>
 8002944:	0ff00593          	li	a1,255
 8002948:	0ff00513          	li	a0,255
 800294c:	f8b688e3          	beq	a3,a1,80028dc <__subsf3+0x134>
 8002950:	040005b7          	lui	a1,0x4000
 8002954:	8f4d                	or	a4,a4,a1
 8002956:	b7d5                	j	800293a <__subsf3+0x192>
 8002958:	02000593          	li	a1,32
 800295c:	00c75533          	srl	a0,a4,a2
 8002960:	40c58633          	sub	a2,a1,a2
 8002964:	00c71733          	sll	a4,a4,a2
 8002968:	00e03733          	snez	a4,a4
 800296c:	8f49                	or	a4,a4,a0
 800296e:	8f99                	sub	a5,a5,a4
 8002970:	8536                	mv	a0,a3
 8002972:	b765                	j	800291a <__subsf3+0x172>
 8002974:	ca31                	beqz	a2,80029c8 <__subsf3+0x220>
 8002976:	40d80633          	sub	a2,a6,a3
 800297a:	ee99                	bnez	a3,8002998 <__subsf3+0x1f0>
 800297c:	cfb1                	beqz	a5,80029d8 <__subsf3+0x230>
 800297e:	167d                	addi	a2,a2,-1
 8002980:	e609                	bnez	a2,800298a <__subsf3+0x1e2>
 8002982:	40f707b3          	sub	a5,a4,a5
 8002986:	84ae                	mv	s1,a1
 8002988:	bf49                	j	800291a <__subsf3+0x172>
 800298a:	0ff00693          	li	a3,255
 800298e:	00d81c63          	bne	a6,a3,80029a6 <__subsf3+0x1fe>
 8002992:	87ba                	mv	a5,a4
 8002994:	84ae                	mv	s1,a1
 8002996:	bd71                	j	8002832 <__subsf3+0x8a>
 8002998:	0ff00693          	li	a3,255
 800299c:	fed80be3          	beq	a6,a3,8002992 <__subsf3+0x1ea>
 80029a0:	040006b7          	lui	a3,0x4000
 80029a4:	8fd5                	or	a5,a5,a3
 80029a6:	46ed                	li	a3,27
 80029a8:	00c6d463          	bge	a3,a2,80029b0 <__subsf3+0x208>
 80029ac:	4785                	li	a5,1
 80029ae:	bfd1                	j	8002982 <__subsf3+0x1da>
 80029b0:	02000693          	li	a3,32
 80029b4:	8e91                	sub	a3,a3,a2
 80029b6:	00c7d833          	srl	a6,a5,a2
 80029ba:	00d797b3          	sll	a5,a5,a3
 80029be:	00f037b3          	snez	a5,a5
 80029c2:	00f867b3          	or	a5,a6,a5
 80029c6:	bf75                	j	8002982 <__subsf3+0x1da>
 80029c8:	00168513          	addi	a0,a3,1 # 4000001 <__flash_size+0x3fe0001>
 80029cc:	0fe57513          	andi	a0,a0,254
 80029d0:	ed15                	bnez	a0,8002a0c <__subsf3+0x264>
 80029d2:	e685                	bnez	a3,80029fa <__subsf3+0x252>
 80029d4:	e781                	bnez	a5,80029dc <__subsf3+0x234>
 80029d6:	cf19                	beqz	a4,80029f4 <__subsf3+0x24c>
 80029d8:	87ba                	mv	a5,a4
 80029da:	a811                	j	80029ee <__subsf3+0x246>
 80029dc:	d301                	beqz	a4,80028dc <__subsf3+0x134>
 80029de:	40e786b3          	sub	a3,a5,a4
 80029e2:	00569613          	slli	a2,a3,0x5
 80029e6:	00065663          	bgez	a2,80029f2 <__subsf3+0x24a>
 80029ea:	40f707b3          	sub	a5,a4,a5
 80029ee:	84ae                	mv	s1,a1
 80029f0:	b5f5                	j	80028dc <__subsf3+0x134>
 80029f2:	e6e9                	bnez	a3,8002abc <__subsf3+0x314>
 80029f4:	4781                	li	a5,0
 80029f6:	4481                	li	s1,0
 80029f8:	a8a5                	j	8002a70 <__subsf3+0x2c8>
 80029fa:	ee079de3          	bnez	a5,80028f4 <__subsf3+0x14c>
 80029fe:	fb51                	bnez	a4,8002992 <__subsf3+0x1ea>
 8002a00:	4481                	li	s1,0
 8002a02:	020007b7          	lui	a5,0x2000
 8002a06:	0ff00513          	li	a0,255
 8002a0a:	a09d                	j	8002a70 <__subsf3+0x2c8>
 8002a0c:	40e78433          	sub	s0,a5,a4
 8002a10:	00541693          	slli	a3,s0,0x5
 8002a14:	0206dc63          	bgez	a3,8002a4c <__subsf3+0x2a4>
 8002a18:	40f70433          	sub	s0,a4,a5
 8002a1c:	84ae                	mv	s1,a1
 8002a1e:	8522                	mv	a0,s0
 8002a20:	2a7d                	jal	8002bde <__clzsi2>
 8002a22:	156d                	addi	a0,a0,-5
 8002a24:	00a41433          	sll	s0,s0,a0
 8002a28:	03254663          	blt	a0,s2,8002a54 <__subsf3+0x2ac>
 8002a2c:	41250533          	sub	a0,a0,s2
 8002a30:	0505                	addi	a0,a0,1
 8002a32:	02000713          	li	a4,32
 8002a36:	00a457b3          	srl	a5,s0,a0
 8002a3a:	40a70533          	sub	a0,a4,a0
 8002a3e:	00a41433          	sll	s0,s0,a0
 8002a42:	00803433          	snez	s0,s0
 8002a46:	8fc1                	or	a5,a5,s0
 8002a48:	4501                	li	a0,0
 8002a4a:	bd49                	j	80028dc <__subsf3+0x134>
 8002a4c:	f869                	bnez	s0,8002a1e <__subsf3+0x276>
 8002a4e:	4781                	li	a5,0
 8002a50:	4501                	li	a0,0
 8002a52:	b755                	j	80029f6 <__subsf3+0x24e>
 8002a54:	fc0007b7          	lui	a5,0xfc000
 8002a58:	17fd                	addi	a5,a5,-1
 8002a5a:	40a90533          	sub	a0,s2,a0
 8002a5e:	8fe1                	and	a5,a5,s0
 8002a60:	bdb5                	j	80028dc <__subsf3+0x134>
 8002a62:	8536                	mv	a0,a3
 8002a64:	bda5                	j	80028dc <__subsf3+0x134>
 8002a66:	87ba                	mv	a5,a4
 8002a68:	bd95                	j	80028dc <__subsf3+0x134>
 8002a6a:	0ff00513          	li	a0,255
 8002a6e:	4781                	li	a5,0
 8002a70:	00579713          	slli	a4,a5,0x5
 8002a74:	00075b63          	bgez	a4,8002a8a <__subsf3+0x2e2>
 8002a78:	0505                	addi	a0,a0,1
 8002a7a:	0ff00713          	li	a4,255
 8002a7e:	04e50163          	beq	a0,a4,8002ac0 <__subsf3+0x318>
 8002a82:	fc000737          	lui	a4,0xfc000
 8002a86:	177d                	addi	a4,a4,-1
 8002a88:	8ff9                	and	a5,a5,a4
 8002a8a:	0ff00713          	li	a4,255
 8002a8e:	838d                	srli	a5,a5,0x3
 8002a90:	00e51663          	bne	a0,a4,8002a9c <__subsf3+0x2f4>
 8002a94:	c781                	beqz	a5,8002a9c <__subsf3+0x2f4>
 8002a96:	004007b7          	lui	a5,0x400
 8002a9a:	4481                	li	s1,0
 8002a9c:	0ff57513          	andi	a0,a0,255
 8002aa0:	40b2                	lw	ra,12(sp)
 8002aa2:	4422                	lw	s0,8(sp)
 8002aa4:	07a6                	slli	a5,a5,0x9
 8002aa6:	01751713          	slli	a4,a0,0x17
 8002aaa:	0097d513          	srli	a0,a5,0x9
 8002aae:	04fe                	slli	s1,s1,0x1f
 8002ab0:	8d59                	or	a0,a0,a4
 8002ab2:	8d45                	or	a0,a0,s1
 8002ab4:	4902                	lw	s2,0(sp)
 8002ab6:	4492                	lw	s1,4(sp)
 8002ab8:	0141                	addi	sp,sp,16
 8002aba:	8082                	ret
 8002abc:	87b6                	mv	a5,a3
 8002abe:	bd39                	j	80028dc <__subsf3+0x134>
 8002ac0:	4781                	li	a5,0
 8002ac2:	b7e1                	j	8002a8a <__subsf3+0x2e2>

08002ac4 <__fixsfsi>:
 8002ac4:	00800637          	lui	a2,0x800
 8002ac8:	01755713          	srli	a4,a0,0x17
 8002acc:	fff60793          	addi	a5,a2,-1 # 7fffff <__flash_size+0x7dffff>
 8002ad0:	0ff77713          	andi	a4,a4,255
 8002ad4:	07e00593          	li	a1,126
 8002ad8:	8fe9                	and	a5,a5,a0
 8002ada:	01f55693          	srli	a3,a0,0x1f
 8002ade:	04e5f163          	bgeu	a1,a4,8002b20 <__fixsfsi+0x5c>
 8002ae2:	09d00593          	li	a1,157
 8002ae6:	00e5f863          	bgeu	a1,a4,8002af6 <__fixsfsi+0x32>
 8002aea:	80000537          	lui	a0,0x80000
 8002aee:	fff54513          	not	a0,a0
 8002af2:	9536                	add	a0,a0,a3
 8002af4:	8082                	ret
 8002af6:	00c7e533          	or	a0,a5,a2
 8002afa:	09500793          	li	a5,149
 8002afe:	00e7da63          	bge	a5,a4,8002b12 <__fixsfsi+0x4e>
 8002b02:	f6a70713          	addi	a4,a4,-150 # fbffff6a <__stack+0xdbff7f6a>
 8002b06:	00e51533          	sll	a0,a0,a4
 8002b0a:	ce81                	beqz	a3,8002b22 <__fixsfsi+0x5e>
 8002b0c:	40a00533          	neg	a0,a0
 8002b10:	8082                	ret
 8002b12:	09600793          	li	a5,150
 8002b16:	40e78733          	sub	a4,a5,a4
 8002b1a:	00e55533          	srl	a0,a0,a4
 8002b1e:	b7f5                	j	8002b0a <__fixsfsi+0x46>
 8002b20:	4501                	li	a0,0
 8002b22:	8082                	ret

08002b24 <__floatsisf>:
 8002b24:	1141                	addi	sp,sp,-16
 8002b26:	c606                	sw	ra,12(sp)
 8002b28:	c422                	sw	s0,8(sp)
 8002b2a:	c226                	sw	s1,4(sp)
 8002b2c:	87aa                	mv	a5,a0
 8002b2e:	c54d                	beqz	a0,8002bd8 <__floatsisf+0xb4>
 8002b30:	41f55713          	srai	a4,a0,0x1f
 8002b34:	00a74433          	xor	s0,a4,a0
 8002b38:	8c19                	sub	s0,s0,a4
 8002b3a:	01f55493          	srli	s1,a0,0x1f
 8002b3e:	8522                	mv	a0,s0
 8002b40:	2879                	jal	8002bde <__clzsi2>
 8002b42:	09e00793          	li	a5,158
 8002b46:	8f89                	sub	a5,a5,a0
 8002b48:	09600713          	li	a4,150
 8002b4c:	02f74663          	blt	a4,a5,8002b78 <__floatsisf+0x54>
 8002b50:	4721                	li	a4,8
 8002b52:	00a75563          	bge	a4,a0,8002b5c <__floatsisf+0x38>
 8002b56:	1561                	addi	a0,a0,-8
 8002b58:	00a41433          	sll	s0,s0,a0
 8002b5c:	0426                	slli	s0,s0,0x9
 8002b5e:	0ff7f793          	andi	a5,a5,255
 8002b62:	07de                	slli	a5,a5,0x17
 8002b64:	8025                	srli	s0,s0,0x9
 8002b66:	01f49513          	slli	a0,s1,0x1f
 8002b6a:	8c5d                	or	s0,s0,a5
 8002b6c:	8d41                	or	a0,a0,s0
 8002b6e:	40b2                	lw	ra,12(sp)
 8002b70:	4422                	lw	s0,8(sp)
 8002b72:	4492                	lw	s1,4(sp)
 8002b74:	0141                	addi	sp,sp,16
 8002b76:	8082                	ret
 8002b78:	09900713          	li	a4,153
 8002b7c:	00f75d63          	bge	a4,a5,8002b96 <__floatsisf+0x72>
 8002b80:	4715                	li	a4,5
 8002b82:	8f09                	sub	a4,a4,a0
 8002b84:	01b50693          	addi	a3,a0,27 # 8000001b <__stack+0x5fff801b>
 8002b88:	00e45733          	srl	a4,s0,a4
 8002b8c:	00d41433          	sll	s0,s0,a3
 8002b90:	00803433          	snez	s0,s0
 8002b94:	8c59                	or	s0,s0,a4
 8002b96:	4715                	li	a4,5
 8002b98:	00a75663          	bge	a4,a0,8002ba4 <__floatsisf+0x80>
 8002b9c:	ffb50713          	addi	a4,a0,-5
 8002ba0:	00e41433          	sll	s0,s0,a4
 8002ba4:	fc000737          	lui	a4,0xfc000
 8002ba8:	177d                	addi	a4,a4,-1
 8002baa:	00747693          	andi	a3,s0,7
 8002bae:	8f61                	and	a4,a4,s0
 8002bb0:	c691                	beqz	a3,8002bbc <__floatsisf+0x98>
 8002bb2:	883d                	andi	s0,s0,15
 8002bb4:	4691                	li	a3,4
 8002bb6:	00d40363          	beq	s0,a3,8002bbc <__floatsisf+0x98>
 8002bba:	0711                	addi	a4,a4,4
 8002bbc:	00571693          	slli	a3,a4,0x5
 8002bc0:	0006d963          	bgez	a3,8002bd2 <__floatsisf+0xae>
 8002bc4:	fc0007b7          	lui	a5,0xfc000
 8002bc8:	17fd                	addi	a5,a5,-1
 8002bca:	8f7d                	and	a4,a4,a5
 8002bcc:	09f00793          	li	a5,159
 8002bd0:	8f89                	sub	a5,a5,a0
 8002bd2:	00375413          	srli	s0,a4,0x3
 8002bd6:	b759                	j	8002b5c <__floatsisf+0x38>
 8002bd8:	4481                	li	s1,0
 8002bda:	4401                	li	s0,0
 8002bdc:	b741                	j	8002b5c <__floatsisf+0x38>

08002bde <__clzsi2>:
 8002bde:	67c1                	lui	a5,0x10
 8002be0:	02f57663          	bgeu	a0,a5,8002c0c <__clzsi2+0x2e>
 8002be4:	0ff00793          	li	a5,255
 8002be8:	00a7b7b3          	sltu	a5,a5,a0
 8002bec:	078e                	slli	a5,a5,0x3
 8002bee:	02000713          	li	a4,32
 8002bf2:	8f1d                	sub	a4,a4,a5
 8002bf4:	00f557b3          	srl	a5,a0,a5
 8002bf8:	00000517          	auipc	a0,0x0
 8002bfc:	1e050513          	addi	a0,a0,480 # 8002dd8 <__clz_tab>
 8002c00:	97aa                	add	a5,a5,a0
 8002c02:	0007c503          	lbu	a0,0(a5) # 10000 <__ram_size+0x8000>
 8002c06:	40a70533          	sub	a0,a4,a0
 8002c0a:	8082                	ret
 8002c0c:	01000737          	lui	a4,0x1000
 8002c10:	47c1                	li	a5,16
 8002c12:	fce56ee3          	bltu	a0,a4,8002bee <__clzsi2+0x10>
 8002c16:	47e1                	li	a5,24
 8002c18:	bfd9                	j	8002bee <__clzsi2+0x10>
