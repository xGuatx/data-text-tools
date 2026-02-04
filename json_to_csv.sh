#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input.json output.csv"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file not found: $INPUT_FILE"
    exit 1
fi

python3 -c "
import csv, json, sys
try:
    with open('$INPUT_FILE', 'r', encoding='utf-8') as f:
        data = json.load(f)
    if not isinstance(data, list):
        print('Error: JSON root must be a list of objects', file=sys.stderr)
        sys.exit(1)
    if not data:
        print('Warning: Empty JSON list', file=sys.stderr)
        open('$OUTPUT_FILE', 'w').close()
        sys.exit(0)
    
    keys = data[0].keys()
    with open('$OUTPUT_FILE', 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=keys)
        writer.writeheader()
        writer.writerows(data)
except Exception as e:
    print(f'Error: {e}', file=sys.stderr)
    sys.exit(1)
"
