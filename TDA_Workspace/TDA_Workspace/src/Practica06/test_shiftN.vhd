---- Simule la entidad y el testbench. 
---  a) ¿Cómo se deben escribir las declaraciones de las señales D y Q en el testbench para que 
------- el assert despliegue el cartel?
---  b) Establezca la máxima frecuencia (o mínimo período de tiempo) de trabajo de la señal 
------- de reloj CLK, que permita el desplazamiento de datos sin perderlo. Para ello puede
------- hacer un testbench totalmente nuevo.
entity ShiftN is
   port (CLK: in Bit; 
	CLR: in Bit; 
	LD: in Bit; 
	SH: in Bit; 
	DIR: in Bit; 
	D: in Bit_Vector; 
	Q: out Bit_Vector);
begin
  assert (D'Length <= Q'Length)
    report "Entrada D no debe ser mas 'ancha' que la salida Q"
      severity Failure;
end ShiftN;

architecture Behavior of ShiftN is
begin
  Shifter: process (CLR, CLK)
    subtype InBits  is Natural range D'Length-1 downto 0;
    subtype OutBits is Natural range Q'Length-1 downto 0;
    variable State: Bit_Vector(OutBits);
  begin
    if CLR = '1' then
      State := (others => '0');
      Q <= State after 3ns;
    elsif CLK'Event and CLK='1' then
         if LD = '1' then
            State := (others => '0');
            State(InBits) := D;
            Q <= State after 5ns;
         elsif SH = '1' then
            case DIR is
              when '0' => State := '0' & State(State'Left downto 1);
              when '1' => State := State(State'Left-1 downto 0) & '0';
            end case;
            Q <= State after 7ns;
         end if;
    end if;
  end process;
end;
--------------------------Testbench-------------------------

entity Test_ShiftN is end;

architecture Driver of Test_ShiftN is
  component ShiftN
    port (CLK: in  Bit;  CLR: in  Bit; LD: in  Bit;
          SH: in  Bit;  DIR: in  Bit;
          D: in Bit_Vector; Q: out  Bit_Vector);
  end component;
  signal CLK, CLR, LD, SH, DIR: Bit;
  signal D: Bit_Vector(1 to 4); 			
  signal Q: Bit_Vector(8 downto 1);
begin
  UUT: ShiftN port map (CLK, CLR, LD, SH, DIR, D, Q);
  Stimulus: process
     begin  
        CLR <= '1', '0' after 10ns;     -- limpiar el registro
        wait for 10ns;
        D <= "1110";                        -- cargar el registro
        LD <= '1', '0' after 10ns;
        CLK <= '0', '1' after 3 ns;
        wait for 10 ns;
        SH <= '1';                              -- desplazar a izquierda el patrón de bits
        DIR <= '1';
        for i in 1 to 5 loop
            CLK <= '0', '1' after 3.5ns;
            wait for 7 ns;
        end loop;
        DIR <= '0';                            -- desplazar a derecha el patrón de bits
        for i in 1 to 8 loop
            CLK <= '0', '1' after 3.5 ns;
            wait for 7 ns;
        end loop;
		wait;
     end process;
end;
