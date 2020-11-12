        .globl sqrt
sqrt:
        movl $0, %eax           # move 0 into eax
        movl $32768, %r9d       #set r9d bitmask to 2^15 for k

loop:  
        xorl %r9d, %eax         #xorl r9d to eax
        movl %eax, %r10d        #move eax to hold in r10d
        imul %r10d, %r10d       #mul r10d by r10d
        cmpl %r10d, %edi        #cmp r10d to target to test for above
        jae lessthan            #if greater or equal, jump to lessthan
        xorl %r9d, %eax         #xorl r9d, to eax otherwise

lessthan:
        shrl $1, %r9d           #shift right 1 on r9d bitmask   
        jnz loop                #jump back to top of loop if not zero

end:
        ret                     #return value