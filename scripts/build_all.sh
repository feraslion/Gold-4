#!/bin/bash
set -e
echo "🚀 Gold-4 Build Script"
cd mobile
flutter pub get
echo "🤖 Building Android APKs..."
flutter build apk --release --split-per-abi
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
  echo "🖥️ Building Windows..."
  flutter build windows --release
fi
echo "🎉 Done!"
