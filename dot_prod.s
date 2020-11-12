        .globl dot_prod
dot_prod:
        push %r12           # Preserve r12 value on stack to use as scratch
        push %r13           # Preserve r13 value on stack to use as scratch

        xorl %eax, %eax     # Clear value in result
        xorq %r12, %r12     # Clear value of r12 scratch reg
        xorq %r13, %r13     # Clear value of r13 scratch reg (r13 is the 'k')
start:
        movl %ecx, %r9d     # Move value of 'i' to r9d
        imull %edx, %r9d    # Multiply 'n' by 'i'
        addl %r13d, %r9d    # Add 'k' to n*i

        movl %r13d, %r11d   # Move value of 'k' to r11d
        imull %edx, %r11d   # Multiply 'n' by 'k'
        addl %r8d, %r11d    # Add 'j' to n*k
add:
        movl (%rdi, %r9), %r10d     # Move A_ik to r10d
        movl (%rsi, %r11), %r12d    # Move B_kj to r12d
        imull %r10d, %r12d  # Multiply A_ik by B_kj
        addb %r12b, %al     # Add A_ik*B_kj to result
        incl %r13d          # Increment 'k' by 1
        cmpl %r13d, %edx    # Compare 'n' with 'k'
        jg start            # Jump to start if greater than 0 (n-k ? 0)

        pop %r13            # Restore value back to %r13 from stack
        pop %r12            # Restore value back to %r12 from stack

        ret                 # Return result