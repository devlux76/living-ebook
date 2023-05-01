#!/bin/bash
BOOK_PDF=$1
BOOK_NAME=$(basename "$BOOK_PDF" .pdf)
OUTPUT_DIR="./${BOOK_NAME}"

# Check if the directory already exists and has files in it
if [ -d "$OUTPUT_DIR" ] && [ "$(ls -A $OUTPUT_DIR)" ]; then
    echo "Directory $OUTPUT_DIR already exists and is not empty, skipping extraction."
else
    mkdir -p "$OUTPUT_DIR"
    pdfimages -all "$BOOK_PDF" "$OUTPUT_DIR/page"
    if [ $? -eq 0 ]; then
        echo "Successfully extracted images from PDF."
    else
        echo "Failed to extract images from PDF."
        exit 1
    fi
fi

# List the files in the output directory
echo "Listing files in ${BOOK_NAME}:"

# Count the files and print the count
FILE_COUNT=$(find $OUTPUT_DIR -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.ppm" -o -name "*.pbm" \) | wc -l)
echo "Extracted $FILE_COUNT images to ${BOOK_NAME}"
