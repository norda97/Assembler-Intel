.data
inBuff: .space 256
inBufPos: .long 256

outBuff: .space 256 
outBufPos: .long 256

.text
.global inImage
inImage:
    pushq   %rdi
    pushq   %rsi
    pushq   %rdx
    leaq    inBuff, %rdi
    movq    $256, %rsi
    movq    stdin, %rdx
    call    fgets
    movl    $0, inBufPos

    popq    %rdx
    popq    %rsi
    popq    %rdi
    ret

.global getInt
getInt:


.global getText
getText:
    mov     inBufPos, %rdx
    leaq    inBuff, %rcx
    mov     $0, %r8
    getText_loop:
        movb     (%rcx, %rdx, 1), %r9b
        movb     %r9b, (%rdi, %r8, 1)
        add     $1, %r8 
        add     $1, %rdx
        cmp     %r8, %rsi
        jne     getText_loop

    movl    %r8d, %eax
    ret

.global getChar
getChar:
    leaq    inBuff, %rdi
    mov     inBufPos, %rsi
    
    cmp     $256, %rsi
    jne     getChar_start
    call    inImage
    getChar_start:
    mov     inBufPos, %rsi

    add     %rsi, %rdi 
    cmp     $0, (%rdi)
    je      getChar_end
    add     $1, inBufPos
    getChar_end:
        mov     (%rdi), %eax
    ret


.global getInPos
getInPos:
    movl     inBufPos, %eax
    ret

.global setInPos
setInPos:
    //leaq    outBuff, %rdi
    movq     %rdi, inBufPos 
    ret

.global outImage
outImage:
    leaq    outBuff, %rdi
    call    puts
    ret


.global putInt
putInt:


.global putText
putText:


.global putChar
putChar:


.global getOutPos
getOutPos:


.global setOutPos
setOutPos:


