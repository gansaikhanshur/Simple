#!/bin/bash

# EXAMPLE USE CASE:
# 1. Set below 4 configurations
# 2. Run './audio_convert.sh/' or 'sh audio_convert.sh'

INPUT_DIR=./input_folder/		# path to folder containing audio files
OUTPUT_DIR=./output_folder/
NUM_AUDIO_CHANNELS=1			# mono (1), stereo (2), etc.
SAMPLING_FREQUENCY=8000			# 8000, 16000, etc.
OUTPUT_FORMAT=M4A				# supports -> WAV, MP3, M4A, FLAC, WMA, AAC, PCM, AIFF, OGG

if [ ! -d $OUTPUT_DIR ]; then
	mkdir -p $OUTPUT_DIR;
fi

g++ --std=c++17 scripts/init.cpp -o do-convert
./do-convert $INPUT_DIR $OUTPUT_DIR $NUM_AUDIO_CHANNELS $SAMPLING_FREQUENCY $OUTPUT_FORMAT 
rm do-convert
