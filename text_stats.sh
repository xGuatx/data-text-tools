#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 document.txt"
    exit 1
fi

INPUT_FILE="$1"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File not found: $INPUT_FILE"
    exit 1
fi

echo "Statistics for $INPUT_FILE:"
echo "---------------------------"

# Line count
LINE_COUNT=$(wc -l < "$INPUT_FILE")
echo "Line count: $LINE_COUNT"

# Word count
WORD_COUNT=$(wc -w < "$INPUT_FILE")
echo "Word count: $WORD_COUNT"

# Character count
CHAR_COUNT=$(wc -m < "$INPUT_FILE")
echo "Character count: $CHAR_COUNT"

# Unique words (case insensitive basic approach)
UNIQUE_WORDS=$(tr '[:upper:]' '[:lower:]' < "$INPUT_FILE" | tr -s '[:space:]' '\n' | sort | uniq | wc -l)
echo "Unique words: $UNIQUE_WORDS"

# Most common words (top 5)
echo "Most common words:"
tr '[:upper:]' '[:lower:]' < "$INPUT_FILE" | tr -s '[:space:]' '\n' | grep -v "^$" | sort | uniq -c | sort -nr | head -n 5
