#!/bin/bash
BOOK_NAME=$1
OCR_PROCESSED_DIR="${BOOK_NAME}/ocr-processed"
mkdir -p "$OCR_PROCESSED_DIR"

# Store all the processed image files in an array
img_files=($(find ${BOOK_NAME} -type f -name "*-processed.jpg"))

# Get the total number of processed image files
total_files=${#img_files[@]}

# Initialize the current file number to 0
current_file=0

for img_file in "${img_files[@]}"; do
  # Increment the current file number
  current_file=$((current_file + 1))
  
  base_name=$(basename "$img_file" -processed.jpg)
  
  echo "Running OCR on processed $img_file... ($current_file/$total_files)"
  tesseract "$img_file" "$OCR_PROCESSED_DIR/$base_name"
done
