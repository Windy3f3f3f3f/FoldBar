#!/bin/bash
set -e

echo "Building FoldBar..."
swift build -c release

APP_DIR="FoldBar.app/Contents/MacOS"
mkdir -p "$APP_DIR"
cp .build/release/FoldBar "$APP_DIR/FoldBar"
cp Resources/Info.plist FoldBar.app/Contents/Info.plist

echo "Done! Run with: open FoldBar.app"
