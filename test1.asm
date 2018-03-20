#db_r[21:14]+sda_link+sda_r+cstate1[11:8]+cstate2[7:4]+cstate3[3:0]
IDLE:	addi	$k0,$zero,308737	#10010110 1 1 0001 0000 0000
START1:	addi	$k0,$zero,1034		#00000000 1 0 0010 0001 0000
ADD1:	addi	$k0,$zero,722		#00000000 0 1 0011 0010 0010
		addi	$k1,$zero,1
		addi	$k1,$zero,0
		addi	$k1,$zero,0
		addi	$k1,$zero,1
		addi	$k1,$zero,0
		addi	$k1,$zero,1
		addi	$k1,$zero,1
		addi	$k1,$zero,0
ACK1:	addi	$k0,$zero,1072		#00000000 0 0 0100 0011 0000
ADD2:	addi	$k0,$zero,5444		#00000000 0 1 0101 0100 0100
ACK2:	addi	$k0,$zero,114768	#00000111 0 0 0000 0101 0000
		addi	$k1,$zero,1
		addi	$k1,$zero,0
		addi	$k1,$zero,0
		addi	$k1,$zero,1
		addi	$k1,$zero,0
		addi	$k1,$zero,1
		addi	$k1,$zero,1
		addi	$k1,$zero,0
START2:	addi	$k0,$zero,13942		#00000000 1 1 0110 0111 0110
ADD3:	addi	$k0,$zero,6263		#00000000 0 1 1000 0111 0111
		addi	$k1,$zero,1
		addi	$k1,$zero,0
		addi	$k1,$zero,0
		addi	$k1,$zero,1
		addi	$k1,$zero,0
		addi	$k1,$zero,1
		addi	$k1,$zero,1
		addi	$k1,$zero,0
ACK3:	addi	$k0,$zero,2432		#00000000 0 0 1001 1000 0000
DATA1:	addi	$k0,$zero,2473		#00000000 0 0 1001 1010 1001
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
ACK4:	addi	$k0,$zero,11168		#00000000 1 0 1011 1010 0000
DATA2:	addi	$k0,$zero,3019		#00000000 0 0 1011 1100 1011
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
		addi	$k0,$zero,2473
NACK:	addi	$k0,$zero,15808		#00000000 1 1 1101 1100 0000
STOP1:	addi	$k0,$zero,11725		#00000000 1 0 1101 1100 1101
STOP2:	addi	$k0,$zero,4320		#00000000 0 1 0000 1110 0000
	addi	$a2,$zero,10		#a2=10
	addi	$a3,$zero,18		#a3=18
	addi	$s1,$zero,26		#s1=26
	addi	$s2,$zero,28		#s2=28
	addi	$s3,$zero,30		#s3=30
	addi	$s4,$zero,32		#s4=32
	addi	$s5,$zero,34		#s5=34
	addi	$s6,$zero,36		#s6=36
	addi	$s7,$zero,24		#s7=24
start:
	lb	$a0,2($zero)
	beq	$a0,$s1,T26
	beq	$a0,$s2,T28
	beq	$a0,$s3,T30
	beq	$a0,$s4,T32
	beq	$a0,$s5,T34
	beq	$a0,$s6,T36
	beq	$a0,$s7,T24
T24:	addi	$v0,$zero,15
	sb	$v0,0($zero)
	j	cal
T26:	addi	$v0,$zero,15
	sb	$v0,0($zero)
	j	cal
T28:	addi	$v0,$zero,240
	sb	$v0,0($zero)
	j	cal
T30:	addi	$v0,$zero,3840
	sb	$v0,0($zero)
	j	cal
T32:	addi	$v0,$zero,3840
	sb	$v0,0($zero)
	j	cal
T34:	addi	$v0,$zero,3840
	sb	$v0,0($zero)
	j	cal
T36:	addi	$v0,$zero,3840
	sb	$v0,0($zero)
cal:	multu	$a3,$a0
	mflo	$a1
	divu	$a1,$a2
	mflo	$a1
	addiu	$a1,$a1,32
	sb	$a1,1($zero)		
	j	IDLE