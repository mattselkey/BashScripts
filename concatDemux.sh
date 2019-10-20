# with a bash for loop
for f in ./*.MP4; do echo "file '$f'" >> mp4ToConcat.txt; done
ffmpeg -f concat -safe 0  -i mp4ToConcat.txt -c copy output.mp4