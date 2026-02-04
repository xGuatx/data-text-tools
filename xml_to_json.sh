#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input.xml output.json"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file not found: $INPUT_FILE"
    exit 1
fi

# Try to use python's xml.etree.ElementTree (built-in) to avoid external deps like xmltodict
# Note: This is a simple converter and might not handle complex XML schemas perfectly.
python3 -c "
import json, sys
import xml.etree.ElementTree as ET

def elem_to_dict(elem):
    d = {}
    if elem.attrib:
        d['@attributes'] = elem.attrib
    if elem.text and elem.text.strip():
        d['#text'] = elem.text.strip()
    
    children = list(elem)
    if children:
        for child in children:
            child_dict = elem_to_dict(child)
            if child.tag in d:
                if not isinstance(d[child.tag], list):
                    d[child.tag] = [d[child.tag]]
                d[child.tag].append(child_dict)
            else:
                d[child.tag] = child_dict
    return d

try:
    tree = ET.parse('$INPUT_FILE')
    root = tree.getroot()
    data = {root.tag: elem_to_dict(root)}
    
    with open('$OUTPUT_FILE', 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2)
except Exception as e:
    print(f'Error: {e}', file=sys.stderr)
    sys.exit(1)
"
