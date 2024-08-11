#!/bin/bash

function exit_script() {                                                      
	exit 1                                                                    
}

apps_root=~/simulator-apps

TRACING_TOOL_PATH=~/HyFiSS/tracing-tool/tracer.so

TRACES_SAVE_PATH=~/Self-Simulated-Results/Self-Simulated-GV100-Results/HyFiSS-Results

TRACES_SAVE_RELATIVE_PATH=../Self-Simulated-Results/Self-Simulated-GV100-Results/HyFiSS-Results

SIMULATOR_PATH=~/HyFiSS

PreProcess_PATH=~/HyFiSS/sass-split/process_sass_dir

##################################################################################
###                                                                            ###
###                                  Compile                                   ###
###                                                                            ###
##################################################################################

cd $apps_root/Rodinia/src/hotspot
make clean && make

##################################################################################
###                                                                            ###
###                          Initial Collect Traces                            ###
###                                                                            ###
##################################################################################

rm -rf $TRACES_SAVE_PATH/*

mkdir $TRACES_SAVE_PATH/Rodinia

##################################################################################
###                                                                            ###
###                                  Rodinia                                   ###
###                                                                            ###
##################################################################################

cd $apps_root/Rodinia/src/hotspot
LD_PRELOAD=$TRACING_TOOL_PATH ./hotspot 512 2 2 ../../data/hotspot/temp_1024 ../../data/hotspot/power_1024 output.out
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/hotspot
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

##################################################################################
###                                                                            ###
###                             PreProcess Traces                              ###
###                                                                            ###
##################################################################################

SEARCH_ROOT=$TRACES_SAVE_PATH

find "$SEARCH_ROOT" -type d -name "sass_traces" | while read dir; do
    echo "Processing directory: $dir"
    $PreProcess_PATH --dir "$dir"
    echo "Current Time: $(date)"
done

##################################################################################
###                                                                            ###
###                              Initial Simulation                            ###
###                                                                            ###
##################################################################################

cd $SIMULATOR_PATH

CONFIG1="./gpu-simulator.x --configs"
CONFIG2="--config_file ./DEV-Def/QV100.config"

##################################################################################
###                                                                            ###
###                                  Rodinia                                   ###
###                                                                            ###
##################################################################################

mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/hotspot/configs --kernel_id 0 $CONFIG2
python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/hotspot/outputs --kernel_id 0 --np 20

exit_script