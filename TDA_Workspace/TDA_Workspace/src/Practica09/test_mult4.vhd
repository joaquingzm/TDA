

entity Mult4 is	
	port(
		A, B: in Bit_Vector(3 downto 0);
		STB, CLK: in Bit;
		Result: out Bit_Vector(7 downto 0);
		Done: out Bit
	);
end;

architecture behaviour of Mult4 is
	

component Adder8
	port (
		A, B: in Bit_Vector(7 downto 0);
		Cin: in Bit;
		Cout: out Bit;
		Sum: out Bit_Vector(7 downto 0)
	);
end component;									
	

component ShiftN
	port (
		CLK: in  Bit;
		CLR: in  Bit;
		LD: in  Bit;
		SH: in  Bit;
		DIR: in  Bit;
		D: in Bit_Vector;
		Q: out  Bit_Vector
	);
end component;
	

component Controller
	port (
		STB, CLK, LSB, Stop: in   Bit;
		Init, Shift, Add, Done: out  Bit
	);
end component;
	
signal STOP, SHIFT, INIT, ADD: Bit;
signal Q_A, Q_B,D_ACC,Q_ACC: Bit_vector(7 downto 0);
	
begin					   
		
	STOP <= not (Q_A(7) or Q_A(6) or Q_A(5) or Q_A(4) or Q_A(3) or Q_A(2) or Q_A(1) or Q_A(0));
		
	FSMController: Controller port map(
		CLK => CLK,
		STB => STB,
		LSB => Q_A(0),
		STOP => STOP,
		Init => INIT, 
		SHIFT => SHIFT,
		Add => ADD,
		Done => Done
	);
		
	Adder: Adder8 port map(
		A => Q_ACC,
		B => Q_B,
		Cin => '0',
		Cout => open,
		Sum  => D_ACC
	);	
	
	SRB: ShiftN port map(
		CLK => CLK,
		CLR => '0',
		LD => INIT,
		SH => SHIFT,
		DIR => '1',
		D => B,
		Q => Q_B
	);
		
	SRAa: ShiftN port map(
		CLK => CLK,
		CLR => '0',
		LD => INIT,
		SH => SHIFT,
		DIR => '0',
		D => A,
		Q => Q_A
	); 	   
		
	ACC: ShiftN port map(
		CLK => CLK,
		CLR => INIT,
		LD => ADD,
		SH => '0',
		DIR => '0',
		D => D_ACC,
		Q => Q_ACC
	); 
	
	Result <= Q_ACC;
		
end;


--------------------Testbench -------------------------------


entity test_mult4 is end;

use work.Utils.all;	

architecture Driver of test_mult4 is

component Mult4
	port(
		A, B: in Bit_Vector(3 downto 0);
		STB, CLK: in Bit;
		Result: out Bit_Vector(7 downto 0);
		Done: out Bit
	);		 
end component;

signal A, B: Bit_vector(3 downto 0);  
signal Result: Bit_vector(7 downto 0);
signal Done, STB, CLK: Bit;	

constant NA: natural := 1;
constant NB: natural := 7;	 
constant FREQ_HZ: real := 37.0 * 2.0e6;
constant CLK_PERIOD: time := 1 sec / FREQ_HZ;


begin
	UUT: Mult4 port map(
		A => A,
		B => B,
		STB => STB,
		CLK => CLK,
		Result => Result,
		Done => Done
	);
	
	C: Clock(CLK, CLK_PERIOD/2.0, CLK_PERIOD/2.0);
	
	Stimulus: process
	begin
		A <= Convert(NA,4);
		B <= Convert(NB,4);
		STB <= '1', '0' after 1.1*CLK_PERIOD;	
		wait;
	end process;	 
	
	
end;