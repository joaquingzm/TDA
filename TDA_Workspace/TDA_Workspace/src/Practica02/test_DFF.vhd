entity DFF is
    port (Preset: in Bit; Clear: in Bit; Clock: in Bit; Data: in Bit; Q:out Bit;
    QBar: out Bit);
end DFF;

architecture flujodedatos of DFF is
    signal A, B, C, D: Bit;
    signal Qint, QbarInt: Bit;
begin
    A <= not (Preset and D and B) after 1 ns;
    B <= not (A and Clear and Clock) after 1 ns;
    C <= not (B and Clock and D) after 1 ns;
    D <= not (C and Clear and Data) after 1 ns;
    Qint <= not (Preset and B and QbarInt) after 1 ns;
    QbarInt <= not (Qint and Clear and C) after 1ns;
    Q <= Qint;
    QBar <= QbarInt;
end;

------ testbench ------

entity Test_DFF is end;

architecture Driver of Test_DFF is
    component DFF
        port (Preset, Clear, Clock, Data: in Bit; Q, Qbar: out Bit);
    end component;
    signal Preset, Clear: Bit := '1';
    signal Clock, Data, Q, QBar: Bit;     

    -- Constante de período del clock
    constant Tclk : time := 12 ns;
    constant SimTime : time := 100 ns;

begin
UUT: DFF port map (Preset, Clear, Clock, Data, Q, Qbar);

Clock_process : process
    constant NumCiclos : integer := SimTime / Tclk; -- cantidad de ciclos de clock
begin
    for i in 1 to NumCiclos loop
        Clock <= '0';
        wait for Tclk/2;
        Clock <= '1';
        wait for Tclk/2;
    end loop;
    wait;
end process;


Stimulus: Process
Begin                      
    
    -- chequeo de preset y clear
    Preset <= '0'; wait for 5 ns; Preset <= '1'; wait for 5 ns;
    Clear <= '0'; wait for 5 ns; Clear <= '1'; wait for 5 ns;
    
    -- interaccion de preset y clear
    Preset <= '0'; Clear <= '0'; wait for 5 ns;
    Preset <= '1'; Clear <= '1'; wait for 5 ns;      
    
    -- limpiar
    Clear <= '0', '1' after 5 ns; wait for 10 ns; 
    
    -- chequeo de datos y clock
    Data <= '1'; wait for 10 ns;
    Data <= '0'; wait for 10 ns;
    
    -- limpiar
    Clear <= '0', '1' after 5 ns; wait for 10 ns;
    
    --interaccion de preset y clock
    Data <= '0'; Preset <= '0', '1' after 10 ns;
    wait for 10 ns;            
    
    Wait;
end process;
end;
