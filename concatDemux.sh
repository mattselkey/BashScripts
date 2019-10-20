#!/bin/bash

#Variables
INPUTFILE="mp4ToConcat.txt"
OUTPUTFILE="ConcatOutput.mp4"
FINALOUTPUT="FinalOutput.mp4"

#emtpy file
> $INPUTFILE;
for f in ./*.MP4; do echo "file '$f'" >> $INPUTFILE; done

if test -f $OUTPUTFILE; then
	echo "$OUTPUTFILE also exists"
fi
echo "Do you want to use this file[1], overwrite[2] or Exit[3]"
select yne in "Yes" "No" "Exit"; do
	case $yne in
	Yes ) echo "Using current file"; break;;
	No ) ffmpeg -f concat -safe 0  -i $INPUTFILE -c copy $OUTPUTFILE; break;;
	Exit ) exit;;
	esac
done

# ENCODE
# Get nvenc commands - ffmpeg -codecs | grep nvenc
# see https://superuser.com/questions/1296374/best-settings-for-ffmpeg-with-nvenc
# and https://superuser.com/questions/1236275/how-can-i-use-crf-encoding-with-nvenc-in-ffmpeg/1236387
# and https://ntown.at/de/knowledgebase/cuda-gpu-accelerated-h264-h265-hevc-video-encoding-with-ffmpeg/
# -aspect 16:9 -s 1920x1080 http://ffmpeg.org/ffmpeg-filters.html#scale
# audio "-c:a aac -b:a 128k -ac 2", disable audio -an 

ffmpeg -threads 6 -i $OUTPUTFILE -c:v h264_nvenc -preset slow -s 1920x1080 -b:v 9M -maxrate:v 12M -bufsize:v 15M -rc:v vbr_hq -cq 25 -an $FINALOUTPUT