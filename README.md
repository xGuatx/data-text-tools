# Data & Text Tools

Collection of shell scripts for text and data processing tasks.

## Description

Utility scripts for common text manipulation, data conversion, and file processing operations.

## Prerequisites

- Bash 4.0+
- Standard Unix tools (sed, awk, grep)
- Python 3 (for data conversion scripts)

## Installation

```bash
# Make scripts executable
chmod +x *.sh
```

## Scripts

### Text Processing

#### clean_text.sh
Remove unwanted characters and normalize text files.

```bash
./clean_text.sh input.txt output.txt
```

Features:
- Remove non-printable characters
- Normalize line endings
- Trim whitespace
- Remove BOM markers

#### text_stats.sh
Generate statistics from text files.

```bash
./text_stats.sh document.txt
```

Output:
- Line count
- Word count
- Character count
- Unique words
- Most common words

### Data Conversion

#### csv_to_json.sh
Convert CSV files to JSON format.

```bash
./csv_to_json.sh input.csv output.json
```

#### json_to_csv.sh
Convert JSON to CSV format.

```bash
./json_to_csv.sh input.json output.csv
```

#### xml_to_json.sh
Convert XML to JSON.

```bash
./xml_to_json.sh input.xml output.json
```

#### convertJson.py
Convert text file (one message per line) to JSONL format for OpenAI batch API.

```bash
# Requires recap.txt in current directory
python3 convertJson.py
```
Output: `recap.jsonl`

### File Operations

#### merge_files.sh
Concatenate multiple text files.

```bash
./merge_files.sh file1.txt file2.txt file3.txt > merged.txt
```

#### split_file.sh
Split large file into smaller chunks.

```bash
./split_file.sh large_file.txt 1000  # Split into 1000-line files
```

#### compareUser.sh
Compare two user lists and assist in finding unique users or differences.

```bash
# Requires user1.txt and user2.txt
./compareUser.sh
```
Output: Displays unique lines / differences to stdout.

## Common Use Cases

### Clean Dataset

```bash
# Remove duplicates and sort
cat data.txt | sort | uniq > cleaned_data.txt

# Remove empty lines
./clean_text.sh input.txt output.txt
```

### Extract Data

```bash
# Extract emails from text
grep -Eo '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}' file.txt

# Extract URLs
grep -Eo 'https?://[^[:space:]]+' file.txt
```

### Batch Processing

```bash
#!/bin/bash
# Process all text files in directory

for file in *.txt; do
    echo "Processing: $file"
    ./clean_text.sh "$file" "cleaned_$file"
done
```

## Configuration

### Environment Variables

```bash
# Set default encoding
export DEFAULT_ENCODING="UTF-8"

# Set temp directory
export TMPDIR="/tmp/text-tools"
```

## Advanced Features

### Custom Filters

Create custom text filters:
```bash
# filter_profanity.sh
#!/bin/bash
sed -i 's/badword/[FILTERED]/g' "$1"
```

### Encoding Conversion

```bash
# Convert encoding
iconv -f ISO-8859-1 -t UTF-8 input.txt > output.txt
```

## Troubleshooting

### Encoding Issues

```bash
# Detect file encoding
file -i filename.txt

# Fix encoding
iconv -f WINDOWS-1252 -t UTF-8 input.txt > output.txt
```

### Large Files

```bash
# Process large files in chunks
split -l 10000 large_file.txt chunk_

# Process each chunk
for chunk in chunk_*; do
    ./process.sh "$chunk"
done
```

## Performance Tips

- Use `awk` for complex text processing
- Use `sed` for simple replacements
- Use `grep` for pattern matching
- Process files in parallel with `xargs -P`

## Best Practices

- Always backup original files
- Test scripts on sample data first
- Use meaningful variable names
- Add error checking
- Handle edge cases

## Resources

- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)
- [GNU Coreutils Manual](https://www.gnu.org/software/coreutils/manual/)
- [sed Tutorial](https://www.gnu.org/software/sed/manual/sed.html)
- [awk Tutorial](https://www.gnu.org/software/gawk/manual/gawk.html)

## License

Personal project - Private use
