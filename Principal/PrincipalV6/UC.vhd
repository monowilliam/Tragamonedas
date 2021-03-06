library ieee;
use ieee.std_logic_1164.all,ieee.std_logic_unsigned.all;

entity UC is
generic(
	top : natural
);
port (
	Opcode : in std_logic_vector(top-1 downto 0);
	Clk : in std_logic;
	PCWrite,Beq,Bne,Bgt,Jump,WIR,Dg,WRF,AluSrcA,DatSel,RMD,WMD : out std_logic;
	AluOP : out std_logic_vector(1 downto 0);
	IO : out std_logic_vector(1 downto 0)
	);
end entity;

architecture UC_arc of UC is
type Estado is (Fetch,Decode,Dir,RM,OutSS,Inp,WM,ExJ,ExBeq,ExBne,ExBgt,CalDirSM,GuarDir,CalDirLM,LeerMem,GuarMem,ExecuteADDI,ExecuteADD,ExecuteMUL,ExecuteSUB,WRegister);
shared variable est_actual : Estado := Fetch;
shared variable est_sig : Estado;
begin
process(Clk) begin
	est_actual:=est_sig;
end process;
process (Clk) begin
	case est_actual is
		when Fetch =>
			PCwrite <= '1';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '1';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "00";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := Decode;
		when Decode => 
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "00";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			if Opcode = "0000" then
				est_sig := Inp;
			end if;
			if Opcode = "0001" then
				est_sig := ExecuteADDI;
			end if;
			if Opcode = "0010" then
				est_sig := ExecuteADD;
			end if;
			if Opcode = "0011" then
				est_sig := ExecuteMUL;
			end if;
			if Opcode = "0100" then
				est_sig := CalDirSM;
			end if;
			if Opcode = "0101" then
				est_sig := CalDirLM;
			end if;
			if Opcode = "0110" then
				est_sig := ExBeq;
			end if;
			if Opcode = "0111" then
				est_sig := ExBne;
			end if;
			if Opcode = "1000" then
				est_sig := ExBgt;
			end if;
			if Opcode = "1001" then
				est_sig := ExecuteSUB;
			end if;
			if Opcode = "1010" then
				est_sig := ExJ;
			end if;
			if Opcode = "1011" then
				est_sig := Dir;
			end if;
		when ExecuteADDI =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "00";
			AluSrcA <= '1';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := WRegister;
		when ExecuteADD =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "00";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := WRegister;
		when ExecuteMUL =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "10";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := WRegister;
		when ExecuteSUB =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "01";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := WRegister;
		when WRegister =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '1';
			AluOP <= "00";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := Fetch;
		when ExJ =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='1';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "00";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := Fetch;
		when ExBeq =>
			PCwrite <= '0';
			Beq <= '1';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "01";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := Fetch;
		when ExBne =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '1';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "01";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := Fetch;
		when ExBgt =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '1';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "01";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := Fetch;
		when Dir =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "11";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := RM;
		when RM =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "00";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '1';
			WMD <= '0';
			IO <= "00";
			est_sig := OutSS;
		when OutSS =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "00";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "11";
			est_sig := Fetch;
		when Inp =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "11";
			AluSrcA <= '0';
			DatSel <= '1';
			RMD <= '0';
			WMD <= '1';
			IO <= "00";
			est_sig := WM;
		when WM =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "00";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '1';
			IO <= "00";
			est_sig := Fetch;
		when CalDirSM =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "00";
			AluSrcA <= '1';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := GuarDir;
		when GuarDir =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "00";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '1';
			IO <= "00";
			est_sig := Fetch;
		when CalDirLM =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "00";
			AluSrcA <= '1';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := LeerMem;
		when LeerMem =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '0';
			WRF <= '0';
			AluOP <= "00";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '1';
			WMD <= '0';
			IO <= "00";
			est_sig := GuarMem;
		when GuarMem =>
			PCwrite <= '0';
			Beq <= '0';
			Bne <= '0';
			Bgt <= '0';
			Jump <='0';
			WIR <= '0';
			Dg <= '1';
			WRF <= '1';
			AluOP <= "00";
			AluSrcA <= '0';
			DatSel <= '0';
			RMD <= '0';
			WMD <= '0';
			IO <= "00";
			est_sig := Fetch;
	end case;
end process;

end architecture;