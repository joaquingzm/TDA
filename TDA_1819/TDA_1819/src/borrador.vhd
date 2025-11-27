			WHEN POPH =>
				report "Entraste al pop pa";  	
				
				--- Numero de registro a escribir en WB (en el formato en el que lo recibe es nroReg + 1)
				rdAux := to_integer(unsigned(IFtoIDLocal.package1(7 downto 0))) + 1;
				
				report "Registro del pop: r" & integer'image(rdAux-1);
				
				--- Instrucciones a la etapa de WB de en que registro escribir, con los datos de que etapa y cuantos bytes
				IDtoWB.mode <= std_logic_vector(to_unsigned(rdAux, IDtoWB.mode'length));
				IDtoWB.datasize <= std_logic_vector(to_unsigned(2, IDtoWB.datasize'length));
				IDtoWB.source <= std_logic_vector(to_unsigned(WB_MEM, IDtoWB.source'length));
				
				
				--- Accedo al registro SP
				IdRegID <= std_logic_vector(to_unsigned(ID_SP, IdRegID'length));
				SizeRegID <= std_logic_vector(to_unsigned(2, SizeRegID'length));
				EnableRegID <= '1';
				WAIT FOR 1 ns;
				EnableRegID <= '0';
				WAIT FOR 1 ns;
				addrAux := to_integer(unsigned(DataRegOutID(15 downto 0)));	 
				
				report "Registro SP: " & integer'image(addrAux);
				
				-- Actualizar SP = SP - 2
				
				 
				DataRegInID(31 downto 16) <= "ZZZZZZZZZZZZZZZZ";
				DataRegInID(15 downto 0) <= std_logic_vector(to_unsigned(addrAux - 2, 16));  -- SP_viejo - 2
				EnableRegIDSP <= '1';
				WAIT FOR 1 ns;
				EnableRegIDSP <= '0';
				WAIT FOR 1 ns;		   
				
				report "Llegaste pa";
				
				
				--- Instrucciones a la etapa MA, que hacer en que direccion y cuantos bytes leer
				IDtoMA.address <= std_logic_vector(to_unsigned(addrAux-2, IDtoMA.address'length));
				IDtoMA.mode <= std_logic_vector(to_unsigned(MEM_MEM, IDtoMA.mode'length));
				IDtoMA.read <= '1';
				IDtoMA.datasize <= std_logic_vector(to_unsigned(2, IDtoMA.datasize'length));
				
			