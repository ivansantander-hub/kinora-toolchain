#!/bin/bash
# Builds whisper.cpp's `whisper-cli` as one self-contained macOS binary, reproducibly, at a pinned
# tag. whisper.cpp publishes no prebuilt macOS CLI, so Kinora's managed toolchain needs one built
# here. Static libraries (no Homebrew dylibs at run time); Metal and Accelerate on arm64.
#
# usage: tools/toolchain/build-whisper-cli.sh [arm64|x86_64] [output-dir]
# The outputs are for local testing: they are NOT published anywhere (see the toolchain notes).
set -euo pipefail

ARCH="${1:-$(uname -m)}"
OUT="${2:-$PWD/build/whisper-cli-$ARCH}"
TAG="v1.9.5"
REPOSITORY="https://github.com/ggml-org/whisper.cpp.git"

case "$ARCH" in
  arm64) METAL=ON ;;
  x86_64) METAL=OFF ;;
  *) echo "unknown architecture: $ARCH" >&2; exit 2 ;;
esac

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

git clone --quiet --depth 1 --branch "$TAG" "$REPOSITORY" "$WORK/src"
git -C "$WORK/src" rev-parse HEAD > "$WORK/commit"

cmake -S "$WORK/src" -B "$WORK/build" \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_OSX_ARCHITECTURES="$ARCH" \
  -DCMAKE_OSX_DEPLOYMENT_TARGET=12.0 \
  -DBUILD_SHARED_LIBS=OFF \
  -DGGML_METAL="$METAL" \
  -DGGML_METAL_EMBED_LIBRARY=ON \
  -DGGML_ACCELERATE=ON \
  -DGGML_NATIVE=OFF \
  -DWHISPER_BUILD_TESTS=OFF \
  -DWHISPER_BUILD_EXAMPLES=ON
cmake --build "$WORK/build" --config Release --target whisper-cli -j "$(sysctl -n hw.ncpu)"

mkdir -p "$OUT"
cp "$WORK/build/bin/whisper-cli" "$OUT/whisper-cli"
cp "$WORK/commit" "$OUT/COMMIT"
# Only system frameworks and libc++ may remain as dynamic dependencies.
if otool -L "$OUT/whisper-cli" | tail -n +2 | grep -v -E '/System/Library/|/usr/lib/'; then
  echo "unexpected dynamic dependency in whisper-cli" >&2
  exit 1
fi
shasum -a 256 "$OUT/whisper-cli"
echo "built whisper.cpp $TAG ($(cat "$OUT/COMMIT")) for $ARCH into $OUT"
