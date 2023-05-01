#!/bin/bash
BOOK_NAME=$1
ADJUSTMENT="40x90"
THRESHOLD="22"
FILE_COUNT=0
echo "Running stage2.sh with BOOK_NAME=$BOOK_NAME"
echo "Looking for images in ${BOOK_NAME}"
for file in $(find ${BOOK_NAME} -type f -name "*.jpg"); do
    FILE_COUNT=$((FILE_COUNT+1))
    echo "Processing file #$FILE_COUNT: $(realpath $file)..."
    convert "$file" -brightness-contrast $ADJUSTMENT -threshold $THRESHOLD% "${file%.jpg}-processed.jpg"
    if [ $? -eq 0 ]; then
        echo "Successfully processed $(realpath $file)"
    else
        echo "Failed to process $(realpath $file)"
    fi
done
echo "Finished processing $FILE_COUNT images in ${BOOK_NAME}"
