#!/bin/bash
# [20250829] (air)
# transcode H265 to H264, so that LightRoom can properly index .mp4 files
# LightRoom does not know about H265; Pixel generates H265.
# creates a copy of .mp4 for H264, but leaves H265 as is.
# note the need for sufficient disk space; H264 files are larger.
#

# Yuo may need to install these
MI="/usr/bin/mediainfo"
HB="/usr/bin/HandBrakeCLI"
shopt -s globstar

# process the .mp4 files in a tree (e.g. JUNK/)
for file in `ls -1  -d JUNK/**/*.mp4`  ; do
    
    codec=`$MI --Inform="Video;%InternetMediaType%" $file`  # get encoder ID
    if [ $codec = "video/H265" ] ; then
	filnam="${file%.*}"
	ext="${file##*.}"
	echo "transcode " $filnam " + " $ext

        # transcode
#       h264fil="${filnam}.h264.${ext}"
#	$HB -i $file -o $h264fil -e x264

        # for faster encoding, (try to) use gpu
	# seems to port less metadata, use x264 if you need it
	h264fil="${filnam}.nvenc.${ext}"
	$HB --verbose=0 \
	    -i $file -o $h264fil \
	    -e nvenc_h264
    fi
done

#


