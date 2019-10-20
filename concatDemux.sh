# with a bash for loop
for f in ./*.mp4; do echo "file '$f'" >> mp4ToConcat.txt; done
#ffmpeg -f concat -i inputs.txt -c copy output.mp4