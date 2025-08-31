# LightRoomUtils

### <tt>fix_codec.sh</tt>
Transcode H265 to H264, so that LightRoom can properly index .mp4 files.
- Problem: LightRoom does not know about H265; Pixel generates H265.
- Fix: transcode.
- Creates a copy of .mp4 for H264, but leaves H265 as is.
- Note the need for sufficient disk space.

This worked with: Lightroom Classic version: 14.5 [ 202508061311-4cef2162 ]

---

