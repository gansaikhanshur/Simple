#!/bin/bash

INPUT_FILE=$1
DEST_FILE=$2
NUM_AUDIO_CHANNELS=$3	# mono, stereo, etc.
SAMPLING_FREQUENCY=$4	# 8khz, 16khz,  etc.

if [[ $DEST_FILE == *".wav" ]]; then
	if [[ $INPUT_FILE =~ \.(aac|aiff|pcm) ]]; then
		ffmpeg -f s16le -ac $NUM_AUDIO_CHANNELS -ar $SAMPLING_FREQUENCY -i $INPUT_FILE $DEST_FILE
	fi

	if [[ $INPUT_FILE =~ \.(flac|m4a|mp3|ogg|wma) ]]; then
		ffmpeg -i $INPUT_FILE -acodec pcm_s16le -ac $NUM_AUDIO_CHANNELS -ar $SAMPLING_FREQUENCY $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".wav" ]]; then
		tmp_file=$INPUT_FILE.tmp.wav
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $tmp_file
		rm $INPUT_FILE
		mv $tmp_file $INPUT_FILE
	fi
fi

if [[ $DEST_FILE == *".mp3" ]]; then

	if [[ $INPUT_FILE =~ \.(aac|aiff|flac|m4a|wav|ogg|wma) ]]; then
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS -acodec libmp3lame $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".pcm" ]]; then
		# This will need improvements in the future
		# When it directly gets converted to, for example, 8khz the playback speed slows down
		# The workaround here is to convert it to 16khz and then MP3 to MP3

		tmp_file=$INPUT_FILE.tmp.mp3
		ffmpeg -ar 16000 -ac $NUM_AUDIO_CHANNELS -f s16le -i $INPUT_FILE -c:a libmp3lame $tmp_file
		ffmpeg -i $tmp_file -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE
		rm $tmp_file
	fi

	if [[ $INPUT_FILE == *".mp3" ]]; then
		tmp_file=$INPUT_FILE.tmp.mp3
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $tmp_file
		rm $INPUT_FILE
		mv $tmp_file $INPUT_FILE
	fi
fi

if [[ $DEST_FILE == *".flac" ]]; then

	if [[ $INPUT_FILE =~ \.(aac|aiff|m4a|wav|ogg|wma) ]]; then
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS -sample_fmt s16 -c:a flac $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".pcm" ]]; then
		# This will need improvements in the future
		# When it directly gets converted to, for example, 8khz the playback speed slows down
		# Temporarily keeping this at 16000
		echo '$INPUT_FILE -> 16khz'
		ffmpeg -ar 16000 -ac $NUM_AUDIO_CHANNELS -f s16le -i $INPUT_FILE -c:a flac $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".flac" ]]; then
		tmp_file=$INPUT_FILE.tmp.flac
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $tmp_file
		rm $INPUT_FILE
		mv $tmp_file $INPUT_FILE
	fi
fi

if [[ $DEST_FILE == *".aac" ]]; then

	if [[ $INPUT_FILE =~ \.(aiff|m4a|wav|ogg|wma|flac) ]]; then
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS -c:a aac $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".pcm" ]]; then
		# This will need improvements in the future
		# When it directly gets converted to, for example, 8khz the playback speed slows down
		# Temporarily keeping this at 16000
		echo '$INPUT_FILE -> 16khz'
		ffmpeg -ar 16000 -ac $NUM_AUDIO_CHANNELS -f s16le -i $INPUT_FILE -c:a aac $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".aac" ]]; then
		tmp_file=$INPUT_FILE.tmp.aac
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $tmp_file
		rm $INPUT_FILE
		mv $tmp_file $INPUT_FILE
	fi
fi
