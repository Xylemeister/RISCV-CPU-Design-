#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f MasterCPU.vcd

display_menu()
    echo "Team 04 "




# Obtain absolute path of instmem
absolute_path=$(realpath "../../rtl/instr.mem")
# Check if the file exists
if [ ! -e "$absolute_path" ]; then
    echo "Error: File not found: $absolute_path"
    exit 1
fi

# Write absolute path to file
printf "%s" "$absolute_path" > ../../rtl/instmem_path.txt

# Request datamem path from user
echo "Please enter the absolute path of the data memory file to load:"
read -r absolute_path

# Check if the file exists
if [ ! -e "$absolute_path" ]; then
    echo "Error: File not found: $absolute_path"
    exit 1
fi
# Write absolute path to file
printf '%s' "$absolute_path" > ../../rtl/datamem_path.txt



# run Verilator to translate Veriliog to C++, including C++ testbench

verilator -Wall --cc -I../../rtl ../../rtl/alu.sv
verilator -Wall --cc -I../../rtl  ../../rtl/reg_file.sv
verilator -Wall --cc -I../../rtl  ../../rtl/data_mem.sv
verilator -Wall --cc -I../../rtl  ../../rtl/orange.sv 

verilator -Wall --cc -I../../rtl ../../rtl/P_C.sv

verilator -Wall --cc -I../../rtl  ../../rtl/sextend.sv
verilator -Wall --cc -I../../rtl  ../../rtl/inst_mem.sv
verilator -Wall --cc -I../../rtl  ../../rtl/control.sv
verilator -Wall --cc -I../../rtl ../../rtl/green.sv


verilator -Wall --cc -I../../rtl --trace ../../rtl/master.sv --exe cpu_tb.cpp

# build C++ project via make automatically generated by Verilator
make -j -C obj_dir -f Vmaster.mk Vmaster

#run executable simulation file
obj_dir/Vmaster
