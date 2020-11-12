	.globl	lsearch_2

#	 Variable Map: 
#			int *A = rdi
#			int n = esi
#		   	int target = rdx
#			counter = rcx & r8d
#			int temp = r9d	

lsearch_2:
	testl	%esi, %esi	# if n <= 0
	jle	endif		# Jump to end (return -1)
	movslq	%esi, %rax	
	leaq	-4(%rdi,%rax,4), %rax	# Move n-1 into rax
	movl	(%rax), %r9d		# temp = A[n-1]
	movl	%edx, (%rax)		# A[n-1] = target
	cmpl	(%rdi), %edx		# target = *A
	je	clear
	movl	$1, %ecx		# i = 1
loop:
	movl	%ecx, %r8d		# Initialize 2nd counter
	addq	$1, %rcx		# i++
	cmpl	%edx, -4(%rdi,%rcx,4)	# While (A[i] != target)
	jne	loop
find:
	movl	%r9d, (%rax)		# A[n-1] = temp
	leal	-1(%rsi), %eax		
	cmpl	%r8d, %eax		# If i < n-1
	jg	found			# Return i
	cmpl	%edx, %r9d		# Else if A[n-1] != target
	jne	endif			# Return -1
	rep ret
found:
	movl	%r8d, %eax		# Return result
	ret
clear:
	xorl	%r8d, %r8d		# Clear counter
	jmp	find
endif:
	movl	$-1, %eax		# Return -1
	ret