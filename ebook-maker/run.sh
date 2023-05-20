#!/bin/bash

# Stage 0: Check and repair PDF
echo "Stage 0: Check and repair PDF..."

# Input PDF file
INPUT_PDF=$1

# OCR flag
OCR_FLAG=$2

# Extract only the filename from INPUT_PDF
INPUT_PDF_FILENAME=$(basename "$INPUT_PDF")

# Extract the directory from INPUT_PDF
INPUT_PDF_DIR=$(dirname "$INPUT_PDF")

# Output PDF file (repaired)
OUTPUT_PDF="$INPUT_PDF_DIR/repaired_$INPUT_PDF_FILENAME"

# Run QPDF to check and repair the PDF
qpdf --warning-exit-0 --verbose --linearize "$INPUT_PDF" "$OUTPUT_PDF"

# Check if the repair was successful
if [ $? -ne 0 ]; then
    echo "QPDF failed to repair the PDF. Exiting..."
    exit 1
fi
 
# If the repair was successful, move on to the next stages
echo "QPDF successfully repaired the PDF. Moving on to the next stages..."

rm $INPUT_PDF
mv $OUTPUT_PDF $INPUT_PDF
BOOK_NAME=$(basename "$INPUT_PDF" .pdf)

# Run the other stages
./stage1.sh "$INPUT_PDF" && \
./stage2.sh "$BOOK_NAME" && \
if [ "$OCR_FLAG" == "--ocr" ]; then
    ./stage3.sh "$BOOK_NAME"  # This is the OCR operation
fi
./stage4.sh "$BOOK_NAME"  # This is the PDF creation

echo "All Done!"

