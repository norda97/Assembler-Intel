.data
buff: .space 256 
counter: .byte 255


.text
.global inImage
inImage:
    leaq    buff, %rdi
    movq    $256, %rsi
    movq    stdin, %rdx
    call    fgets
    ret
    


.global getInt
getInt:


.global getText
getText:


.global getChar
getChar:
    call inImage
    ret


.global getInPos
getInPos:


.global setInPos
setInPos:

.global outImage
outImage:
    leaq    buff, %rdi
    call    puts


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


