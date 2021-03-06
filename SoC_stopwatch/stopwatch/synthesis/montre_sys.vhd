Library ieee;
use ieee.std_logic_1164.all;

entity montre_sys is port (
	CLOCK_50 : in    std_logic;
	DRAM_CLK    : out   std_logic;
	DRAM_ADDR   : out   std_logic_vector(11 downto 0);
	DRAM_BA_0   : buffer   std_logic;
	DRAM_BA_1   : buffer   std_logic;
	DRAM_CAS_N  : out   std_logic;
	DRAM_CKE    : out   std_logic;
	DRAM_CS_N   : out   std_logic;
	DRAM_DQ     : inout std_logic_vector(15 downto 0);
	DRAM_LDQM   : buffer   std_logic;
	DRAM_UDQM   : buffer   std_logic;
	DRAM_RAS_N  : out   std_logic;
	DRAM_WE_N   : out   std_logic;
	LEDG : out   std_logic_vector(7 downto 0);
	LEDR : out   std_logic_vector(9 downto 0);
	KEY  : in    std_logic_vector(3 downto 0);
	SW   : in    std_logic_vector(9 downto 0);
	HEX0 : out   std_logic_vector(6 downto 0);
	HEX1 : out   std_logic_vector(6 downto 0);
	HEX2 : out   std_logic_vector(6 downto 0);
	HEX3 : out   std_logic_vector(6 downto 0)		);

end montre_sys;

architecture arch of montre_sys is 


    component stopwatch is
        port (
            clk_clk                           : in    std_logic                     := 'X';             -- clk
            reset_reset_n                     : in    std_logic                     := 'X';             -- reset_n
            pll_sdram_clk_clk                 : out   std_logic;                                        -- clk
            new_sdram_controller_0_wire_addr  : out   std_logic_vector(11 downto 0);                    -- addr
            new_sdram_controller_0_wire_ba    : out   std_logic_vector(1 downto 0);                     -- ba
            new_sdram_controller_0_wire_cas_n : out   std_logic;                                        -- cas_n
            new_sdram_controller_0_wire_cke   : out   std_logic;                                        -- cke
            new_sdram_controller_0_wire_cs_n  : out   std_logic;                                        -- cs_n
            new_sdram_controller_0_wire_dq    : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
            new_sdram_controller_0_wire_dqm   : out   std_logic_vector(1 downto 0);                     -- dqm
            new_sdram_controller_0_wire_ras_n : out   std_logic;                                        -- ras_n
            new_sdram_controller_0_wire_we_n  : out   std_logic;                                        -- we_n
            ledg_external_interface_export    : out   std_logic_vector(7 downto 0);                     -- export
            ledr_external_interface_export    : out   std_logic_vector(9 downto 0);                     -- export
            bd_external_interface_export      : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
            sw_external_interface_export      : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- export
            hex_external_interface_HEX0       : out   std_logic_vector(6 downto 0);                     -- HEX0
            hex_external_interface_HEX1       : out   std_logic_vector(6 downto 0);                     -- HEX1
            hex_external_interface_HEX2       : out   std_logic_vector(6 downto 0);                     -- HEX2
            hex_external_interface_HEX3       : out   std_logic_vector(6 downto 0)                      -- HEX3
        );
    end component stopwatch;

signal DRAM_BA  : std_logic_vector(1 downto 0);
signal DRAM_DQM : std_logic_vector(1 downto 0);

begin

DRAM_BA_0 <= DRAM_BA(0);
DRAM_BA_1 <= DRAM_BA(1);
DRAM_LDQM <= DRAM_DQM(0);
DRAM_UDQM <= DRAM_DQM(1);

 
    u0 : component stopwatch
        port map (
            clk_clk                           => CLOCK_50,                           --                         clk.clk
            reset_reset_n                     => KEY(0),                     --                       reset.reset_n
            pll_sdram_clk_clk                 => DRAM_CLK,                 --               pll_sdram_clk.clk
            new_sdram_controller_0_wire_addr  => DRAM_ADDR,  -- new_sdram_controller_0_wire.addr
            new_sdram_controller_0_wire_ba    => DRAM_BA,    --                            .ba
            new_sdram_controller_0_wire_cas_n => DRAM_CAS_N, --                            .cas_n
            new_sdram_controller_0_wire_cke   => DRAM_CKE,   --                            .cke
            new_sdram_controller_0_wire_cs_n  => DRAM_CS_N,  --                            .cs_n
            new_sdram_controller_0_wire_dq    => DRAM_DQ,    --                            .dq
            new_sdram_controller_0_wire_dqm   => DRAM_DQM,   --                            .dqm
            new_sdram_controller_0_wire_ras_n => DRAM_RAS_N, --                            .ras_n
            new_sdram_controller_0_wire_we_n  => DRAM_WE_N,  --                            .we_n
            ledg_external_interface_export    => LEDG,    --     ledg_external_interface.export
            ledr_external_interface_export    => LEDR,    --     ledr_external_interface.export
            bd_external_interface_export      => KEY,      --       bd_external_interface.export
            sw_external_interface_export      => SW,      --       sw_external_interface.export
            hex_external_interface_HEX0       => HEX0,       --      hex_external_interface.HEX0
            hex_external_interface_HEX1       => HEX1,       --                            .HEX1
            hex_external_interface_HEX2       => HEX2,       --                            .HEX2
            hex_external_interface_HEX3       => HEX3        --                            .HEX3
        );

end arch;