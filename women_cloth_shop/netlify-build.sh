#!/usr/bin/env bash
set -euo pipefail

FLUTTER_VERSION=3.13.3

wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
tar -xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz

export PATH="$PWD/flutter/bin:$PATH"

flutter config --enable-web
flutter precache --web

flutter pub get
flutter build web --release

cp web/_redirects build/web/_redirects