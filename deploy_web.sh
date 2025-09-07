#!/bin/bash

# Web Build and Deploy Script
# This script builds the Flutter web app and pushes only the build/web directory to the web_builds branch

set -e  # Exit on any error

echo "🚀 Starting Web Build and Deploy Process..."

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current branch: $CURRENT_BRANCH"

# Build the web application
echo "🔨 Building Flutter web application..."
flutter build web --release

# Check if build was successful
if [ ! -d "build/web" ]; then
    echo "❌ Error: Web build failed - build/web directory not found"
    exit 1
fi

echo "✅ Web build completed successfully"

# Switch to web_builds branch
echo "🔄 Switching to web_builds branch..."
git checkout web_builds

# Remove all files except build/web and essential git files
echo "🧹 Cleaning web_builds branch..."
git rm -rf . 2>/dev/null || true

# Copy only the build/web contents to root
echo "📁 Copying web build files..."
cp -r build/web/* .
cp -r build/web/.* . 2>/dev/null || true

# Add all files to git
echo "📝 Adding files to git..."
git add .

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo "ℹ️  No changes to commit - web build is identical to previous build"
else
    # Commit the changes
    echo "💾 Committing web build..."
    git commit -m "Deploy web build - $(date '+%Y-%m-%d %H:%M:%S')"
    
    # Push to remote
    echo "🚀 Pushing to remote web_builds branch..."
    git push origin web_builds
    
    echo "✅ Web build deployed successfully!"
    echo "🌐 Your app should be available at: https://flutter-app-demo.pages.dev"
fi

# Switch back to original branch
echo "🔄 Switching back to $CURRENT_BRANCH branch..."
git checkout "$CURRENT_BRANCH"

echo "🎉 Deploy process completed!"
echo ""
echo "📋 Summary:"
echo "   • Web build created in build/web/"
echo "   • Files copied to web_builds branch"
echo "   • Changes committed and pushed to remote"
echo "   • Switched back to $CURRENT_BRANCH branch"
echo ""
echo "🔗 Next steps:"
echo "   • Configure Cloudflare Pages to deploy from web_builds branch"
echo "   • Set build command: (none needed - files are pre-built)"
echo "   • Set build output directory: / (root)"
