.data
inBuff: .space 256
inBufPos: .long -1

outBuff: .space 256 
outBufPos: .long -1


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
    movb    $0, inBufPos

    popq    %rdx
    popq    %rsi
    popq    %rdi
    ret

.global getInt
getInt:


.global getText
getText:


.global getChar
getChar:
    leaq    inBuff, %rdi
    add     inBufPos, %rdi
/*
    movq    $-1, %rsi
    cmp     (%rdi), %rsi
    jne     getChar_start
    call    inImage
    */
    getChar_start:
    movq    $0, %rsi
    cmp     (%rdi), %rsi
    je      getChar_end
    add     $1, inBufPos
    getChar_end:
        mov     (%rdi), %eax
    ret


.global getInPos
getInPos:


.global setInPos
setInPos:

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


