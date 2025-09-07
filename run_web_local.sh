#!/bin/bash

# Flutter Web Local Development Server
# Uses a local HTTP server to serve the built web files
# This avoids CanvasKit loading issues completely

echo "🚀 Starting Flutter Web Local Development Server..."

# Build the web app first
echo "🔨 Building Flutter web application..."
flutter build web --debug

# Check if build was successful
if [ ! -d "build/web" ]; then
    echo "❌ Error: Web build failed - build/web directory not found"
    exit 1
fi

echo "✅ Web build completed successfully"

# Start a local HTTP server
echo "🌐 Starting local HTTP server on port 8080..."
echo "📱 App available at: http://localhost:8080"
echo ""
echo "💡 Tips:"
echo "   • Rebuild with 'flutter build web --debug' when you make changes"
echo "   • Use 'flutter build web --release' for production builds"
echo "   • Press Ctrl+C to stop the server"
echo ""

# Start the server
cd build/web && python3 -m http.server 8080
