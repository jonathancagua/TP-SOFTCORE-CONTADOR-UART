library IEEE;
use IEEE.std_logic_1164.all;

entity lab3_user_logic_tb is
end lab3_user_logic_tb;

architecture lab3_user_logic_tb_arq of lab3_user_logic_tb is

	component lab3_user_logic is
		port(
			S_AXI_ACLK: 	in std_logic;
			slv_reg_wren: 	in std_logic;
			axi_awaddr: 	in std_logic_vector(1 downto 0);
			S_AXI_WDATA: 	in std_logic_vector(31 downto 0);
			S_AXI_ARESETN: 	in std_logic;
			LED: 			out std_logic_vector(7 downto 0)
		);
	end component;
		signal S_AXI_ACLK_tb: 		 std_logic := '0';
		signal slv_reg_wren_tb: 	 std_logic := '1';
		signal axi_awaddr_tb: 		 std_logic_vector(1 downto 0):= "00";
		signal S_AXI_WDATA_tb: 		 std_logic_vector(31 downto 0) := "00000000000000000000000000001001";
		signal S_AXI_ARESETN_tb: 	 std_logic := '0';
		signal LED_tb: 				 std_logic_vector(7 downto 0) := "00000001";
begin
	S_AXI_ACLK_tb <= not S_AXI_ACLK_tb after 10 ns;
	S_AXI_WDATA_tb <= "00000000000000000000000000000101" after 603 ns;
	--rx_data_rdy_tb <= not rx_data_rdy_tb after 40 ns;
	S_AXI_ARESETN_tb <= '1'  after 100 ns;
	DUT: lab3_user_logic
		port map(
			S_AXI_ACLK => S_AXI_ACLK_tb,

			slv_reg_wren => slv_reg_wren_tb,
			axi_awaddr => axi_awaddr_tb,
			S_AXI_WDATA => 	S_AXI_WDATA_tb,
			S_AXI_ARESETN => S_AXI_ARESETN_tb,
			LED => LED_tb		
		);
end lab3_user_logic_tb_arq;