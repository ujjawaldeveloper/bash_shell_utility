#!/bin/bash

if [ $# -lt 2 ]; then
echo "Usage: $0 [-n] <old_pattern> <new_pattern> [directory]"
exit 1
fi

dry_run=false

if [ "$1" = "-n" ]; then
dry_run=true
shift
fi

old_pattern="$1"
new_pattern="$2"
directory="."
if [ ! -z "$3" ]; then
    directory="$3"
fi

# Verify that the directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

echo "Processing directory: $directory"
echo "Replacing '$old_pattern' with '$new_pattern'"
if [ "$dry_run" = true ]; then
    echo "Dry-run mode enabled. No files will be renamed."
fi

# Loop through each file in the specified directory
for filepath in "$directory"/*; do
    # Only process if it's a file
    if [ -f "$filepath" ]; then
        filename=$(basename "$filepath")
        # Check if the filename contains the old pattern
        if [[ "$filename" == *"$old_pattern"* ]]; then
            # Create new filename by replacing the old pattern with the new one
            new_filename="${filename//$old_pattern/$new_pattern}"
            new_filepath="$directory/$new_filename"
            if [ "$dry_run" = true ]; then
                echo "Would rename: '$filename' -> '$new_filename'"
            else
                echo "Renaming: '$filename' -> '$new_filename'"
                mv "$filepath" "$new_filepath"
            fi
        fi
    fi
done

echo "Done."
	
