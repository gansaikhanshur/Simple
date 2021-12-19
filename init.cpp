#include <string>
#include <iostream>
#include <filesystem>
#include <stdio.h>
#include <stdlib.h>
#include <map>

bool hasEnding (std::string const &fullString, std::string const &ending) {
    if (fullString.length() >= ending.length()) {
        return (0 == fullString.compare (fullString.length() - ending.length(), ending.length(), ending));
    } else {
        return false;
    }
}

std::string returnOutputFormat(std::string &s, std::string file_path){
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

    output = file_path.substr(0, file_path.find(".")) + output;
    return output;
}

int main(int argc, char* argv[])
{
    std::string path = argv[1];
    for (const auto & entry : std::filesystem::directory_iterator(path))
	{
		std::string num_audio_channels = argv[2];
		std::string sampling_freq = argv[3];
		std::string output_audio_format = argv[4];

		std::string input_file = entry.path();
		std::string dest_file = returnOutputFormat(output_audio_format, input_file);
		std::string shell_command = "./convert.sh";
		shell_command = shell_command + " " + input_file + " " + dest_file + " " + num_audio_channels +
			" " + sampling_freq;
		std::system(shell_command.c_str());


	}
}
