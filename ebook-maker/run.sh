#!/bin/bash

# Stage 0: Check and repair PDF
echo "Stage 0: Check and repair PDF..."

# Input PDF file
INPUT_PDF=$1

# Output PDF file (repaired)
OUTPUT_PDF="repaired_$1"

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
./stage3.sh "$BOOK_NAME" && \
./stage4.sh "$BOOK_NAME" && \

echo "All Done!"
