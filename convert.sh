#!/bin/bash

INPUT_FILE=$1
DEST_FILE=$2
NUM_AUDIO_CHANNELS=$3	# mono, stereo, etc.
SAMPLING_FREQUENCY=$4	# 8khz, 16khz,  etc.

if [[ $INPUT_FILE == *".mp3" ]] || [[ $INPUT_FILE == *".m4a" ]]; then
	ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE 
fi

if [[ $INPUT_FILE == *".ac3" ]]; then
	ffmpeg -i $INPUT_FILE -vcodec copy -acodec pcm_s16le -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE
fi

if [[ $INPUT_FILE == *".wav" ]] && [[ $DEST_FILE == *".wav" ]]; then
	tmp_file=$INPUT_FILE.tmp.wav
	ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $tmp_file
	rm $INPUT_FILE
	mv $tmp_file $INPUT_FILE
fi
