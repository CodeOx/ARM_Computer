mov r0, #0
ldr r0, [r0, #4095]
@SWI_ret

mov r1, #0
str r0, [r1, #4095]
@SWI_ret

mov r0, #0	@starting address
mov r2, #0
mov r3, r0	@iterator	
Loop:
ldr r1, [r2, #4095]
str r1, [r3]
add r3, r3, #4
cmp r1, #13
bne Loop
@SWI_ret

mov r0,#0
mov r0,#0
mov r0,#0
mov r0,#0
mov r0,#0

@user program begins after 20 instructions

mov r1, #1
mov r0, #0
str r1,[r0,#4094]
str r1,[r0,#4093]
@SWI_readChar
@SWI_writeChar
@SWI_readLine
ldr r0,[r0]
@SWI_writeChar
mov r0,#0
mov r1,#4
str r1,[r0,#4094]
@SWI_exit