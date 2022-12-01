# Demo for painting
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
.data
displayAddress: .word 0x10008000
red: .word 0xff0000
green: .word 0x00ff00
blue: .word 0x0000ff
black: .word 0x000000
pinck: .word 0xffc0cb
brown: .word 0x964b00
beige: .word 0xf5f5dc
yellow: .word 0xffff00
purple: .word 0x800080
v1: .space 192
v2: .space 192
v3: .space 192
l1: .space 192
l2: .space 192
l3: .space 192
over: .asciiz "Game Over. Do you want to restart? \n"
live: .asciiz "life remaining: "
.text
BEGINNING:
#initialization
lw $t0, displayAddress # $t0 stores the base address for display
addi $s5, $zero, 0
addi $a1, $zero, 3
addi $a2, $zero, 27 # row of top left of frog
addi $a3, $zero, 14 #column of top left of frog

li  $v0, 56           # service 1 is print integer
la $a0, live  # load desired value into argument register $a0, using pseudo-op
syscall

la $t9, v1
la $s0, v2
la $s1, v3
la $s2, l1
la $s3, l2
la $s4, l3
add $t1, $zero, $zero
addi $t2, $zero, 8
addi $t3, $zero, 4
V1LOOP:
bge $t1, $t2, V12START
mult $t3, $t1
mflo $t7
add $t6, $t7, $t9
sw $t1, 0($t6)
add $t6, $t7, $s0
sw $t1, 0($t6)
add $t6, $t7, $s1
sw $t1, 0($t6)
add $t6, $t7, $s2
sw $t1, 0($t6)
add $t6, $t7, $s3
sw $t1, 0($t6)
add $t6, $t7, $s4
sw $t1, 0($t6)
addi $t1, $t1, 1
j V1LOOP

V12START:
add $t1, $zero, $zero
add $t2, $zero, 8
addi $t3, $zero, 4
V12LOOP:
bge $t1, $t2, START
addi $t4, $t1, 16
addi $t5, $t1, 8
mult $t3, $t5
mflo $t7
add $t6, $t7, $t9
sw $t4, 0($t6)
add $t6, $t7, $s0
sw $t4, 0($t6)
add $t6, $t7, $s1
sw $t4, 0($t6)
add $t6, $t7, $s2
sw $t4, 0($t6)
add $t6, $t7, $s3
sw $t4, 0($t6)
add $t6, $t7, $s4
sw $t4, 0($t6)
addi $t1, $t1, 1
j V12LOOP

START:



#reset frog
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)

lw $t8, 0xffff0000
beq $t8, 1, keyboard_input
j DRAWF

keyboard_input:
lw $t2, 0xffff0004
beq $t2, 0x61, respond_to_A
beq $t2, 0x73, respond_to_S
beq $t2, 0x64, respond_to_D
beq $t2, 0x77, respond_to_W
j DRAWF

respond_to_S:
addi $a2, $a2, 3
j DRAWF

respond_to_D:
addi $a3, $a3, 3
j DRAWF

respond_to_A:
subi $a3, $a3, 3
j DRAWF

respond_to_W:
subi $a2, $a2, 3
j DRAWF


DRAWF:
#draw frog
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)

CARS:
# Top green 6 by 32
lw $t0, displayAddress # $t0 stores the base address for display
addi $s7, $zero, 2304
addi $t1, $zero, 0 # initialize $t1 to 0
addi $t2, $zero, 9 # initialize $t2 to 9
CAR1:
beq $t1, $t2, STARTV1 #exit if $t1 = 9
addi $t3, $zero, 0 # initialize $t3 to 0
addi $t4, $zero, 32 # initialize $t4 to 32
# offset for row
addi $t5, $zero, 128 # set $5 to 128
mult $t1, $t5 
mflo $a0 # $a0 stores the row offset
add $a0, $a0, $s7
CAR2:
beq $t3, $t4, ENDCAR2 #exit if $tt3 = 32

# offset for column
addi $t5, $zero, 4 # set $t5 to 4
mult $t3, $t5 
mflo $t7 # $7 stores the row offset
# Total offset
add $t6, $a0, $t7
lw $t5, black # load green to $t5
add $t6, $t0, $t6
lw $t7, 0($t6)
beq $t7, 0xffc0cb, CSTOP1
sw $t5, 0($t6)
CSTOP1:
addi $t3, $t3, 1 # $3 ++
j CAR2
ENDCAR2:
addi $t1, $t1, 1 # $1 ++
j CAR1


#draw car/log
STARTV1:
lw $t0, displayAddress # $t0 stores the base address for display
la $s0, v1 # store address of v1 in $s0
add $t1, $zero, $zero # $t1 is 0
add $t2, $zero, 16 # $t2 is 16 
addi $t3, $zero, 4 # $t3 is 4
addi $t9, $zero, 32 # $t9 is 32
addi $t8, $zero, 2304 # $t8 is 2304
LOOPV1: 
bge $t1, $t2, STARTV2 # from 0 to 15
mult $t1, $t3 # 4i
mflo $t7 # $t7 stores 4i
add $t4, $s0, $t7 # $t4 stores the address of i-th element in v1
lw $t5, 0($t4) # what stored in i is loaded into $t5
beq $s5, $zero, FIRSTLEVEL1
addi $t5, $t5, 2 # increment $t5 by 1 
j LEVELEND1

FIRSTLEVEL1:
addi $t5, $t5, 1 # increment $t5 by 1                                                 change from            1

LEVELEND1:
div $t5, $t9 #if $t5 greater than 32, wrap around
mfhi $t6 # $t6 stores the remainder
sw $t6, 0($t4) # store back $t6
mult $t6, $t3 # How much to move forward
mflo $t6 # $t6 stores the offset
add $t6, $t6, $t8 # $t6 stores the total offset
add $t6, $t0, $t6 # $t6 stores the final position of the pixel to place
lw $s1, red 
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
add $t6, $t6, 128
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
add $t6, $t6, 128
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
addi $t1, $t1, 1
j LOOPV1




# second car
STARTV2:
lw $t0, displayAddress # $t0 stores the base address for display
la $s0, v2
add $t1, $zero, $zero
add $t2, $zero, 16
addi $t3, $zero, 4
addi $t9, $zero, 32
addi $t8, $zero, 2688
LOOPV2:
bge $t1, $t2, STARTV3
mult $t1, $t3
mflo $t7
add $t4, $s0, $t7
lw $t5, 0($t4) 
beq $s5, $zero, FIRSTLEVEL2
addi $t5, $t5, 60 # increment $t5 by 1 
j LEVELEND2
FIRSTLEVEL2:
addi $t5, $t5, 30 #                                                                     change from       30

LEVELEND2:
div $t5, $t9
mfhi $t6
sw $t6, 0($t4) # add 2 and store back
mult $t6, $t3 # How much to move forward
mflo $t6 # $t6 stores the offset
add $t6, $t6, $t8 # $t6 stores the total offset
add $t6, $t0, $t6 # $t6 stores the final position of the pixel to place
lw $s1, red 
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
add $t6, $t6, 128
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
add $t6, $t6, 128
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
addi $t1, $t1, 1
j LOOPV2

# third car
STARTV3:
lw $t0, displayAddress # $t0 stores the base address for display
la $s0, v3
add $t1, $zero, $zero
add $t2, $zero, 16
addi $t3, $zero, 4
addi $t9, $zero, 32
addi $t8, $zero, 3072
LOOPV3:
bge $t1, $t2, LOGS
mult $t1, $t3
mflo $t7
add $t4, $s0, $t7
lw $t5, 0($t4) 
beq $s5, $zero, FIRSTLEVEL3
addi $t5, $t5, 6 # increment $t5 by 1 
j LEVELEND3
FIRSTLEVEL3:
addi $t5, $t5, 3 #                                                                    change from      3

LEVELEND3:
div $t5, $t9
mfhi $t6
sw $t6, 0($t4) # add 3 and store back
mult $t6, $t3 # How much to move forward
mflo $t6 # $t6 stores the offset
add $t6, $t6, $t8 # $t6 stores the total offset
add $t6, $t0, $t6 # $t6 stores the final position of the pixel to place
lw $s1, red 
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
add $t6, $t6, 128
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
add $t6, $t6, 128
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
addi $t1, $t1, 1
j LOOPV3





LOGS:
# Top green 6 by 32
addi $ra, $zero, 0
lw $t0, displayAddress # $t0 stores the base address for display
addi $s7, $zero, 768
addi $t1, $zero, 0 # initialize $t1 to 0
addi $t2, $zero, 9 # initialize $t2 to 9
WOOD1:
beq $t1, $t2, STARTL1 #exit if $t1 = 9
addi $t3, $zero, 0 # initialize $t3 to 0
addi $t4, $zero, 32 # initialize $t4 to 32
# offset for row
addi $t5, $zero, 128 # set $5 to 128
mult $t1, $t5 
mflo $a0 # $a0 stores the row offset
add $a0, $a0, $s7
WOOD2:
beq $t3, $t4, ENDWOOD2 #exit if $t3 = 32

# offset for column
addi $t5, $zero, 4 # set $t5 to 4
mult $t3, $t5 
mflo $t7 # $7 stores the row offset
# Total offset
add $t6, $a0, $t7
lw $t5, brown # load green to $t5
add $t6, $t0, $t6
lw $t7, 0($t6)
beq $t7, 0xffc0cb, CHANGE
sw $t5, 0($t6)
WSTOP1:
addi $t3, $t3, 1 # $3 ++
j WOOD2
ENDWOOD2:
addi $t1, $t1, 1 # $1 ++
j WOOD1

CHANGE:
bgtz $ra, WSTOP1
addi $ra, $zero, 1
addi $t0, $zero, 3
div $t1, $t0










mflo $t0
beq $t0, $zero, SPEED1
subi $t0, $t0, 1
beq $t0, $zero, SPEED2
subi $t0, $t0, 1
beq $t0, $zero, SPEED3
lw $t0, displayAddress # $t0 stores the base address for display
j WSTOP1

SPEED1:
#reset frog
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
addi $a3, $a3, 1
lw $t0, displayAddress # $t0 stores the base address for display
#draw frog
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
j WSTOP1

SPEED3:
#reset frog
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
addi $a3, $a3, 3
lw $t0, displayAddress # $t0 stores the base address for display
#draw frog
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
j WSTOP1

SPEED2:
#reset frog
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, brown # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
subi $a3, $a3, 2
lw $t0, displayAddress # $t0 stores the base address for display
#draw frog
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
addi $t5, $zero, 0xffc0cb # load green to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
j WSTOP1





STARTL1:
lw $t0, displayAddress # $t0 stores the base address for display
la $s0, l1
add $t1, $zero, $zero
add $t2, $zero, 16
addi $t3, $zero, 4
addi $t9, $zero, 32
addi $t8, $zero, 768
LOOPL1:
bge $t1, $t2, STARTL2
mult $t1, $t3
mflo $t7
add $t4, $s0, $t7
lw $t5, 0($t4) 
beq $s5, $zero, FIRSTLEVEL4
addi $t5, $t5, 2 # increment $t5 by 1 
j LEVELEND4
FIRSTLEVEL4:
addi $t5, $t5, 1 #                                                                    change from      1

LEVELEND4:
div $t5, $t9
mfhi $t6
sw $t6, 0($t4) # add 1 and store back
mult $t6, $t3 # How much to move forward
mflo $t6 # $t6 stores the offset
add $t6, $t6, $t8 # $t6 stores the total offset
add $t6, $t0, $t6 # $t6 stores the final position of the pixel to place
lw $s1, blue 
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
add $t6, $t6, 128
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
add $t6, $t6, 128
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
addi $t1, $t1, 1
j LOOPL1

# second car
STARTL2:
lw $t0, displayAddress # $t0 stores the base address for display
la $s0, l2
add $t1, $zero, $zero
add $t2, $zero, 16
addi $t3, $zero, 4
addi $t9, $zero, 32
addi $t8, $zero, 1152
LOOPL2:
bge $t1, $t2, STARTL3
mult $t1, $t3
mflo $t7
add $t4, $s0, $t7
lw $t5, 0($t4) 
beq $s5, $zero, FIRSTLEVEL5
addi $t5, $t5, 60 # increment $t5 by 1 
j LEVELEND5
FIRSTLEVEL5:
addi $t5, $t5, 30 #                                                                    change from      3
LEVELEND5:
div $t5, $t9
mfhi $t6
sw $t6, 0($t4) # add 2 and store back
mult $t6, $t3 # How much to move forward
mflo $t6 # $t6 stores the offset
add $t6, $t6, $t8 # $t6 stores the total offset
add $t6, $t0, $t6 # $t6 stores the final position of the pixel to place
lw $s1, blue
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
add $t6, $t6, 128
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
add $t6, $t6, 128
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
addi $t1, $t1, 1
j LOOPL2

# third car
STARTL3:
lw $t0, displayAddress # $t0 stores the base address for display
la $s0, l3
add $t1, $zero, $zero
add $t2, $zero, 16
addi $t3, $zero, 4
addi $t9, $zero, 32
addi $t8, $zero, 1536
addi $s6, $zero, 8
LOOPL3:
bge $t1, $t2, BACKGROUND
mult $t1, $t3
mflo $t7
add $t4, $s0, $t7
lw $t5, 0($t4) 
beq $s5, $zero, FIRSTLEVEL6
addi $t5, $t5, 6 # increment $t5 by 1 
j LEVELEND6
FIRSTLEVEL6:
addi $t5, $t5, 3 #                                                                    change from      3

LEVELEND6:
div $t5, $t9
mfhi $t6
sw $t6, 0($t4) # add 3 and store back
mult $t6, $t3 # How much to move forward
mflo $t6 # $t6 stores the offset
add $t6, $t6, $t8 # $t6 stores the total offset
add $t6, $t0, $t6 # $t6 stores the final position of the pixel to place
lw $s1, blue
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
add $t6, $t6, 128
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
add $t6, $t6, 128
lw $t7, 0($t6)
beq $t7, 0xffc0cb, DIE
sw $s1, 0($t6)
addi $t1, $t1, 1
j LOOPL3




BACKGROUND:
# Top green 6 by 32
lw $t0, displayAddress # $t0 stores the base address for display
addi $t1, $zero, 0 # initialize $t1 to 0
addi $t2, $zero, 6 # initialize $t2 to 6
LOOP1:
beq $t1, $t2, MIDDLEBEIGE #exit if $t1 = 8
addi $t3, $zero, 0 # initialize $t3 to 0
addi $t4, $zero, 32 # initialize $t4 to 32
# offset for row
addi $t5, $zero, 128 # set $5 to 128
mult $t1, $t5 
mflo $a0 # $a0 stores the row offset
LOOP2:
beq $t3, $t4, ENDLOOP2 #exit if $t3 = 32

# offset for column
addi $t5, $zero, 4 # set $5 to 4
mult $t3, $t5 
mflo $t7 # $7 stores the row offset
# Total offset
add $t6, $a0, $t7
addi $t5, $zero, 0x00ff00 # load green to $5
add $t6, $t0, $t6
lw $t7, 0($t6)
beq $t7, 0xffc0cb, STOP1
sw $t5, 0($t6)
j CONT
STOP1:
addi $s5, $s5, 1
#reset frog
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
addi $a2, $zero, 27 # row of top left of frog
addi $a3, $zero, 14 #column of top left of frog

CONT: 
addi $t3, $t3, 1 # $3 ++
j LOOP2
ENDLOOP2:
addi $t1, $t1, 1 # $1 ++
j LOOP1


MIDDLEBEIGE:
# Low green 4 by 32
lw $t0, displayAddress # $t0 stores the base address for display
addi $t0, $t0, 1920 #set t0
addi $t1, $zero, 0 # initialize $t1 to 0
addi $t2, $zero, 3 # initialize $t2 to 3
LOOP3:
beq $t1, $t2, LOWGREEN #exit if $t1 = 8
addi $t3, $zero, 0 # initialize $t3 to 0
addi $t4, $zero, 32 # initialize $t4 to 32
# offset for row
addi $t5, $zero, 128 # set $5 to 128
mult $t1, $t5 
mflo $a0 # $a0 stores the row offset
LOOP4:
beq $t3, $t4, ENDLOOP4 #exit if $t3 = 32

# offset for column
addi $t5, $zero, 4 # set $5 to 4
mult $t3, $t5 
mflo $t7 # $7 stores the row offset
# Total offset
add $t6, $a0, $t7
addi $t5, $zero, 0xf5f5dc # load green to $5
add $t6, $t0, $t6
lw $t7, 0($t6)
beq $t7, 0xffc0cb, STOP2
sw $t5, 0($t6)
STOP2:
addi $t3, $t3, 1 # $3 ++
j LOOP4

ENDLOOP4:
addi $t1, $t1, 1 # $1 ++
j LOOP3



LOWGREEN:
# Low green 4 by 32
lw $t0, displayAddress # $t0 stores the base address for display
addi $t0, $t0, 3456 #set t0
addi $t1, $zero, 0 # initialize $t1 to 0
addi $t2, $zero, 5 # initialize $t2 to 4
LOOP5:
beq $t1, $t2, Exit #exit if $t1 = 8
addi $t3, $zero, 0 # initialize $t3 to 0
addi $t4, $zero, 32 # initialize $t4 to 32
# offset for row
addi $t5, $zero, 128 # set $5 to 128
mult $t1, $t5 
mflo $a0 # $a0 stores the row offset
LOOP6:
beq $t3, $t4, ENDLOOP6 #exit if $t3 = 32

# offset for column
addi $t5, $zero, 4 # set $5 to 4
mult $t3, $t5 
mflo $t7 # $7 stores the row offset
# Total offset
add $t6, $a0, $t7
addi $t5, $zero, 0x00ff00 # load green to $5
add $t6, $t0, $t6
lw $t7, 0($t6)
beq $t7, 0xffc0cb, STOP3
sw $t5, 0($t6)
STOP3:
addi $t3, $t3, 1 # $3 ++
j LOOP6

ENDLOOP6:
addi $t1, $t1, 1 # $1 ++
j LOOP5

DIE:
subi $a1, $a1, 1

li  $v0, 56           # service 1 is print integer
la $a0, live  # load desired value into argument register $a0, using pseudo-op
syscall

beqz $a1, DISPLAY
j RESET

DISPLAY:
#reset frog
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)



li $v0, 50
la $a0, over
syscall

beqz $a0, BEGINNING
li $v0, 10 # terminate the program gracefully

syscall


RESET:
#reset frog
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)

li $v0, 32
li $a0, 1000
syscall

#die frog 1
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, purple # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, purple # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, purple # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, purple # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, purple # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, purple # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, purple # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, purple # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)

li $v0, 32
li $a0, 1000
syscall


#reset frog
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, black # load black to $5
add $t6, $t0, $t6

li $v0, 32
li $a0, 1000
syscall

#die frog 2
#pixel 1
lw $t0, displayAddress # $t0 stores the base address for display
addi $t5, $zero, 128 # set $5 to 128
mult $a2, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $a3, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, yellow # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 4
add $t8, $a2, $zero
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, yellow # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 5
addi $t8, $a2, 1
addi $t9, $a3, 0
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, yellow # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 6
addi $t8, $a2, 1
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, yellow # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 7
addi $t8, $a2, 1
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, yellow # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 8
addi $t8, $a2, 1
addi $t9, $a3, 3
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, yellow # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 10
addi $t8, $a2, 2
addi $t9, $a3, 1
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, yellow # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)
#pixel 11
addi $t8, $a2, 2
addi $t9, $a3, 2
addi $t5, $zero, 128 # set $5 to 128
mult $t8, $t5 
mflo $a0 # $a0 stores the row offset
addi $t5, $zero, 4 # set $5 to 4
mult $t9, $t5 
mflo $t7 # $7 stores the row offset
add $t6, $a0, $t7
lw $t5, yellow # load purple to $5
add $t6, $t0, $t6
sw $t5, 0($t6)

addi $a2, $zero, 27 # row of top left of frog
addi $a3, $zero, 14 #column of top left of frog

Exit:
li $v0, 32
li $a0, 1000
syscall
j START




