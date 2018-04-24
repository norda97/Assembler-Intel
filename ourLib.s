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

checkAscii:
    # %rdi: ascii to check for, 
    # if space or + return 1
    # if -          return 2
    # if number     return 3
    # else          return 0
    cmpb    $58, %dil
    jge      checkAscii_else 
    cmpb    $32, %dil
    je      checkAscii_space
    cmpb    $43, %dil
    je      checkAscii_plus
    cmpb    $45, %dil
    je      checkAscii_minus
    cmpb    $48, %dil
    jl      checkAscii_else           
    # if line is reached we know it's a number
    movl    $3, %eax
    jmp     checkAscii_end

    checkAscii_space:
    movl    $1, %eax
    jmp     checkAscii_end

    checkAscii_plus:
    movl    $1, %eax
    jmp     checkAscii_end

    checkAscii_minus:
    movl    $2, %eax
    jmp     checkAscii_end

    checkAscii_else:
    movl    $0, %eax
    jmp     checkAscii_end

    checkAscii_end:
    ret

.global getInt
getInt:
    movq    inBufPos, %rdx
    leaq    inBuff, %rcx
    movq    $0, %r8     # is negative
    movq    $0, %r9     # the number
    movq    $0, %r10    # number counter
    getInt_loop:
        cmpq    $256, %rdx
        jne     getInt_atEnd
        call    inImage
        jmp     getInt
        getInt_atEnd:
            movb    (%rcx, %rdx, 1), %dil
            call    checkAscii
            cmpl    $0, %eax
            je      getInt_returnNum
            cmpl    $1, %eax
            je      getInt_spacePlus
            cmpl    $2, %eax
            je      getInt_negative
            cmpl    $3, %eax
            je      getInt_number

        getInt_number:
            subb    $48, %dil    
            push    %rdi
            addq    $1, %r10
            jmp     getInt_loopEnd

        getInt_negative:
            cmp     $0, %r10    # if not first number
            jne     getInt_returnNum
            movq    $1, %r8     # set minus
            jmp     getInt_loopEnd
        
        getInt_spacePlus:
            movq    $0, %r8     # set plus
            cmp     $0, %r10    # if not first number
            jne     getInt_returnNum

        getInt_loopEnd:
            incq    %rdx
            jmp     getInt_loop

    getInt_returnNum:           # iterate through numbers on stack
        movq    $1, %rcx        # number iterator
        getInt_popLoop:
            cmpq     $0, %r10
            je      getInt_end
            
            pop     %rax
            decq    %r10        # remove one from stack counter
            imulq   %rcx, %rax  # multiply number with 10 to power of x
            addq    %rax, %r9   # add multiplication in return number
            imulq   $10, %rcx   # multiply iterator with 10
            jmp     getInt_popLoop
        getInt_end:
        cmpq    $1, %r8
        jne     getInt_ret
        negq    %r9
        getInt_ret:
        movq    %rdx, inBufPos
        movl    %r9d, %eax
    ret

.global getText
getText:
    movl    inBufPos, %edx
    leaq    inBuff, %rcx
    movq    $0, %r8
    getText_loop:
        cmp     $256, %edx
        jne     getText_atEnd
        call    inImage
        jmp     getText
        getText_atEnd:
            movb    (%rcx, %rdx, 1), %r9b
            movb    %r9b, (%rdi, %r8, 1)
            add     $1, %r8d 
            add     $1, %edx
            cmp     %r8, %rsi
            jne     getText_loop

    
    movl    %edx, inBufPos
    movl    %r8d, %eax

    ret

.global getChar
getChar:
    leaq    inBuff, %rdi
    mov     inBufPos, %rsi
    
    # If at the end, call inImage.
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
    # leaq    outBuff, %rdi
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


