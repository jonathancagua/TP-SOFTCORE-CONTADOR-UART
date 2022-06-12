-----------------------------------------------------------------
-- Module Name: lab3_user_logic
-----------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

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
	   variable cnt : UNSIGNED(LED_WIDTH-1 downto 0);
	   variable cnt_2 : UNSIGNED(LED_WIDTH-1 downto 0);
	   variable cnt_3 : UNSIGNED(LED_WIDTH-1 downto 0);
	begin
		if rising_edge(S_AXI_ACLK) then
			if S_AXI_ARESETN = '0' then
				LED <= (LED_WIDTH-1 downto 0 => '0');
				cnt 			:= (others => '0');
				cnt_2 			:= (others => '0');
				cnt_3 			:= (others => '0');
			elsif slv_reg_wren = '1' and axi_awaddr = "00" then
				--LED <= S_AXI_WDATA(LED_WIDTH-1 downto 0);
				cnt_2(3) := '1';
				cnt_2(2) := '1';
				cnt_2(1) := '1';
				cnt_2(0) := '1';
				if S_AXI_WDATA(1 downto 0) = "01" then
				    cnt := cnt + 1;
                elsif S_AXI_WDATA(1 downto 0) = "10" then
                    cnt := cnt - 1;
				end if;
				
				if S_AXI_WDATA(3 downto 2) = "01" then
                    cnt_3 := cnt / 15;
                elsif S_AXI_WDATA(3 downto 2) = "10" then
                    cnt_3 := cnt;
                end if;
				LED  <= std_logic_vector(cnt_3) and std_logic_vector(cnt_2);
			end if;
		end if;
	end process;

end;
