#!/bin/bash
# [20250829] (air)
# transcode H265 to H264, so that LightRoom can properly index .mp4 files
# LightRoom does not know about H265; Pixel generates H265.
# creates a copy of .mp4 for H264, but leaves H265 as is.
# note the need for sufficient disk space.
#


MI="/usr/bin/mediainfo"
HB="/usr/bin/HandBrakeCLI"
shopt -s globstar

# process ll .mp4 file in a tree
for file in `ls -1  -d JUNK/**/*.mp4`  ; do
    
    codec=`$MI --Inform="Video;%InternetMediaType%" $file`  # get encoder ID
    if [ $codec = "video/H265" ] ; then
	filnam="${file%.*}"
	ext="${file##*.}"
	echo $filnam " + " $ext

# for smaller files
#       h264fil="${filnam}.h264.${ext}"
#	$HB -i $file -o $h264fil -e x264

# for faster encoding (using gpu)
	h264fil="${filnam}.nvenc.${ext}"
	$HB --verbose=0 \
	    -i $file -o $h264fil \
	    -e nvenc_h264
    fi
done


#

