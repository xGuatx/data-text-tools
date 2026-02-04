#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 large_file.txt lines_per_file"
    exit 1
fi

INPUT_FILE="$1"
LINES="$2"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File not found: $INPUT_FILE"
    exit 1
fi

# Validate integer
if ! [[ "$LINES" =~ ^[0-9]+$ ]]; then
    echo "Error: lines_per_file must be a number"
    exit 1
fi

FILENAME=$(basename -- "$INPUT_FILE")
EXTENSION="${FILENAME##*.}"
BASENAME="${FILENAME%.*}"

split -l "$LINES" -d --additional-suffix=".$EXTENSION" "$INPUT_FILE" "${BASENAME}_part_"
