void printk(const char* str){
    unsigned char* VideoMemory = (unsigned char *)0xb8000;
    for(int i = 0; str[i] != '\0'; i++){
        VideoMemory[i] = (VideoMemory[i] & 0xFF00) | str[i];
    };
}

void kmain (void* multiboot_stucture, unsigned int magicnumber){
    
    printk("Hello World!");

}
