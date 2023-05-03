#!/bin/bash

TSC="$(pwd)/configs/dev/tsconfig.json"
LTSC="$(pwd)/tsconfig.json"
SCO="$(pwd)/configs/src/initts/"
LOG="$(pwd)/extra/initts/logos/"
ASC="$(pwd)/assets/initts/copy/root/"

cat "$TSC" >"$LTSC"
sed -i -E 's/\"\.\.\/\.\.\//"\.\//g' "$LTSC"

mkdir -p "$SCO"
mkdir -p "$LOG"
mkdir -p "$ASC"

echo "placeholder" >"$SCO"placeholder.txt
echo "placeholder" >"$LOG"placeholder.txt
echo "placeholder" >"$ASC"placeholder.txt
