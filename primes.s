	.file	"primes.c"
	.text
	.section	.rodata
.LC0:
	.string	"%d "
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$2, -96(%rbp)
	movl	$1, -112(%rbp)
	movl	$3, -108(%rbp)
	jmp	.L2
.L8:
	movb	$1, -113(%rbp)
	movl	-108(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L13
	movl	$0, -104(%rbp)
	jmp	.L5
.L7:
	movl	-104(%rbp), %eax
	cltq
	movl	-96(%rbp,%rax,4), %ecx
	movl	-108(%rbp), %eax
	cltd
	idivl	%ecx
	movl	%edx, %eax
	testl	%eax, %eax
	jne	.L6
	movb	$0, -113(%rbp)
.L6:
	addl	$1, -104(%rbp)
.L5:
	movl	-104(%rbp), %eax
	cmpl	-112(%rbp), %eax
	jl	.L7
	cmpb	$0, -113(%rbp)
	je	.L4
	movl	-112(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, -112(%rbp)
	cltq
	movl	-108(%rbp), %edx
	movl	%edx, -96(%rbp,%rax,4)
	jmp	.L4
.L13:
	nop
.L4:
	addl	$1, -108(%rbp)
.L2:
	cmpl	$71, -108(%rbp)
	jle	.L8
	movl	$0, -100(%rbp)
	jmp	.L9
.L10:
	movl	-100(%rbp), %eax
	cltq
	movl	-96(%rbp,%rax,4), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -100(%rbp)
.L9:
	cmpl	$19, -100(%rbp)
	jle	.L10
	movl	$0, %eax
	movq	-8(%rbp), %rsi
	xorq	%fs:40, %rsi
	je	.L12
	call	__stack_chk_fail@PLT
.L12:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
