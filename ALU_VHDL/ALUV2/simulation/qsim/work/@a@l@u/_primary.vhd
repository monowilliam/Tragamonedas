library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        S               : in     vl_logic_vector(1 downto 0);
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        Z               : out    vl_logic;
        N               : out    vl_logic;
        OUTPUT          : out    vl_logic_vector(15 downto 0)
    );
end ALU;
