#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input.csv output.json"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file not found: $INPUT_FILE"
    exit 1
fi

# Use python for robust CSV to JSON conversion
python3 -c "
import csv, json, sys
data = []
try:
    with open('$INPUT_FILE', 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            data.append(row)
    with open('$OUTPUT_FILE', 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
except Exception as e:
    print(f'Error: {e}', file=sys.stderr)
    sys.exit(1)
"
