#!/bin/bash
BOOK_NAME=$1
OCR_ORIGINAL_DIR="${BOOK_NAME}/ocr-original"
mkdir -p "$OCR_ORIGINAL_DIR"

# Store all the image files in an array
img_files=($(find ${BOOK_NAME} -type f -name "*.jpg"))

# Get the total number of image files
total_files=${#img_files[@]}

# Initialize the current file number to 0
current_file=0

for img_file in "${img_files[@]}"; do
  # Increment the current file number
  current_file=$((current_file + 1))
  
  base_name=$(basename "$img_file" .jpg)
  
  echo "Running OCR on original $img_file... ($current_file/$total_files)"
  tesseract "$img_file" "$OCR_ORIGINAL_DIR/$base_name"
done
