#!/bin/bash

# Set some variables
ARCHIVE_URL="http://github.com/downloads/UberGallery/scripts/sample-images.tar.gz"
TEMP_DIR="/tmp"
FILE_NAME="$TEMP_DIR/sample-images.tar.gz"
IMAGE_DIR="$(dirname $(pwd))/gallery-images"

# Verify /tmp directory permissions
if [ ! -r $TEMP_DIR ] || [ ! -w $TEMP_DIR ]; then
    echo "ERROR: $TEMP_DIR does not exist or you don't have permission to access it"
    exit 1
fi

# Verify gallery image directory permissions
if [ ! -r $IMAGE_DIR ] || [ ! -w $IMAGE_DIR ]; then
    echo "ERROR: $IMAGE_DIR does not exist or you don't have permission to access it"
    exit 1
fi

# Fetch the archive
echo "Downloading image archive from $ARCHIVE_URL"
wget $ARCHIVE_URL --progress=dot:binary -O $FILE_NAME |& grep "%"

# Extract the archive
echo "Extracting images to $IMAGE_DIR"
tar -xzvf $FILE_NAME -C $IMAGE_DIR
