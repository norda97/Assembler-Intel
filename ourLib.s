.data
buff: .space 128 


.text
.global inImage
inImage:
    leaq    buff, %rdi
    movq    $128, %rsi
    movq    stdin, %rdx
    call    fgets
    


.global getInt
getInt:


.global getText
getText:


.global getChar
getChar:


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


