#!/bin/bash

# Set the cache directory
CACHE_DIR="$(dirname $(pwd))/resources/cache"

# Purge the cache
rm -rfv $CACHE_DIR/*
