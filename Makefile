include gd32vf103inator/Makefile
#CROSS_COMPILE = /home/grus/mwendt/2019/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/bin/riscv64-unknown-elf-
CROSS_COMPILE = /home/martin/2019/riscv/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/bin/riscv64-unknown-elf-
libs += stdio-usbacm
#%.s: %.c $(MAKEFILE_LIST) | $O
#	$(call echo, CC $<)
#	$Q$(CC) -S -o $@ $(filter-out -flto,$(CFLAGS)) $(CPPFLAGS) -c $<
	
%.s: %.c $(MAKEFILE_LIST)
	$(call echo, CC $<)
	$Q$(CC) -o $@ $(filter-out -flto,$(CFLAGS)) $(CPPFLAGS) -S $<
