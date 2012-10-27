#!/bin/bash

# Set some variables
IMAGE_ARCHIVE='http://github.com/downloads/UberGallery/scripts/sample-images.tar.gz'
DL_LOCATION='/tmp/sample-images.tar.gz'
IMAGE_DIR=$(pwd)/../gallery-images

# Fetch the archive
wget $IMAGE_ARCHIVE -O $DL_LOCATION

# Extract the archive
tar -xzvf $DL_LOCATION -C $IMAGE_DIR
