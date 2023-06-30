#!/bin/bash

root_path="$(dirname "$(realpath "$0")")/../.."

echo "prepare for packaging"

echo "create empty config"
mkdir -p "$root_path/configs/src/initts/"
if [ ! -f "$root_path/configs/src/initts/config.json" ]; then
    cat "$root_path/bin/templates/config.json" >"$root_path/configs/src/initts/config.json"
fi

echo "preparing logos"
mkdir -p "$root_path/extra/initts/logos"
if [ ! "$(ls -A "$root_path/extra/initts/logos")" ]; then
    touch "$root_path/extra/initts/logos/placeholder"
fi

echo "preparation finished"
