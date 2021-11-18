#!/bin/bash

INPUT_FILE=$1
DEST_FILE=$2
NUM_AUDIO_CHANNELS=$3	# mono, stereo, etc.
SAMPLING_FREQUENCY=$4	# 8khz, 16khz,  etc.

if [[ $INPUT_FILE =~ \.(aac|aiff|pcm) ]] && [[ $DEST_FILE == *".wav" ]]; then
	ffmpeg -f s16le -ac $NUM_AUDIO_CHANNELS -ar $SAMPLING_FREQUENCY -i $INPUT_FILE $DEST_FILE
fi

if [[ $INPUT_FILE =~ \.(flac|m4a|mp3|ogg|wma) ]] && [[ $DEST_FILE == *".wav" ]]; then
	ffmpeg -i $INPUT_FILE -acodec pcm_s16le -ac $NUM_AUDIO_CHANNELS -ar $SAMPLING_FREQUENCY $DEST_FILE
fi

if [[ $INPUT_FILE == *".wav" ]] && [[ $DEST_FILE == *".wav" ]]; then
	tmp_file=$INPUT_FILE.tmp.wav
	ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $tmp_file
	rm $INPUT_FILE
	mv $tmp_file $INPUT_FILE
fi
