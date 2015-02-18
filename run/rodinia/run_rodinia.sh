#!/bin/bash

if [ ! -n "$1" ]; then
    echo "usage: $0 BENCHNAME"
    exit 0
fi

BENCH=$1
RODINIA_DIR=~/workspace/gpgpu-bench/rodinia_2.4/cuda
RODINIA_DATA=~/workspace/gpgpu-bench/rodinia_2.4/data
RODINIA_BIN=~/workspace/gpgpu-bench/rodinia_2.4/bin/linux/cuda

BIN=""
DSET=""
IDATA=""
ODATA=""
PAR=""

case "$BENCH" in
	bpr)
	BIN="${RODINIA_BIN}/backprop"
	PAR="65536"
	;;
	bfs)
	BIN="${RODINIA_BIN}/bfs"
	IDATA="${RODINIA_DATA}/bfs/graph1MW_6.txt"
	;;
	gaf)
	BIN="${RODINIA_BIN}/gaussian"
	IDATA="-f ${RODINIA_DATA}/gaussian/matrix4.txt"
	;;
	gas)
	BIN="${RODINIA_BIN}/gaussian"
	PAR="-s 16"
	;;
	htw)
	BIN="${RODINIA_BIN}/heartwall"
	IDATA="${RODINIA_DATA}/heartwall/test.avi"
	PAR="5"
	;;
	hsp)
	BIN="${RODINIA_BIN}/hotspot"
	IDATA="512 2 2 ${RODINIA_DATA}/hotspot/temp_512"
	ODATA="${RODINIA_DATA}/hotspot/power_512 output.out"
	;;
	kmn)
	BIN="${RODINIA_BIN}/kmeans"
	IDATA="-o -i ${RODINIA_DATA}/kmeans/kdd_cup" 
	;;
	lud)
	BIN="${RODINIA_BIN}/lud_cuda"
	PAR="-s 256 -v"
	;;
	pff)
	BIN="${RODINIA_BIN}/particlefilter_float"
	PAR="-x 128 -y 128 -z 10 -np 1000"
	;;
	pth)
	BIN="${RODINIA_BIN}/pathfinder"
	PAR="100000 100 20"
	;;
	sr1)
	BIN="${RODINIA_BIN}/srad_v1"
	PAR="100 0.5 502 458"
	;;
	scg)
	BIN="${RODINIA_BIN}/sc_gpu"
	IDATA="10 20 256 65536 65536 1000 none"
	ODATA="output.txt"
	;;
	*)
	echo "Invalid benchmark name!!!"
	;;
esac

echo "${BIN} ${IDATA} ${ODATA} ${PAR}"
${BIN} ${IDATA} ${ODATA} ${PAR} >> gpugj.rpt