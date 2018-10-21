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
