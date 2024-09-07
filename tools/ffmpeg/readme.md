# slice

ffmpeg -i "/Users/hwkf-marlsen-47932/Downloads/2024-06-06 22.04.47.mp4" -c:v libx264 -c:a aac -f hls -hls_time 3 video/video.m3u8

# encryption

ffmpeg -i "/Users/hwkf-marlsen-47932/Documents/2024-06-06 22.04.47.mp4" -c:v libx264 -c:a aac -f hls -hls_time 3  -hls_key_info_file key.keyinfo -hls_list_size 0 /Users/hwkf-marlsen-47932/Documents/video/video.m3u8



# compression 

ffmpeg -i sample_20.mp4 -c:v libx264 -c:a aac -crf 18 out.mp4


# add cover
ffmpeg -i example.mp4 -i example.png -map 0 -map 1 -c copy -disposition:v:1 attached_pic output.mp4

# remove cover
ffmpeg -i example.mp4 -i example.png -map 0 -map 1 -c copy -disposition:v:1 attached_pic output.mp4


# probe with json output
ffprobe -v quite -print_format json -show_format -show_streams output.mp4