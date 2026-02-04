#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 file1 file2 [file3 ...] > merged.txt"
    exit 1
fi

# Check if all files exist
for file in "$@"; do
    if [ ! -f "$file" ]; then
        echo "Error: File not found: $file" >&2
        exit 1
    fi
done

cat "$@"
