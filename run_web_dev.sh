#!/bin/bash

# Flutter Web Development Launcher
# Optimized for faster Chrome launches

echo "🚀 Starting Flutter Web Development Server..."

# Kill any existing Chrome processes (optional)
# pkill -f "Google Chrome"

# Launch Flutter with optimized settings
flutter run -d chrome \
  --web-port=8080 \
  --web-browser-flag="--disable-features=VizDisplayCompositor" \
  --web-browser-flag="--disable-background-timer-throttling" \
  --web-browser-flag="--disable-backgrounding-occluded-windows" \
  --web-browser-flag="--disable-renderer-backgrounding" \
  --web-browser-flag="--enable-gpu" \
  --web-browser-flag="--enable-gpu-rasterization"

echo "✅ Flutter Web Development Server Started!"
echo "🌐 App available at: http://localhost:8080"
echo "🔧 DevTools available at: http://localhost:9100"
