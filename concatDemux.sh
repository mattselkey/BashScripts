#!/bin/bash
INPUTFILE="mp4ToConcat.txt"
OUTPUTFILE="ConcatOutput.mp4"
FINALOUTPUT="FinalOutput.mp4"
#emtpy file
> mp4ToConcat.txt;
for f in ./*.MP4; do echo "file '$f'" >> $INPUTFILE; done
#ffmpeg -f concat -safe 0  -i $INPUTFILE -c copy $OUTPUTFILE
#see https://superuser.com/questions/1296374/best-settings-for-ffmpeg-with-nvenc
# and https://superuser.com/questions/1236275/how-can-i-use-crf-encoding-with-nvenc-in-ffmpeg/1236387
#-aspect 16:9 -s 1920x1080 http://ffmpeg.org/ffmpeg-filters.html#scale
#audio "-c:a aac -b:a 128k -ac 2"
# disable audio -an 
ffmpeg -threads 4 -i $OUTPUTFILE -c:v h264_nvenc -preset slow -s 1920x1080 -b:v 6M -maxrate:v 20M /
-bufsize:v 15M -rc:v vbr_hq -cq 29 -an $FINALOUTPUT