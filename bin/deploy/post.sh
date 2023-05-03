#!/bin/bash

TSC="$(pwd)/configs/dev/tsconfig.json"
LTSC="$(pwd)/tsconfig.json"
SCO="$(pwd)/configs/src/"
LOG="$(pwd)/extra/logos/"
ASC="$(pwd)/assets/copy/root/"

cat "$TSC" >"$LTSC"
sed -i.buf -E 's/\"\.\.\/\.\.\//"\.\//g' "$LTSC"

mkdir -p "$SCO"
mkdir -p "$LOG"
mkdir -p "$ASC"

echo "placeholder" >"$SCO"placeholder.txt
echo "placeholder" >"$LOG"placeholder.txt
echo "placeholder" >"$ASC"placeholder.txt
