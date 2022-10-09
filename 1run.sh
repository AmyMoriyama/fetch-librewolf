#!/bin/bash
##
## Deps: jq, curl, wget, grep, sed, cut, sha256sum
##
## Be sure to check the license file.
##
## Script to fetch latest LibreWolf AppImage

VERSION1=$(curl -s "https://gitlab.com/api/v4/projects/24386000/releases" | jq '.[]' | jq -r '.name' | head -1)

APPIMAGE=$(curl -s "https://gitlab.com/api/v4/projects/24386000/releases/$VERSION1" | jq -r '.assets."links" | .[] | .url' | grep 'x86_64' | sed '/.sha256/d' - | sed '/sig/d' -)

VERSION2=$(echo $APPIMAGE | cut -f11 -d"/")

SHA256=$(curl -s "https://gitlab.com/api/v4/projects/24386000/releases/$VERSION1" | jq -r '.assets."links" | .[] | .url' | grep 'x86_64' | sed '/sha256/!d' -)

wget -4 -q --show-progress "$APPIMAGE"
wget -4 -q --show-progress "$SHA256"

mv "LibreWolf.x86_64.AppImage" "LibreWolf-$VERSION2.x86_64.AppImage"

echo ""
echo ""
echo "If below says 'OK', the download was successful."
sha256sum -c "LibreWolf.x86_64.AppImage.sha256"
rm "LibreWolf.x86_64.AppImage.sha256"
echo ""
echo ""

chmod +x ./LibreWolf*
echo "All done!"
