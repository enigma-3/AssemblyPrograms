        .globl times
times:
        movl $0, %ecx	#move 0 into ecx (counter)
        movl $0, %eax	#move 0 into eax (total)

loop:   cmpl %ecx, %esi	#compare esi (b) with counter
        jle endloop		#jump to return if esi (b) - ecx (counter) <= 0
        add %edi, %eax	#add value of edi (a) to eax (total)
        incl %ecx		#increment counter +1
        jmp loop		#jump to top of loop and repeat if necessary
        
endloop:
        ret