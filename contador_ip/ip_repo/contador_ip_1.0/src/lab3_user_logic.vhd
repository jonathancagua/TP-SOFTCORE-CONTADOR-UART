-----------------------------------------------------------------
-- Module Name: lab3_user_logic
-----------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity lab3_user_logic is
	generic(
		LED_WIDTH: natural := 8	
	);
	port(
		S_AXI_ACLK: in std_logic;
		slv_reg_wren: in std_logic;
		axi_awaddr: in std_logic_vector(1 downto 0);
		S_AXI_WDATA: in std_logic_vector(31 downto 0);
		S_AXI_ARESETN: in std_logic;
		LED: out std_logic_vector(LED_WIDTH-1 downto 0)
	);
end;

architecture lab3_user_logic_tb of lab3_user_logic is
begin

	process(S_AXI_ACLK)
	begin
		if rising_edge(S_AXI_ACLK) then
			if S_AXI_ARESETN = '0' then
				LED <= (LED_WIDTH-1 downto 0 => '0');
			elsif slv_reg_wren = '1' and axi_awaddr = "00" then
				LED <= S_AXI_WDATA(LED_WIDTH-1 downto 0);
			end if;
		end if;
	end process;

end;