#!/bin/bash
##
## Be sure to read the license file
##
## This is a simple launch script to run the LibreWolf AppImage in a portable manner

mkdir -p "$PWD/profile"

FILENAME=$(ls LibreWolf*.AppImage)

"$PWD/$FILENAME" --profile "$PWD/profile" --no-remote

