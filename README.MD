#demo for hls & rmtp

```
docker run -d -p 1935:1935 -p 80:80 lyra/vod-live
```

## live:
```
rtmp://server/live/video
http://server/hls/video

rtmp://server/live/dis-conn
http://server/hls/dis-conn
```

## vod
rtmp://server/vod/video
http://server/vod/video.m3u8