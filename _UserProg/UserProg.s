mov r0, #0
mov r1,#87
str r1,[r0,#4094]
str r1,[r0,#4093]
ldr r1, [r0, #4095]
str r1, [r0, #4095]
@SWI_done