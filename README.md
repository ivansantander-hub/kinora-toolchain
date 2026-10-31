# kinora-toolchain

Pinned, checksummed native tools that the [Kinora](https://github.com/ivansantander-hub/kinora) desktop
app downloads into its own data folder on first run, so it never depends on what a Mac has installed.
This repository holds only the binaries (as release assets), their licences, their source offer and
the scripts used to build or fetch them. It holds no secrets and none of Kinora's own code.

Every asset is a zip with one program inside. Kinora checks the size and the sha256 below before it
unpacks anything; a file that does not match is deleted.

## Releases

### `ffmpeg-vidstab-2026.10-1` : ffmpeg and ffprobe with libvidstab (GPL)

Static macOS builds made by [osxexperts.net](https://www.osxexperts.net/) (ffmpeg 9.0 for Apple
Silicon, ffmpeg 8.0 for Intel), mirrored here byte for byte so a pin never breaks when the upstream
file name is re-published. Both have `libvidstab` (`vidstabdetect`, `vidstabtransform`), libx264,
libx265, libvpx, libaom, SVT-AV1, libass, libopus, libvorbis and more. The `configuration:` line of
each binary is in [`SOURCE-OFFER.md`](SOURCE-OFFER.md).

| Asset | Upstream | Version | sha256 |
| --- | --- | --- | --- |
| `ffmpeg-9.0-vidstab-arm64.zip` | https://www.osxexperts.net/ffmpeg9arm.zip | ffmpeg 9.0 | `d0c06c5c68ce48af3143b262f7a9118a7c9f67de1e237fcc24ffb14df9c67af9` |
| `ffprobe-9.0-vidstab-arm64.zip` | https://www.osxexperts.net/ffprobe9arm.zip | ffmpeg 9.0 | `0c94fbdd8917022f28115eca512196cf4648732bc9e5db9ec8896c7e519d02aa` |
| `ffmpeg-8.0-vidstab-x64.zip` | https://www.osxexperts.net/ffmpeg80intel.zip | ffmpeg 8.0 | `2d24d22db78c87f394a5822867acd5c5dc5e762cd261a44bd26923f3a5af3e07` |
| `ffprobe-8.0-vidstab-x64.zip` | https://www.osxexperts.net/ffprobe80intel.zip | ffmpeg 8.0 | `0b6576104a95c1b39d4939e2df86f8f7cf1d55287ff57da48777d94605d12feb` |

Source offer (GPL): the same release carries the matching upstream sources, `ffmpeg-9.0.tar.xz`
(`7f607a00dd0d28a729d5a4811205812eef01cf6ef6155025febb6f36a9062d52`), `ffmpeg-8.0.tar.xz`
(`884961fb13c6bb44a611af22e77f117e387397b2fc0b62abba306b24ea8a6045`) and `vid.stab-1.1.1.tar.gz`
(`9001b6df73933555e56deac19a0f225aae152abbc0e97dc70034814a1943f3d4`), the builder's published build
scripts in [`upstream/osxexperts-build-scripts.txt`](upstream/osxexperts-build-scripts.txt), and the
list of every other library with its upstream in [`SOURCE-OFFER.md`](SOURCE-OFFER.md). Licences:
[`LICENSES/GPL-2.0.txt`](LICENSES/GPL-2.0.txt) (ffmpeg built with `--enable-gpl`),
[`LICENSES/GPL-3.0.txt`](LICENSES/GPL-3.0.txt) (the x86_64 build also has `--enable-version3`).

### `whisper-cpp-v1.9.5-1` : whisper.cpp `whisper-cli` (MIT)

Built from [ggml-org/whisper.cpp](https://github.com/ggml-org/whisper.cpp) tag `v1.9.5`
(commit `d1be6fde11ac6e0407606b4e42fe72d34add8037`) with
[`scripts/build-whisper-cli.sh`](scripts/build-whisper-cli.sh): static libraries, Metal and
Accelerate on Apple Silicon, no Homebrew libraries (`otool -L` lists only system frameworks and
libc++). Licence: [`LICENSES/MIT-whisper.cpp.txt`](LICENSES/MIT-whisper.cpp.txt).

| Asset | Contents | sha256 |
| --- | --- | --- |
| `whisper-cli-v1.9.5-arm64.zip` | `whisper-cli` (Apple Silicon, Metal) | `5848574a82a1719f75d7b29f26f48b9f2deaee04536e1da8500a3c750f4bcecd` |
| `whisper-cli-v1.9.5-x64.zip` | `whisper-cli` (Intel) | `af473f85f251271cb01b3f4e5321414c996d47de2dcbd0cb12b3656b3eda99a5` |

## Adding a component

One release per component version, named `<component>-<version>-<revision>`. Attach the zips and a
`SHA256SUMS` file, add its table above, its licence under `LICENSES/` and, when it is copyleft, its
source. Never attach anything that holds a secret.
