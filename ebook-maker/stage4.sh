#!/bin/bash
BOOK_NAME=$1
OCR_PROCESSED_DIR="${BOOK_NAME}/ocr-processed"
FINAL_PDF="${BOOK_NAME}-final.pdf"

# Store all the individual PDF files in an array
pdf_files=($(find ${OCR_PROCESSED_DIR} -type f -name "*.pdf" | sort -V))

# Combine all the individual PDFs into a single PDF
# This requires a tool like pdftk or qpdf
# pdftk "${pdf_files[@]}" cat output "$FINAL_PDF"
# OR
qpdf --empty --pages "${pdf_files[@]}" -- "$FINAL_PDF"

echo "Created final PDF with OCR text: $FINAL_PDF"

