--------------------------------------------------------------------------------
-- PROJECT: SIMPLE UART FOR FPGA
--------------------------------------------------------------------------------
-- MODULE:  UART LOOPBACK EXAMPLE TOP MODULE
-- AUTHORS: Jakub Cabal <jakubcabal@gmail.com>
-- LICENSE: The MIT License (MIT), please read LICENSE file
-- WEBSITE: https://github.com/jakubcabal/uart_for_fpga
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- UART FOR FPGA REQUIRES: 1 START BIT, 8 DATA BITS, 1 STOP BIT!!!
-- OTHER PARAMETERS CAN BE SET USING GENERICS.

entity UART_LOOPBACK is
    Generic (
        CLK_FREQ   : integer := 100e6;   -- 100e6 << 100MHz set system clock frequency in Hz
        BAUD_RATE  : integer := 9600; -- baud rate value
        PARITY_BIT : string  := "none"  -- legal values: "none", "even", "odd", "mark", "space"
    );
    Port (
        CLK        : in  std_logic; -- system clock
        RST_N      : in  std_logic; -- low active synchronous reset
        -- UART INTERFACE
        UART_TXD   : out std_logic;
        UART_RXD   : in  std_logic;
        -- DEBUG INTERFACE
        --BUSY       : out std_logic;
        --FRAME_ERR  : out std_logic;
        -- LED
        --DATA_OUT    : out  std_logic_vector(7 downto 0);
        --reset_LED   : out std_logic;
        -- Slave
        Hsel : in STD_LOGIC;
        Haddress : in STD_LOGIC_VECTOR(15 downto 0);
        HWrite : in STD_LOGIC;
        HTrans : in STD_LOGIC_VECTOR(1 downto 0);
        HWData : in STD_LOGIC_VECTOR(31 downto 0);
        HRData : out STD_LOGIC_VECTOR(31 downto 0);
        HReady : out STD_LOGIC
    );
end UART_LOOPBACK;

architecture FULL of UART_LOOPBACK is
    Type State is (
        IDLE,
        WRITE_TO_PC,
        WRITE_WAIT,
        READ_FROM_PC,
        READ_COMPLETE_1,
        READ_COMPLETE_2,
        WRITE_LOOPBACK,
        WRITE_COMPLETE_1,
        WRITE_COMPLETE_2
    );
    signal BUSY : STD_LOGIC;
    signal FRAME_ERR : STD_LOGIC;
    signal data_in_temp    : std_logic_vector(7 downto 0);
    signal data_out_temp    : std_logic_vector(7 downto 0);
    signal data_send_temp : STD_LOGIC;
    signal valid   : std_logic;
    signal valid_reg : std_logic := '0';
    signal curr_state : State:=IDLE;

begin
	uart_i: entity work.UART
    generic map (
        CLK_FREQ    => CLK_FREQ,
        BAUD_RATE   => BAUD_RATE,
        PARITY_BIT  => PARITY_BIT
    )
    port map (
        CLK         => CLK,
        RST         => RST_N,
        -- UART INTERFACE
        UART_TXD    => UART_TXD,
        UART_RXD    => UART_RXD,
        -- USER DATA OUTPUT INTERFACE
        DATA_OUT    => data_out_temp,
        DATA_VLD    => valid,
        FRAME_ERROR => FRAME_ERR,
        -- USER DATA INPUT INTERFACE
        DATA_IN     => data_in_temp,
        DATA_SEND   => data_send_temp,
        BUSY        => BUSY
    );
    
    process(CLK, RST_N)
    begin
        if RST_N = '1' then 
            curr_state<=IDLE;
        elsif rising_edge(CLK) then
            case curr_state is
                when IDLE =>
                   if HTrans = "10" and HSel ='1' and BUSY = '0' then
                       if HWrite = '1' then
                            curr_state <= WRITE_TO_PC;
                       else
                            curr_state <= READ_FROM_PC;
                       end if;
                   end if;
                when READ_FROM_PC =>
                    if valid_reg = '1' then
                        curr_state <= READ_COMPLETE_1;
                    end if;
                when READ_COMPLETE_1=>
                    curr_state <= READ_COMPLETE_2;
                when WRITE_TO_PC =>
                    curr_state <= WRITE_WAIT;
                when WRITE_WAIT=>
                    if BUSY = '0' then
                        curr_state <= WRITE_COMPLETE_1;
                    end if;
                when WRITE_COMPLETE_1=>
                    curr_state <= WRITE_COMPLETE_2;
                when others => curr_state <= IDLE;
            end case;
        end if;
    end process;  
    
    valid_reg <= valid;
    
    data_send_temp <= '1' when curr_state = WRITE_TO_PC or valid = '1' else '0';
    data_in_temp <= HWData(7 downto 0) when curr_state = WRITE_TO_PC or curr_state = WRITE_WAIT else
                    data_out_temp;
    HRData <= "000000000000000000000000" & data_out_temp;
    HReady <= '1' when curr_state = READ_COMPLETE_1 or 
                       curr_state = READ_COMPLETE_2 or
                       curr_state = WRITE_COMPLETE_1 or
                       curr_state = WRITE_COMPLETE_2 else '0';

end FULL;