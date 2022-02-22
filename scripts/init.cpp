#include <string>
#include <iostream>
#include <filesystem>
#include <stdio.h>
#include <stdlib.h>
#include <map>
#include <vector>
#include <sstream>

std::string getOutputFormat(std::string &s, std::string file_path, std::string output_path){
    std::string output = "";

    std::map<std::string, std::string> my_map = {
    { "WAV", ".wav" },
    { "FLAC", ".flac" },
    { "MP3", ".mp3" },
    { "WMA", ".wma" },
    { "AAC", ".aac" },
    { "M4A", ".m4a" },
    { "PCM", ".pcm" },
    { "AIFF", ".aiff" },
    { "OGG", ".ogg" }
    };

    output = my_map.find(s)->second;

	std::string base_filename = file_path.substr(file_path.find_last_of("/") + 1);
	std::string::size_type const p(base_filename.find_last_of('.'));
	std::string file_without_extension = base_filename.substr(0, p);

	output = output_path + file_without_extension + output;

    return output;
}

int main(int argc, char* argv[])
{
    std::string path = argv[1];
    for (const auto & entry : std::filesystem::directory_iterator(path))
	{
		std::string output_path = argv[2];
		std::string num_audio_channels = argv[3];
		std::string sampling_freq = argv[4];
		std::string output_audio_format = argv[5];

		std::string input_file = entry.path();
		std::string dest_file = getOutputFormat(output_audio_format, input_file, output_path);
		std::string shell_command = "./scripts/convert.sh";
		shell_command = shell_command + " " + input_file + " " + dest_file + " " + num_audio_channels +
			" " + sampling_freq;
		std::system(shell_command.c_str());


	}
}
