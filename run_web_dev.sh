#!/bin/bash

# Flutter Web Development Launcher
# Optimized for faster Chrome launches and CanvasKit issues

echo "🚀 Starting Flutter Web Development Server..."

# Kill any existing Chrome processes (optional)
# pkill -f "Google Chrome"

# Check if we should use local server approach
if [ "$1" = "--local" ]; then
    echo "🌐 Using local HTTP server approach (most reliable)"
    echo "🔨 Building Flutter web application..."
    flutter build web --debug
    
    if [ ! -d "build/web" ]; then
        echo "❌ Error: Web build failed - build/web directory not found"
        exit 1
    fi
    
    echo "✅ Web build completed successfully"
    
    # Copy development-specific HTML file
    echo "📝 Using development-specific HTML configuration..."
    cp web/index_dev.html build/web/index.html
    
    echo "🌐 Starting local HTTP server on port 8080..."
    echo "📱 App available at: http://localhost:8080"
    echo ""
    echo "💡 Tips:"
    echo "   • Rebuild with 'flutter build web --debug' when you make changes"
    echo "   • Press Ctrl+C to stop the server"
    echo ""
    
    # Start the server
    cd build/web && python3 -m http.server 8080
    exit 0
fi

# Launch Flutter with optimized settings
flutter run -d chrome \
  --web-port=8080 \
  --web-browser-flag="--disable-web-security" \
  --web-browser-flag="--disable-features=VizDisplayCompositor" \
  --web-browser-flag="--disable-background-timer-throttling" \
  --web-browser-flag="--disable-backgrounding-occluded-windows" \
  --web-browser-flag="--disable-renderer-backgrounding" \
  --web-browser-flag="--enable-gpu" \
  --web-browser-flag="--enable-gpu-rasterization" \
  --web-browser-flag="--disable-extensions" \
  --web-browser-flag="--no-sandbox"

echo "✅ Flutter Web Development Server Started!"
echo "🌐 App available at: http://localhost:8080"
echo "🔧 DevTools available at: http://localhost:9100"
echo ""
echo "💡 Tips:"
echo "   • Use './run_web_dev.sh --local' for local HTTP server (most reliable)"
echo "   • Press 'r' for hot reload"
echo "   • Press 'R' for hot restart"
echo "   • Press 'q' to quit"
