# slice

ffmpeg -i "/Users/hwkf-marlsen-47932/Downloads/2024-06-06 22.04.47.mp4" -c:v libx264 -c:a aac -f hls -hls_time 3 video/video.m3u8

# encryption

ffmpeg -i "/Users/hwkf-marlsen-47932/Documents/2024-06-06 22.04.47.mp4" -c:v libx264 -c:a aac -f hls -hls_time 3  -hls_key_info_file key.keyinfo -hls_list_size 0 /Users/hwkf-marlsen-47932/Documents/video/video.m3u8


xNeW11f9R8KP4qbCmI87LA