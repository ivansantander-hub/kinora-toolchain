# Source offer for the GPL ffmpeg builds

The `ffmpeg` and `ffprobe` binaries in the release `ffmpeg-vidstab-2026.10-1` are GPL software. The
corresponding source is provided as follows.

- FFmpeg: `ffmpeg-9.0.tar.xz` and `ffmpeg-8.0.tar.xz`, attached to the same release (upstream:
  https://ffmpeg.org/releases/).
- libvidstab (vid.stab 1.1.1, GPL-2.0-or-later): `vid.stab-1.1.1.tar.gz`, attached to the same
  release (upstream: https://github.com/georgmartius/vid.stab).
- The builder's build scripts, which fetch and compile every other library statically:
  `upstream/osxexperts-build-scripts.txt` (copied from https://www.osxexperts.net/ for this offer).
- Other libraries linked in (each under its own licence, upstream sources at the project sites):
  x264 (https://www.videolan.org/developers/x264.html), x265 (https://bitbucket.org/multicoreware/x265_git),
  libvpx (https://chromium.googlesource.com/webm/libvpx), libaom (https://aomedia.googlesource.com/aom),
  SVT-AV1 (https://gitlab.com/AOMediaCodec/SVT-AV1), libvmaf (https://github.com/Netflix/vmaf),
  libass (https://github.com/libass/libass), libopus (https://opus-codec.org), libvorbis and libtheora
  (https://xiph.org), LAME (https://lame.sourceforge.io), libwebp (https://chromium.googlesource.com/webm/libwebp),
  OpenJPEG (https://www.openjpeg.org), zimg (https://github.com/sekrit-twc/zimg), snappy
  (https://github.com/google/snappy), vvenc (https://github.com/fraunhoferhhi/vvenc), kvazaar
  (https://github.com/ultravideo/kvazaar), HarfBuzz, FreeType, FontConfig, FriBidi.

If you cannot find something you need, open an issue in this repository and it will be added.

## `configuration:` of each binary

arm64 (ffmpeg 9.0):

```
--prefix=/Volumes/tempdisk/sw --extra-cflags=-fno-stack-check --arch=arm64 --cc=/usr/bin/clang --enable-gpl --enable-libvmaf --enable-libopenjpeg --enable-libopus --enable-libmp3lame --enable-libx264 --enable-libx265 --enable-libvvenc --enable-libvpx --enable-libwebp --enable-libass --enable-libfreetype --enable-fontconfig --enable-libtheora --enable-libvorbis --enable-libsnappy --enable-libaom --enable-libvidstab --enable-libzimg --enable-libsvtav1 --enable-libharfbuzz --enable-libkvazaar --pkg-config-flags=--static --enable-ffplay --enable-neon --enable-runtime-cpudetect --disable-indev=qtkit --disable-indev=x11grab_xcb
```

x86_64 (ffmpeg 8.0):

```
--prefix=/Volumes/tempdisk/sw --extra-cflags=-fno-stack-check --arch=x86_64 --cc=/usr/bin/clang --enable-videotoolbox --enable-libfreetype --enable-fontconfig --enable-gpl --enable-libvmaf --enable-libopenjpeg --enable-libopus --enable-libtheora --enable-libvorbis --enable-libmp3lame --enable-libx264 --enable-libx265 --enable-libvvenc --enable-libvpx --enable-libwebp --enable-libass --enable-libaom --enable-libsnappy --enable-libvidstab --enable-libzimg --enable-libsvtav1 --enable-libharfbuzz --enable-ffplay --enable-version3 --pkg-config-flags=--static --enable-runtime-cpudetect --disable-filter=yadif_videotoolbox --disable-indev=qtkit --disable-indev=x11grab_xcb
```
