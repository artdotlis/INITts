#!/bin/bash

echo "post hook"
TSC="$(pwd)/configs/dev/tsconfig.json"
LTSC="$(pwd)/tsconfig.json"

cat "$TSC" >"$LTSC"
sed -i -E 's/\"\.\.\/\.\.\//"\.\//g' "$LTSC"

/bin/bash "$(pwd)/bin/deploy/fix.sh"
