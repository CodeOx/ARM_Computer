## Programming environment for ARM using FPGA
#### Chetan Mittal, Junior Undergraduate, IIT Delhi
#### 1    Introduction
This is an implementation of the ARM processor.  An ARM processor is one of a family of CPUs based on the RISC (reduced instruction set computer) architecture  developed  by  Advanced  RISC  Machines  (ARM).  The  implementation may be used to execute basic ARM instructions and comes with the ability to integrate a keyboard and monitor.
#### 2    Getting Started
##### 2.1    Requirements:
•Basys 3 Artix-7 FPGA

•PC with a serial terminal (eg.  Teraterm)
##### 2.2    Installation:
Here is a step by step plan on how to install the Programming Environment. It will get you to a point of having a local running instance.
1. Install Vivado Design Suite (v2016.4 or greater) : https://www.xilinx.com/products/design-tools/vivado.html
2. Clone the git repository **https://github.com/CodeOx/ARMComputer.git** to a suitable location
3. Install a serial terminal eg.  Teraterm (recommended), Putty

Once all the dependencies have been installed, begin by connecting your FPGA to the PC and open the Vivado Design suite to load the bitfile to the FPGA (present inside the bitfile directory). To do this, open Flow -> open HardwareManager inside the Vivado Design Suite, connect to the FPGA and then Program Device using the given bitfile. After the bitfile has been loaded, open the serial terminal (TeraTerm) and follow the Teraterm setup instructions:
1. Open a new connection to the serial port
2. Open Setup ->Terminal and set receive to Auto, baud rate to 9600

After  this,  press  the  start  button  on  FPGA,  the  topmost  button  of  the  five circular buttons. This will start the inbuilt OS, showing the available options on the terminal.  Enter the required option to continue. To  program, enter 1, goto File->sendfile and  select  the  binary  file  containing the ARM code. Ensure that the binay file checkbox is checked. This will load the program in the instruction memory. Enter 2 to execute the program. You can exit by pressing ’q’. 

A sample ARM program, helloUser, is available in the _UserProg directory for testing.
#### 3    SWI Instructions

| Instruction | Symbol | Hex Code | Action |
| ------------| ------ | -------- | ------ |
| goto        | SWI_go | EF000000 | saves the currrent state (falgs and PC) to the SPSR and updates PC to the address specified in the instruction (Last 16 bits or last 4 digits in the Hex Code) |
| return  | SWI_ret | EF800000 | restores flag and PC from the SPSR |
| print char | SWI_writeChar | EF00000C | Prints the character (stored in R0) to the terminal |
| read char | SWI_readChar | EF000000 | Reads character from the keyboard and stores the ASCII value in R0 |
| print text | SWI_writeLine | EF000040 | Writes text to the terminal. The address of the first character must be stored in R0. Newline is represented by \r and the text must be terminated by \n. |
| read text | SWI_readLine | EF000018 | Reads text from the keyboard. The address of the first character is stored in R0. Both \n and \r act as terminating characters, thereby allowing a single line input. |
| write instruction | SWI_saveIns | EFC00001 | Writes an instruction to the instruction memory. Used to load file into the instruction memory. |
| execute | SWI_execute | EF000190 | Executes the user program |
| execution complete | SWI_done | EF00006C | Marks the completion of execution and returns to the OS loop |
| exit | SWI_exit | EFFFFFFF | stops and exits (used to quit from the OS) |

#### 4    User program file

The last command of the user program must be SWI_done indicating the completion of execution. The file must end with EOT (Hex : 04) byte.
