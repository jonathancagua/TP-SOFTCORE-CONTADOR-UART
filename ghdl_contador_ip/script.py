from os import system

system("C:/ghdl/ghdl-0.31-mcode-win32/bin/ghdl -a lab3_user_logic.vhd")
system("C:/ghdl/ghdl-0.31-mcode-win32/bin/ghdl -a lab3_user_logic_tb.vhd")
system("C:/ghdl/ghdl-0.31-mcode-win32/bin/ghdl -s lab3_user_logic.vhd")
system("C:/ghdl/ghdl-0.31-mcode-win32/bin/ghdl -s lab3_user_logic_tb.vhd")

system("C:/ghdl/ghdl-0.31-mcode-win32/bin/ghdl -e lab3_user_logic_tb")
system("C:/ghdl/ghdl-0.31-mcode-win32/bin/ghdl -r lab3_user_logic_tb --stop-time=2000ns --vcd=resultados.vcd")
# 
system("C:/gtkwave/bin/gtkwave resultados.vcd")