#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input.txt output.txt"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file not found: $INPUT_FILE"
    exit 1
fi

# Pipeline:
# 1. tr -cd '\11\12\15\40-\176' : Keep only printable ASCII + tab + newline + CR (Basic filtering)
# 2. sed 's/\r$//' : Remove Windows Carriage Returns (Dos2Unix)
# 3. sed 's/^[ \t]*//;s/[ \t]*$//' : Trim leading/trailing whitespace
cat "$INPUT_FILE" | \
tr -cd '\11\12\15\40-\176' | \
sed 's/\r$//' | \
sed 's/^[ \t]*//;s/[ \t]*$//' > "$OUTPUT_FILE"

echo "Cleaned text saved to $OUTPUT_FILE"
