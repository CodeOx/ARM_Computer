mov r0, #0
ldr r0, [r0, #4095]
@SWI_ret

mov r1, #0
str r0, [r1, #4095]
@SWI_ret

mov r0, r13	@starting address
mov r2, #0
mov r3, r0	@iterator	
ReadLoop:
ldr r1, [r2, #4095]
str r1, [r3]
add r3, r3, #4
cmp r1, #13
bne ReadLoop
add r13, r3, #4
@SWI_ret

mov r1, r0
mov r2, #0
WriteLoop:
ldr r0, [r1]
str r0, [r2, #4095]
add r1,r1,#4
cmp r0,#13
bne WriteLoop
@SWI_ret

mov r0,#0

@OS startup begins after 25 instructions

mov r0, #0
@SWI_writeLine

@user program begins after 27 instructions, user data begins after 100 locations

mov r1, #1
mov r0, #0
str r1,[r0,#4094]
str r1,[r0,#4093]
@SWI_readChar
@SWI_writeChar
@SWI_readLine
@SWI_writeLine
mov r0,#0
mov r1,#4
str r1,[r0,#4094]
@SWI_exit