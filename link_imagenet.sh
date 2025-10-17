#!/usr/bin/env bash
set -euo pipefail

# Set your source paths (edit if different)
SRC_TRAIN=/raid/datasets/imagenet/train
SRC_VAL=/raid/datasets/imagenet/val

# Cache roots used by your code
CACHEDIR="${XDG_CACHE_HOME:-$HOME/.cache}"
ROOT_TR="$CACHEDIR/autoencoders/data/ILSVRC2012_train"
ROOT_VA="$CACHEDIR/autoencoders/data/ILSVRC2012_validation"

# 1) Make cache dirs
mkdir -p "$ROOT_TR" "$ROOT_VA"

# 2) Symlink data/ -> your existing folders (force-replace if present)
ln -sfn "$SRC_TRAIN" "$ROOT_TR/data"
ln -sfn "$SRC_VAL"   "$ROOT_VA/data"

TR="$HOME/.cache/autoencoders/data/ILSVRC2012_train"
( cd "$TR/data" && \
  find -L . -type f \( -iname '*.jpeg' -o -iname '*.jpg' \) \
  | sed 's#^\./##' | sort > "$TR/filelist.txt" )
touch "$TR/.ready"

VA="$HOME/.cache/autoencoders/data/ILSVRC2012_validation"
( cd "$VA/data" && \
  find -L . -type f \( -iname '*.jpeg' -o -iname '*.jpg' \) \
  | sed 's#^\./##' | sort > "$VA/filelist.txt" )
touch "$VA/.ready"