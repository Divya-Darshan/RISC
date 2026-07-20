global main
extern printf

section .data
    ; Instead of pixels, we store a text string in memory
    message: db "Hello from your Intel Chip!", 10, 0

section .text
main:
    ; Intel x86-64 uses 64-bit registers starting with 'R' (like RCX)
    ; We set up our pockets to talk to Windows
    sub rsp, 40                 ; Reserve stack space required by Windows
    
    mov rcx, message            ; Put our message address into the RCX register pocket
    call printf                 ; Call the built-in Windows C library to print it
    
    xor eax, eax                ; Set return code to 0 (Success)
    add rsp, 40                 ; Clean up the stack space
    ret                         ; Exit the program natively