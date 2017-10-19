for j in $@; do
    if [[ ${j} == "--lint" ]]; then
        for i in *.v; do
            if [[ ${i} != "testbench.v" && ${i} != "CPU.v" ]]; then
                verilator --lint-only ${i}
            fi
        done
    elif [[ ${j} == "--simulate" ]]; then
        iverilog -o testbench.vvp testbench.v && vvp testbench.vvp
    elif [[ ${j} == "--dumpview" ]]; then
        open dump.vcd
    elif [[ ${j} == "--clean" ]]; then
        rm testbench.vvp dump.vcd
    else
        echo "usage: ${0} --lint --simulate --dumpview --clean"
    fi
done
