#!/bin/bash

echo "Building Gold-4 Accounting Suite..."

cd mobile

echo "1. Building Android APK..."
flutter build apk --release

echo "2. Building Android App Bundle..."
flutter build appbundle --release

echo "3. Building Web..."
flutter build web --release

echo "4. Building Windows (if on Windows)..."
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    flutter build windows --release
else
    echo "Skipping Windows build (not on Windows)"
fi

echo "Build complete. Check build/ directory."
