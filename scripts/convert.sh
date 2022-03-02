#!/bin/bash

INPUT_FILE=$1
DEST_FILE=$2
NUM_AUDIO_CHANNELS=$3	# mono, stereo, etc.
SAMPLING_FREQUENCY=$4	# 8khz, 16khz,  etc.

if [[ $DEST_FILE == *".wav" ]]; then
	if [[ $INPUT_FILE =~ \.(pcm) ]]; then
		tmp_file=$INPUT_FILE.tmp.wav
		ffmpeg -f s16le -ac $NUM_AUDIO_CHANNELS -ar 16000 -i $INPUT_FILE $tmp_file
		ffmpeg -i $tmp_file -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE
		rm $tmp_file
	fi
	if [[ $INPUT_FILE =~ \.(aac|aiff) ]]; then
		tmp_file=$INPUT_FILE.tmp.wav
		ffmpeg -i $INPUT_FILE $tmp_file
		ffmpeg -i $tmp_file -ac $NUM_AUDIO_CHANNELS -ar $SAMPLING_FREQUENCY $DEST_FILE
		rm $tmp_file
	fi

	if [[ $INPUT_FILE =~ \.(flac|m4a|mp3|ogg|wma) ]]; then
		ffmpeg -i $INPUT_FILE -acodec pcm_s16le -ac $NUM_AUDIO_CHANNELS -ar $SAMPLING_FREQUENCY $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".wav" ]]; then
		tmp_file=$INPUT_FILE.tmp.wav
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $tmp_file
		mv $tmp_file $DEST_FILE
		rm $tmp_file
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
		mv $tmp_file $DEST_FILE
		rm $tmp_file
	fi
fi

if [[ $DEST_FILE == *".flac" ]]; then

	if [[ $INPUT_FILE =~ \.(aac|aiff|m4a|wav|ogg|wma) ]]; then
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS -sample_fmt s16 -c:a flac $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".pcm" ]]; then
		tmp_file=$INPUT_FILE.tmp.flac
		ffmpeg -ar 16000 -ac $NUM_AUDIO_CHANNELS -f s16le -i $INPUT_FILE -c:a flac $tmp_file
		ffmpeg -i $tmp_file -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE
		rm $tmp_file
	fi

	if [[ $INPUT_FILE == *".flac" ]]; then
		tmp_file=$INPUT_FILE.tmp.flac
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $tmp_file
		mv $tmp_file $DEST_FILE
		rm $tmp_file
	fi
fi

if [[ $DEST_FILE == *".aac" ]]; then

	if [[ $INPUT_FILE =~ \.(aiff|m4a|mp3|wav|ogg|wma|flac) ]]; then
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS -c:a aac $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".pcm" ]]; then
		tmp_file=$INPUT_FILE.tmp.aac
		ffmpeg -ar 16000 -ac $NUM_AUDIO_CHANNELS -f s16le -i $INPUT_FILE $tmp_file
		ffmpeg -i $tmp_file -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE
		rm $tmp_file
	fi

	if [[ $INPUT_FILE == *".aac" ]]; then
		tmp_file=$INPUT_FILE.tmp.aac
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $tmp_file
		mv $tmp_file $DEST_FILE
		rm $tmp_file
	fi
fi

if [[ $DEST_FILE == *".wma" ]]; then

	if [[ $INPUT_FILE =~ \.(aac|mp3|aiff|m4a|wav|ogg|flac) ]]; then
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".wma" ]]; then
		echo 'WMA to WMA is unnecessary: omitting $INPUT_FILE'
	fi

	if [[ $INPUT_FILE == *".pcm" ]]; then
		tmp_file=$INPUT_FILE.tmp.wma
		ffmpeg -ar 16000 -ac $NUM_AUDIO_CHANNELS -f s16le -i $INPUT_FILE $tmp_file
		ffmpeg -i $tmp_file -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE
		rm $tmp_file
	fi


fi

if [[ $DEST_FILE == *".aiff" ]]; then

	if [[ $INPUT_FILE =~ \.(aac|mp3|wma|m4a|wav|ogg|flac) ]]; then
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".aiff" ]]; then
		echo 'AIFF to AIFF is unnecessary: omitting $INPUT_FILE'
	fi

	if [[ $INPUT_FILE == *".pcm" ]]; then
		tmp_file=$INPUT_FILE.tmp.aiff
		ffmpeg -ar 16000 -ac $NUM_AUDIO_CHANNELS -f s16le -i $INPUT_FILE $tmp_file
		ffmpeg -i $tmp_file -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE
		rm $tmp_file
	fi

fi

if [[ $DEST_FILE == *".pcm" ]]; then
	if [[ $INPUT_FILE =~ \.(aac|aiff|mp3|wma|m4a|wav|ogg|flac) ]]; then
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE
	fi
fi

if [[ $DEST_FILE == *".m4a" ]]; then
	if [[ $INPUT_FILE =~ \.(aac|aiff|mp3|wma|wav|ogg|flac) ]]; then
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".pcm" ]]; then
		ffmpeg -loglevel panic -f s16le -y -ar 16000 -ac $NUM_AUDIO_CHANNELS -i $INPUT_FILE -ar 16000 -ac $NUM_AUDIO_CHANNELS $DEST_FILE
	fi
fi

if [[ $DEST_FILE == *".ogg" ]]; then
	if [[ $INPUT_FILE =~ \.(aac|aiff|mp3|wma|wav|m4a|flac) ]]; then
		ffmpeg -i $INPUT_FILE -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".ogg" ]]; then
		cp $INPUT_FILE $DEST_FILE
	fi

	if [[ $INPUT_FILE == *".pcm" ]]; then
		tmp_file=$INPUT_FILE.tmp.ogg
		ffmpeg -ar 16000 -ac $NUM_AUDIO_CHANNELS -f s16le -i $INPUT_FILE $tmp_file
		ffmpeg -i $tmp_file -ar $SAMPLING_FREQUENCY -ac $NUM_AUDIO_CHANNELS $DEST_FILE
		rm $tmp_file
	fi

fi

