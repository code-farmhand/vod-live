#!/bin/sh

ffmpeg_split_and_convert_file(){
    ffmpeg -i /opt/nginx/html/vod/video.mp4 -c copy -map 0 -f segment -segment_list /opt/nginx/html/vod/video.m3u8 -segment_time 5 /opt/nginx/html/vod/video%03d.ts 
    ffmpeg -i /opt/nginx/html/vod/video.mp4 -c copy  /opt/nginx/html/vod/video.flv
}



ffmpeg_push_loop(){
    sleep 10
    ffmpeg -stream_loop -1 -re -i /opt/nginx/html/vod/video.mp4  -c copy -f flv rtmp://127.0.0.1/push/video
}
ffmpeg_push_sleep_loop(){
    sleep 10
    while true
    do
    ffmpeg -re -i /opt/nginx/html/vod/video.mp4  -c copy -f flv rtmp://127.0.0.1/push/dis-conn
    sleep 120
    done
}
mkdir -p /tmp/hls
rm -rf /tmp/hls/*
ffmpeg_split_and_convert_file
ffmpeg_push_loop &
ffmpeg_push_sleep_loop &
/opt/nginx/sbin/nginx -g "daemon off;"