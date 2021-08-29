GPPPARAMS_OLD = -m32 -ffreestanding -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
GPPPARAMS = -m32 -ffreestanding
ASPARAMS = --32
LDPARAMS = -m elf_i386

objects = loader.o kernel.o

%.o: %.c
	gcc $(GPPPARAMS) -o $@ -c $<

%.o: %.s
	as $(ASPARAMS) -o $@ -c $<

Zkernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

install: Zkernel.bin

	mkdir boot
	mv $< boot/

clean:
	rm -r loader.o kernel.o kernel.bin ZROS.iso boot/ output/



build:
	set -e
	mkdir -p iso
	mkdir -p iso/boot
	mkdir -p iso/boot/grub
 
	cp Zkernel.bin iso/boot/Zkernel.bin
	echo menuentry "ZROS" { >> iso/boot/grub/grub.cfg
	echo multiboot /boot/Zkernel.bin >> iso/boot/grub/grub.cfg
	echo } >> iso/boot/grub/grub.cfg
	grub-mkrescue -o ZROS.iso iso
	mkdir output
	mv ZROS.iso output/ 
	rm -r boot/ iso/
