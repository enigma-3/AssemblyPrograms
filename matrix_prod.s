		.globl matrix_prod
matrix_prod:   
        push %r12               # Push value of r12 to use reg
        xorq %r12, %r12         # Clear r12
        xorq %rax, %rax         # Clear rax
        xorq %r8, %r8           # Clear r8
        xorq %r9, %r9           # Clear r9
        movq %rcx, %r10         # Move 'n' to r10

        jmp loop                # Jump to first outer loop
start:
        incq %r8                # Increment i
loop:
        cmpq %r8, %rcx          # i < n ?
        jle end                 # Jump to end
        movq $0, %r9            # Reset inner loop 'j' to 0
nested:
        movq %r8, %r11          # i --> r11
        movq %r9, %r12          # j --> r12
        cmpq %r9, %rcx          # j < n ?
        jle start               # Jump to start

        push %rdi               # Push and preserve registers
        push %rsi
        push %rdx
        push %rcx
        push %r8
        push %r9
        push %r10
        push %r11

        movq %rcx, %rdx         # Set rdx to n
        movq %r8, %rcx          # Set rcx to i
        movq %r9, %r8           # Set r8 to j

        call dot_prod           # dot_prod(A, B, n, i, j)

        movq %rax, %rdi         # Move result of dot_prod to rdi
        movq $17, %rsi          # Move 17 into rsi

	call mod                # mod(x, m)

        pop %r11                # Pop registers back to dest
        pop %r10
        pop %r9
        pop %r8
        pop %rcx
        pop %rdx
        pop %rsi
        pop %rdi

        imulq %r10, %r11                # n * i
        addq %r12, %r11                 # j + n*i
        movq %rax, (%rdx, %r11)         # Move result into C_ij
        incq %r9                        # Increment j
        jmp nested                      # Jump to start of inner loop

end:
        pop %r12                        # Pop back value into r12
        ret                             # Return