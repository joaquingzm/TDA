onerror { resume }
transcript off
add wave -noreg -logic {/usuario/DoneCompUser}
add wave -noreg -logic {/usuario/DoneCpuUser}
add wave -noreg -logic {/usuario/ReadyUser}
add wave -noreg -vgroup "UI"  {/usuario/UUT/UUT2/UUT1/CompToSM} {/usuario/UUT/UUT2/UUT1/BranchIDtoSM} {/usuario/UUT/UUT2/UUT1/BranchEXALUtoSM} {/usuario/UUT/UUT2/UUT1/Fp} {/usuario/UUT/UUT2/UUT1/LoadInstState} {/usuario/UUT/UUT2/UUT1/LoadBranchInstState} {/usuario/UUT/UUT2/UUT1/DoneID} {/usuario/UUT/UUT2/UUT1/StallHLT} {/usuario/UUT/UUT2/UUT1/StallSTR} {/usuario/UUT/UUT2/UUT1/StallRAW} {/usuario/UUT/UUT2/UUT1/StallWAWAux} {/usuario/UUT/UUT2/UUT1/StopSM} {/usuario/UUT/UUT2/UUT1/EnableSM} {/usuario/UUT/UUT2/UUT1/DataRegFP} {/usuario/UUT/UUT2/UUT1/IdRegFP} {/usuario/UUT/UUT2/UUT1/EnableRegFP}
add wave -noreg -vgroup "RegistrosEspeciales"  {/usuario/UUT/UUT2/UUT7/IP} {/usuario/UUT/UUT2/UUT7/IR} {/usuario/UUT/UUT2/UUT7/BP} {/usuario/UUT/UUT2/UUT7/SP} {/usuario/UUT/UUT2/UUT7/FLAGS} {/usuario/UUT/UUT2/UUT7/FPFLAGS} {/usuario/UUT/UUT2/UUT7/RA}
add wave -noreg -vgroup "RegistrosR"  {/usuario/UUT/UUT2/UUT7/R0} {/usuario/UUT/UUT2/UUT7/R1} {/usuario/UUT/UUT2/UUT7/R2} {/usuario/UUT/UUT2/UUT7/R3} {/usuario/UUT/UUT2/UUT7/R4} {/usuario/UUT/UUT2/UUT7/R5} {/usuario/UUT/UUT2/UUT7/R6} {/usuario/UUT/UUT2/UUT7/R7} {/usuario/UUT/UUT2/UUT7/R8} {/usuario/UUT/UUT2/UUT7/R9} {/usuario/UUT/UUT2/UUT7/R10} {/usuario/UUT/UUT2/UUT7/R11} {/usuario/UUT/UUT2/UUT7/R12} {/usuario/UUT/UUT2/UUT7/R13} {/usuario/UUT/UUT2/UUT7/R14} {/usuario/UUT/UUT2/UUT7/R15}
add wave -noreg -vgroup "RegistrosF"  {/usuario/UUT/UUT2/UUT7/F0} {/usuario/UUT/UUT2/UUT7/F1} {/usuario/UUT/UUT2/UUT7/F2} {/usuario/UUT/UUT2/UUT7/F3} {/usuario/UUT/UUT2/UUT7/F4} {/usuario/UUT/UUT2/UUT7/F5} {/usuario/UUT/UUT2/UUT7/F6} {/usuario/UUT/UUT2/UUT7/F7} {/usuario/UUT/UUT2/UUT7/F8} {/usuario/UUT/UUT2/UUT7/F9} {/usuario/UUT/UUT2/UUT7/F10} {/usuario/UUT/UUT2/UUT7/F11} {/usuario/UUT/UUT2/UUT7/F12} {/usuario/UUT/UUT2/UUT7/F13} {/usuario/UUT/UUT2/UUT7/F14} {/usuario/UUT/UUT2/UUT7/F15}
cursor "Cursor 1" 600ns  
transcript on
