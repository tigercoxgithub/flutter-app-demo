#!/bin/bash

# Production Deployment Script
# This script builds and deploys the Flutter web app to production
# Should only be run from the main branch

set -e  # Exit on any error

echo "🚀 Starting Production Deployment..."

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current branch: $CURRENT_BRANCH"

# Verify we're on main branch
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "❌ Error: Production deployment should only be run from main branch"
    echo "   Current branch: $CURRENT_BRANCH"
    echo "   Expected branch: main"
    exit 1
fi

# Check for uncommitted changes
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "❌ Error: You have uncommitted changes"
    echo "   Please commit or stash your changes before deploying to production"
    exit 1
fi

# Build the web application for production
echo "🔨 Building Flutter web application for production..."
flutter build web --release

# Check if build was successful
if [ ! -d "build/web" ]; then
    echo "❌ Error: Web build failed - build/web directory not found"
    exit 1
fi

echo "✅ Production build completed successfully"

# Create a backup of the build directory
echo "💾 Creating backup of production build..."
cp -r build/web /tmp/flutter_web_production_backup_$(date +%s) 2>/dev/null || true

# Handle uncommitted changes by committing them temporarily
echo "💾 Handling uncommitted changes..."
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "📝 Committing current changes temporarily..."
    git add .
    git commit -m "Temporary commit before production deployment - $(date '+%Y-%m-%d %H:%M:%S')" || true
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
echo "📁 Copying production web build files..."
if [ -d "build/web" ]; then
    cp -r build/web/* . 2>/dev/null || true
    cp -r build/web/.* . 2>/dev/null || true
else
    # Try to use the backup if build/web doesn't exist
    BACKUP_DIR=$(ls -t /tmp/flutter_web_production_backup_* 2>/dev/null | head -1)
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
    echo "ℹ️  No changes to commit - production build is identical to previous build"
else
    # Commit the changes
    echo "💾 Committing production build..."
    git commit -m "Deploy production build - $(date '+%Y-%m-%d %H:%M:%S')"
    
    # Push to remote
    echo "🚀 Pushing to remote web_builds branch..."
    git push origin web_builds
    
    echo "✅ Production build deployed successfully!"
    echo "🌐 Your app should be available at: https://flutter-app-demo.pages.dev"
fi

# Switch back to original branch
echo "🔄 Switching back to $CURRENT_BRANCH branch..."
git checkout "$CURRENT_BRANCH"

# Clean up backup directories
echo "🧹 Cleaning up backup directories..."
rm -rf /tmp/flutter_web_production_backup_* 2>/dev/null || true

echo "🎉 Production deployment completed!"
echo ""
echo "📋 Summary:"
echo "   • Production build created in build/web/"
echo "   • Files copied to web_builds branch"
echo "   • Changes committed and pushed to remote"
echo "   • Production URL: https://flutter-app-demo.pages.dev"
