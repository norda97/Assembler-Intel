.data
inBuff: .space 256
inBufPos: .long 256

outBuff: .space 256 
outBufPos: .long 0

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
    xorq    %rdx, %rdx
    xorq    %rdi, %rdi
    movl    inBufPos, %edx
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
            cmp     $0, %r10    # if not first number
            jne     getInt_returnNum
            movq    $0, %r8     # set plus

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
        negl    %r9d
        getInt_ret:
        movl    %edx, inBufPos
        movl    %r9d, %eax
    ret

.global getText
getText:
    movl    inBufPos, %edx
    leaq    inBuff, %rcx
    movq    $0, %r8
    getText_loop:          
        cmpl    $256, %edx
        jne     getText_atEnd
        cmpq    $256, %rsi
        jge     getText_end
        call    inImage
        jmp     getText
        getText_atEnd:
            movb    (%rcx, %rdx, 1), %r9b
            incl    %edx
            cmpb    $0, %r9b                # if \0 is reached stop looking for chars
            je      getText_end
            movb    %r9b, (%rdi, %r8, 1)
            incl    %r8d
            cmpq    %r8, %rsi
            jne     getText_loop

    getText_end:                  
    movb    $0, (%rdi, %r8, 1)      # Add \0 to end of buf
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
    cmpl    $0, %edi
    jg      setInPos_continue 
    movl    $0, %edi
    setInPos_continue:
    cmpl    $255, %edi
    jl     setInPos_end 
    movl    $255, %edi

    setInPos_end:
    movl    %edi, inBufPos 
    ret

.global outImage
outImage:
    leaq    outBuff, %rdi
    movl    outBufPos, %esi
    movb    $0, (%rdi, %rsi, 1)
    call    puts
    leaq    outBuff, %rdi
    movl    $0, outBufPos
    movb    $0, (%rdi) 
    ret

.global putInt
putInt:

    movq    $0, %r8        # Counter for stack
    xorq    %rax, %rax
    movl    %edi, %eax
    xorq    %rdi, %rdi

    # Check negativity
    cmpl    $0, %eax
    jge     putInt_divLoop
    negl    %eax
    movb    $45, %dil
    call    putChar

    putInt_divLoop:
        xorq    %rdx, %rdx

        movq    $10, %r9
        idivq   %r9
        addb    $48, %dl
        push    %rdx
        incb    %r8b

        cmpl    $0, %eax
        jne     putInt_divLoop

    putInt_printLoop:

        pop     %rdi
        decb    %r8b
        call    putChar

        cmpb    $0, %r8b
        jne     putInt_printLoop

    ret

.global putText
putText:
    movq    $0, %rsi
    xorq    %rdx, %rdx
    movl    outBufPos, %edx
    leaq    outBuff, %r9

    putText_loop:
    cmp     $256 ,%edx
    jne     putText_continue
    call    outImage
    jmp     putText

    putText_continue:
    movb    (%rdi, %rsi, 1), %r8b 
    # Check if nullterminator is reached
    cmpb    $0, %r8b
    je      putText_end

    movb    %r8b, (%r9, %rdx, 1)
    incl    %edx
    incq    %rsi
    jmp     putText_loop

    putText_end:
    movl    %edx, outBufPos
    ret

.global putChar
putChar:
    movl    outBufPos, %edx
    cmpl    $256, %edx 
    jne     putChar_end   
    call    outImage
    movl    outBufPos, %edx
    putChar_end:
    leaq    outBuff, %rsi
    movb    %dil, (%rsi, %rdx, 1) 
    incl    %edx
    movl    %edx, outBufPos
    ret

.global getOutPos
getOutPos:
    movl     outBufPos, %eax
    ret

.global setOutPos
setOutPos:
    cmpl    $0, %edi
    jg      setOutPos_continue 
    movl    $0, %edi
    setOutPos_continue:
    cmpl    $255, %edi
    jl      setOutPos_end 
    movl    $255, %edi

    setOutPos_end:
    movl    %edi, outBufPos 
    ret

