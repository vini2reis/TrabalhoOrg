	.data

informa_N:	.string "Informe N maior ou igual a 1: "
informa_K:	.string "Informe K menor ou igual a N e maior ou igual a 1: "
msg_Result:	.string "Resultado: "

	.text
	

N:		
		addi s0, zero, 0	#s0 = N
		addi t0, zero, 1    	#t0 = 1
		li   a7, 4
		la   a0, informa_N
		ecall
		
		li a7, 5
		ecall
		
		blt a0, t0, N		#N � menor que 1?
		add s0, zero, a0

K:		
		addi s1, zero, 0	#s1 = K
		li 	a7, 4
		la	a0, informa_K
		ecall
		
		li a7, 5 
		ecall
		
		blt a0, t0, informa_K	#K menor que 1?
		blt s0, a0, informa_K	#N  menor que K?
		add s1, zero, a0
		beq s0, t0, n_eh_1 	#N = 1
		
		
main:
 
		addi s2, s0, 0		#Auxiliar de N
		addi s3, s1, 0		#Auxiliar de K
		addi s4, zero, 0	#s4 = resultado
		jal ST_2
		
		li   a7, 4
		la   a0, msg_Result
		ecall
		
		addi a0, s4, 0
		li   a7, 1
		ecall
		
		nop 
		ebreak
				
ST_2:	
		beq s2, t0, else	#Testa se N igual de 1
		beq s3, t0, else1	#Testa se K igual de 1
		beq s3, zero, else	#Testa se K igual a 0
		beq s3, s2, else1	#Testa se K igual N
		
		addi sp, sp, -4
		sw s2, 0(sp)		#Salva o valor de N na pilha
		addi sp, sp, -4
		sw s3, 0(sp)		#Salva o valor de K na pilha
		addi sp, sp, -4
		sw ra, 0(sp)		#Salva endereco na pilha
		
		addi s2, s2, -1		#N - 1
		jal ST_2
		
		lw s2, 8(sp)		#Le N
		lw s3, 4(sp)		#Le K
		lw ra, 0(sp)		#Le endereco																																				
		
		mul s4, s3, s4		#Multiplica K pelo retorno
		
		addi sp, sp, -4
		sw s4, 0(sp)		#Salva retorno na pilha
		
		
		addi s2, s2, -1		#N-1	
		addi s3, s3, -1		#K-1
		
		jal ST_2
	
		
		lw a0, 0(sp)		#Le o retorno multiplicado																																				
		lw ra, 4(sp)		#Le o registrador de retorno
		lw s3, 8(sp)		#Le o auxiliar K
		lw s2, 12(sp)		#Le o auxiliar N
		add s4, a0, s4		#Soma retorno multiplicado com o retorno da outra parte
		addi sp, sp, 16
		ret					
		

else:
		beq s2, zero, else1	#Testa se N igual a 0
		addi s4, zero, 0
		ret			#Retorna 0
		
else1:		
		addi s4, zero, 1
		ret			#Retorna 1
n_eh_1:
		beq s1, t0, k_eh_1 	#K = 1
k_eh_1:	
		li   a7, 4
		la   a0, msg_Result
		ecall

		addi a0, zero, 1
		li   a7, 1
		ecall
		
		nop 
		ebreak
			
