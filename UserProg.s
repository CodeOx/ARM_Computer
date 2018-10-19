mov r1, #1
mov r0, #0
str r1,[r0,#4094]
str r1,[r0,#4093]
@SWI_readChar
@SWI_writeChar
@SWI_readLine
@SWI_writeLine
mov r0, #0
mov r1,#4
str r1,[r0,#4094]
@SWI_ret