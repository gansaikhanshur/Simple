![logo](img/simple_logo.png)

[![Last Commit](https://img.shields.io/github/last-commit/gansaikhanshur/Simple)](https://img.shields.io/github/last-commit/gansaikhanshur/Simple)

`simple` is the easiest way to convert audio files into your desired format.

![GIF demo](https://gfycat.com/saltyorangehydra)

**Usage**
---

```
Usage: sh start_simple.sh

  Easily convert every audio files within a folder to a specified format.
  This is a wrapper for ffmpeg.


Required Inputs:
  - INPUT_DIR               Path to input directory
  - OUTPUT_DIR              Path to output directory
  - NUM_AUDIO_CHANNELS      1, 2, etc. (mono, stereo...)
  - SAMPLING_FREQUENCY      8000, 16000, etc.
  - OUTPUT_FORMAT           supports -> WAV, MP3, M4A, FLAC, WMA, AAC, PCM, AIFF, OGG
```

**How to Contribute**
---

1. Clone repo and create a new branch: `$ git checkout https://github.com/gansaikhanshur/Simple -b name_for_new_branch`.
2. Make changes and test
3. Submit Pull Request with comprehensive description of changes

**Acknowledgements**
---

+ [Canva](https://www.canva.com) for logo design.
+ This wrapper uses [FFMPEG](https://www.ffmpeg.org).
+ Thanks to [Stronghold](https://github.com/alichtman/stronghold#readme) for Readme inspiration.
