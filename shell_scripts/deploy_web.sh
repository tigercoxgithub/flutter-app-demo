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

# Create a backup of the build directory
echo "💾 Creating backup of build directory..."
cp -r build/web /tmp/flutter_web_build_backup_$(date +%s) 2>/dev/null || true

# Handle uncommitted changes by committing them temporarily
echo "💾 Handling uncommitted changes..."
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "📝 Committing current changes temporarily..."
    git add .
    git commit -m "Temporary commit before web deployment - $(date '+%Y-%m-%d %H:%M:%S')" || true
fi

# Switch to web_builds branch
echo "🔄 Switching to web_builds branch..."
if ! git checkout web_builds 2>/dev/null; then
    echo "📝 Creating web_builds branch..."
    git checkout -b web_builds
fi

# Clean the web_builds branch (remove all files except .git)
echo "🧹 Cleaning web_builds branch..."
find . -maxdepth 1 -mindepth 1 -not -name ".git" -not -name "build" -exec rm -rf {} + 2>/dev/null || true

# Copy only the build/web contents to root
echo "📁 Copying web build files..."
if [ -d "build/web" ]; then
    cp -r build/web/* . 2>/dev/null || true
    cp -r build/web/.* . 2>/dev/null || true
else
    # Try to use the backup if build/web doesn't exist
    BACKUP_DIR=$(ls -t /tmp/flutter_web_build_backup_* 2>/dev/null | head -1)
    if [ -n "$BACKUP_DIR" ] && [ -d "$BACKUP_DIR" ]; then
        echo "📁 Using backup build directory..."
        cp -r "$BACKUP_DIR"/* . 2>/dev/null || true
        cp -r "$BACKUP_DIR"/.* . 2>/dev/null || true
    else
        echo "❌ Error: build/web directory not found and no backup available"
        echo "🔄 Switching back to $CURRENT_BRANCH branch..."
        git checkout "$CURRENT_BRANCH"
        exit 1
    fi
fi

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

# The temporary commit is already on the current branch, so no restoration needed
echo "✅ All changes are preserved in the current branch"

# Clean up backup directories
echo "🧹 Cleaning up backup directories..."
rm -rf /tmp/flutter_web_build_backup_* 2>/dev/null || true

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
