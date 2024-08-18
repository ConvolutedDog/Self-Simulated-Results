#!/bin/bash

function exit_script() {                                                      
	exit 1                                                                    
}

apps_root=~/simulator-apps

TRACING_TOOL_PATH=~/HyFiSS/tracing-tool/tracer.so

TRACES_SAVE_PATH=~/Self-Simulated-Results/Self-Simulated-A100-Results/HyFiSS-Results

TRACES_SAVE_RELATIVE_PATH=../Self-Simulated-Results/Self-Simulated-A100-Results/HyFiSS-Results

SIMULATOR_PATH=~/HyFiSS

PreProcess_PATH=~/HyFiSS/sass-split/process_sass_dir

##################################################################################
###                                                                            ###
###                                  Compile                                   ###
###                                                                            ###
##################################################################################

cd $apps_root
./cleanall.sh && ./buildall.sh

##################################################################################
###                                                                            ###
###                          Initial Collect Traces                            ###
###                                                                            ###
##################################################################################

rm -rf $TRACES_SAVE_PATH/*

mkdir $TRACES_SAVE_PATH/cublas_GemmEx_HF_CC
mkdir $TRACES_SAVE_PATH/PolyBench
mkdir $TRACES_SAVE_PATH/Rodinia
mkdir $TRACES_SAVE_PATH/DeepBench
mkdir $TRACES_SAVE_PATH/Tango
mkdir $TRACES_SAVE_PATH/LULESH
mkdir $TRACES_SAVE_PATH/PENNANT

##################################################################################
###                                                                            ###
###                            cublas_GemmEx_HF_CC                             ###
###                                                                            ###
##################################################################################

cd $apps_root/cublas_GemmEx_HF_CC
LD_PRELOAD=$TRACING_TOOL_PATH ./cublas_GemmEx_HF_CC_example -m 2048 -n 2048 -k 2048
trace_save_dir=$TRACES_SAVE_PATH/cublas_GemmEx_HF_CC/2048x2048x2048
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

##################################################################################
###                                                                            ###
###                                 PolyBench                                  ###
###                                                                            ###
##################################################################################

cd $apps_root/PolyBench/CUDA/2DCONV
LD_PRELOAD=$TRACING_TOOL_PATH ./2DConvolution.exe 
trace_save_dir=$TRACES_SAVE_PATH/PolyBench/2DCONV
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/PolyBench/CUDA/3DCONV
LD_PRELOAD=$TRACING_TOOL_PATH ./3DConvolution.exe
trace_save_dir=$TRACES_SAVE_PATH/PolyBench/3DCONV
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/PolyBench/CUDA/3MM
LD_PRELOAD=$TRACING_TOOL_PATH ./3mm.exe
trace_save_dir=$TRACES_SAVE_PATH/PolyBench/3MM
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/PolyBench/CUDA/ATAX
LD_PRELOAD=$TRACING_TOOL_PATH ./atax.exe
trace_save_dir=$TRACES_SAVE_PATH/PolyBench/ATAX
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/PolyBench/CUDA/BICG
LD_PRELOAD=$TRACING_TOOL_PATH ./bicg.exe
trace_save_dir=$TRACES_SAVE_PATH/PolyBench/BICG
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/PolyBench/CUDA/GEMM
LD_PRELOAD=$TRACING_TOOL_PATH ./gemm.exe
trace_save_dir=$TRACES_SAVE_PATH/PolyBench/GEMM
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/PolyBench/CUDA/GESUMMV
LD_PRELOAD=$TRACING_TOOL_PATH ./gesummv.exe
trace_save_dir=$TRACES_SAVE_PATH/PolyBench/GESUMMV
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/PolyBench/CUDA/GRAMSCHM
LD_PRELOAD=$TRACING_TOOL_PATH ./gramschmidt.exe
trace_save_dir=$TRACES_SAVE_PATH/PolyBench/GRAMSCHM
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/PolyBench/CUDA/MVT
LD_PRELOAD=$TRACING_TOOL_PATH ./mvt.exe
trace_save_dir=$TRACES_SAVE_PATH/PolyBench/MVT
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

##################################################################################
###                                                                            ###
###                                  Rodinia                                   ###
###                                                                            ###
##################################################################################

cd $apps_root/Rodinia/src/b+tree
LD_PRELOAD=$TRACING_TOOL_PATH ./b+tree file ../../data/b+tree/mil.txt command ../../data/b+tree/command.txt
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/b+tree
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Rodinia/src/backprop
LD_PRELOAD=$TRACING_TOOL_PATH ./backprop 65536
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/backprop
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Rodinia/src/bfs
LD_PRELOAD=$TRACING_TOOL_PATH ./bfs ../../data/bfs/graph1MW_6.txt
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/bfs
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Rodinia/src/cfd
LD_PRELOAD=$TRACING_TOOL_PATH ./euler3d ../../data/cfd/fvcorr.domn.097K
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/cfd
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Rodinia/src/dwt2d
LD_PRELOAD=$TRACING_TOOL_PATH ./dwt2d rgb.bmp -d 1024x1024 -f -5 -l 3
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/dwt2d
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Rodinia/src/gaussian
LD_PRELOAD=$TRACING_TOOL_PATH ./gaussian -f ../../data/gaussian/matrix1024.txt
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/gaussian
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Rodinia/src/hotspot
LD_PRELOAD=$TRACING_TOOL_PATH ./hotspot 512 2 2 ../../data/hotspot/temp_1024 ../../data/hotspot/power_1024 output.out
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/hotspot
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Rodinia/src/hotspot3D
LD_PRELOAD=$TRACING_TOOL_PATH ./3D 512 8 100 ../../data/hotspot3D/power_512x8 ../../data/hotspot3D/temp_512x8 output.out
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/hotspot3D
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Rodinia/src/huffman
LD_PRELOAD=$TRACING_TOOL_PATH ./pavle ../../data/huffman/test1024_H2.206587175259.in 
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/huffman
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Rodinia/src/lavaMD
LD_PRELOAD=$TRACING_TOOL_PATH ./lavaMD -boxes1d 10
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/lavaMD
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Rodinia/src/lud
LD_PRELOAD=$TRACING_TOOL_PATH ./lud_cuda -i ../../data/lud/2048.dat
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/lud
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Rodinia/src/nn
LD_PRELOAD=$TRACING_TOOL_PATH ./nn filelist -r 5 -lat 30 -lng 90
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/nn
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Rodinia/src/nw
LD_PRELOAD=$TRACING_TOOL_PATH ./needle 2048 10
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/nw
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Rodinia/src/pathfinder
LD_PRELOAD=$TRACING_TOOL_PATH ./pathfinder 100000 100 20
trace_save_dir=$TRACES_SAVE_PATH/Rodinia/pathfinder
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

##################################################################################
###                                                                            ###
###                                 DeepBench                                  ###
###                                                                            ###
##################################################################################

cd $apps_root/DeepBench/code/nvidia/bin

LD_PRELOAD=$TRACING_TOOL_PATH ./conv_bench inference half 700 161 1 1 32 20 5 0 0 2 2
trace_save_dir=$TRACES_SAVE_PATH/DeepBench/conv_bench_inference_halfx700x161x1x1x32x20x5x0x0x2x2
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

LD_PRELOAD=$TRACING_TOOL_PATH ./gemm_bench inference half 1760 7000 1760 0 0
trace_save_dir=$TRACES_SAVE_PATH/DeepBench/gemm_bench_inference_halfx1760x7000x1760x0x0
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

LD_PRELOAD=$TRACING_TOOL_PATH ./gemm_bench train half 1760 7000 1760 0 0
trace_save_dir=$TRACES_SAVE_PATH/DeepBench/gemm_bench_train_halfx1760x7000x1760x0x0
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

LD_PRELOAD=$TRACING_TOOL_PATH ./rnn_bench inference half 1024 1 25 lstm
trace_save_dir=$TRACES_SAVE_PATH/DeepBench/rnn_bench_inference_halfx1024x1x25xlstm
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

LD_PRELOAD=$TRACING_TOOL_PATH ./rnn_bench train half 1024 1 25 lstm
trace_save_dir=$TRACES_SAVE_PATH/DeepBench/rnn_bench_train_halfx1024x1x25xlstm
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

##################################################################################
###                                                                            ###
###                                   Tango                                    ###
###                                                                            ###
##################################################################################

cd $apps_root/Tango/GPU/AlexNet
LD_PRELOAD=$TRACING_TOOL_PATH ./AN 32
trace_save_dir=$TRACES_SAVE_PATH/Tango/AlexNet
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Tango/GPU/GRU
LD_PRELOAD=$TRACING_TOOL_PATH ./GRU
trace_save_dir=$TRACES_SAVE_PATH/Tango/GRU
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Tango/GPU/LSTM
LD_PRELOAD=$TRACING_TOOL_PATH ./LSTM 32
trace_save_dir=$TRACES_SAVE_PATH/Tango/LSTM
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

cd $apps_root/Tango/GPU/SqueezeNet
LD_PRELOAD=$TRACING_TOOL_PATH ./SN 32
trace_save_dir=$TRACES_SAVE_PATH/Tango/SqueezeNet
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir

##################################################################################
###                                                                            ###
###                                   Lulesh                                   ###
###                                                                            ###
##################################################################################

cd $apps_root/LULESH/cuda/src
LD_PRELOAD=$TRACING_TOOL_PATH ./lulesh -s 45
trace_save_dir=$TRACES_SAVE_PATH/LULESH/cuda
mkdir $trace_save_dir
mv -f memory_traces/ sass_traces/ configs/ $trace_save_dir


##################################################################################
###                                                                            ###
###                                   Pennant                                  ###
###                                                                            ###
##################################################################################

cd $apps_root/PENNANT
LD_PRELOAD=$TRACING_TOOL_PATH ./build/pennant test/sedovbig/sedovbig.pnt
trace_save_dir=$TRACES_SAVE_PATH/PENNANT
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
CONFIG2="--config_file ./DEV-Def/A100PCIE40G.config"

##################################################################################
###                                                                            ###
###                            cublas_GemmEx_HF_CC                             ###
###                                                                            ###
##################################################################################

mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/cublas_GemmEx_HF_CC/2048x2048x2048/configs --kernel_id 0 $CONFIG2
python3 ./merge_report.py --dir $TRACES_SAVE_PATH/cublas_GemmEx_HF_CC/2048x2048x2048/outputs --kernel_id 0 --np 20

##################################################################################
###                                                                            ###
###                                 DeepBench                                  ###
###                                                                            ###
##################################################################################

for kernel_id in {0..10}
do
	mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/DeepBench/conv_bench_inference_halfx700x161x1x1x32x20x5x0x0x2x2/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/DeepBench/conv_bench_inference_halfx700x161x1x1x32x20x5x0x0x2x2/outputs --kernel_id $kernel_id --np 20
done
for kernel_id in {0..7}
do
	mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/DeepBench/gemm_bench_inference_halfx1760x7000x1760x0x0/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/DeepBench/gemm_bench_inference_halfx1760x7000x1760x0x0/outputs --kernel_id $kernel_id --np 20
done
for kernel_id in {0..7}
do
	mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/DeepBench/gemm_bench_train_halfx1760x7000x1760x0x0/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/DeepBench/gemm_bench_train_halfx1760x7000x1760x0x0/outputs --kernel_id $kernel_id --np 20
done
for kernel_id in {0..99}
do
	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/DeepBench/rnn_bench_inference_halfx1024x1x25xlstm/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/DeepBench/rnn_bench_inference_halfx1024x1x25xlstm/outputs --kernel_id $kernel_id --np 10
done
for kernel_id in {0..99}
do
	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/DeepBench/rnn_bench_train_halfx1024x1x25xlstm/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/DeepBench/rnn_bench_train_halfx1024x1x25xlstm/outputs --kernel_id $kernel_id --np 10
done

##################################################################################
###                                                                            ###
###                                   Lulesh                                   ###
###                                                                            ###
##################################################################################

for kernel_id in {0..80}
do
	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/LULESH/cuda/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/LULESH/cuda/outputs --kernel_id $kernel_id --np 10
done

##################################################################################
###                                                                            ###
###                                   Pennant                                  ###
###                                                                            ###
##################################################################################

for kernel_id in {0..13}
do
	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/PENNANT/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/PENNANT/outputs --kernel_id $kernel_id --np 10
done

##################################################################################
###                                                                            ###
###                                 PolyBench                                  ###
###                                                                            ###
##################################################################################

mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/PolyBench/2DCONV/configs --kernel_id 0 $CONFIG2
python3 ./merge_report.py --dir $TRACES_SAVE_PATH/PolyBench/2DCONV/outputs --kernel_id 0 --np 20
for kernel_id in {0..99}
do
	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/PolyBench/3DCONV/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/PolyBench/3DCONV/outputs --kernel_id $kernel_id --np 10
done
for kernel_id in {0..2}
do
	mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/PolyBench/3MM/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/PolyBench/3MM/outputs --kernel_id $kernel_id --np 20
done
for kernel_id in {0..1}
do
	mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/PolyBench/ATAX/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/PolyBench/ATAX/outputs --kernel_id $kernel_id --np 20
done
for kernel_id in {0..1}
do
	mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/PolyBench/BICG/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/PolyBench/BICG/outputs --kernel_id $kernel_id --np 20
done
mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/PolyBench/GEMM/configs --kernel_id 0 $CONFIG2
python3 ./merge_report.py --dir $TRACES_SAVE_PATH/PolyBench/GEMM/outputs --kernel_id 0 --np 20
mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/PolyBench/GESUMMV/configs --kernel_id 0 $CONFIG2
python3 ./merge_report.py --dir $TRACES_SAVE_PATH/PolyBench/GESUMMV/outputs --kernel_id 0 --np 20
for kernel_id in {0..2}
do
	mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/PolyBench/GRAMSCHM/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/PolyBench/GRAMSCHM/outputs --kernel_id $kernel_id --np 20
done
for kernel_id in {0..1}
do
	mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/PolyBench/MVT/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/PolyBench/MVT/outputs --kernel_id $kernel_id --np 20
done

##################################################################################
###                                                                            ###
###                                  Rodinia                                   ###
###                                                                            ###
##################################################################################

for kernel_id in {0..1}
do
	mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/b+tree/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/b+tree/outputs --kernel_id $kernel_id --np 20
done
for kernel_id in {0..1}
do
	mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/backprop/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/backprop/outputs --kernel_id $kernel_id --np 20
done
for kernel_id in {0..23}
do
	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/bfs/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/bfs/outputs --kernel_id $kernel_id --np 10
done
for kernel_id in {0..9}
do
	mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/cfd/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/cfd/outputs --kernel_id $kernel_id --np 20
done
for kernel_id in {0..9}
do
	mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/dwt2d/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/dwt2d/outputs --kernel_id $kernel_id --np 20
done
for kernel_id in {0..99}
do
	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/gaussian/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/gaussian/outputs --kernel_id $kernel_id --np 10
done
mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/hotspot/configs --kernel_id 0 $CONFIG2
python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/hotspot/outputs --kernel_id 0 --np 20
for kernel_id in {0..99}
do
	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/hotspot3D/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/hotspot3D/outputs --kernel_id $kernel_id --np 10
done
for kernel_id in {0..45}
do
	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/huffman/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/huffman/outputs --kernel_id $kernel_id --np 10
done
mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/lavaMD/configs --kernel_id 0 $CONFIG2
python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/lavaMD/outputs --kernel_id 0 --np 20
# for kernel_id in {0..99}
# do
# 	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/lud/configs --kernel_id $kernel_id $CONFIG2
# 	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/lud/outputs --kernel_id $kernel_id --np 10
# done
mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/nn/configs --kernel_id 0 $CONFIG2
python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/nn/outputs --kernel_id 0 --np 20
for kernel_id in {0..99}
do
	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/nw/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/nw/outputs --kernel_id $kernel_id --np 10
done
for kernel_id in {0..4}
do
	mpirun -np 20 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Rodinia/pathfinder/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Rodinia/pathfinder/outputs --kernel_id $kernel_id --np 20
done

##################################################################################
###                                                                            ###
###                                   Tango                                    ###
###                                                                            ###
##################################################################################

for kernel_id in {0..21}
do
	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Tango/AlexNet/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Tango/AlexNet/outputs --kernel_id $kernel_id --np 10
done
for kernel_id in {0..1}
do
	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Tango/GRU/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Tango/GRU/outputs --kernel_id $kernel_id --np 10
done
mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Tango/LSTM/configs --kernel_id 0 $CONFIG2
python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Tango/LSTM/outputs --kernel_id 0 --np 10
# for kernel_id in {0..99}
# do
# 	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Tango/ResNet/configs --kernel_id $kernel_id $CONFIG2
# 	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Tango/ResNet/outputs --kernel_id $kernel_id --np 10
# done
for kernel_id in {0..29}
do
	mpirun -np 10 $CONFIG1 $TRACES_SAVE_RELATIVE_PATH/Tango/SqueezeNet/configs --kernel_id $kernel_id $CONFIG2
	python3 ./merge_report.py --dir $TRACES_SAVE_PATH/Tango/SqueezeNet/outputs --kernel_id $kernel_id --np 10
done

exit_script
