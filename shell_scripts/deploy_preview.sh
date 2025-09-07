#!/bin/bash

# Preview Deployment Script
# This script builds and deploys the Flutter web app for preview environments
# Can be run from any branch except main

set -e  # Exit on any error

echo "🚀 Starting Preview Deployment..."

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current branch: $CURRENT_BRANCH"

# Verify we're not on main branch
if [ "$CURRENT_BRANCH" = "main" ]; then
    echo "❌ Error: Preview deployment should not be run from main branch"
    echo "   Use deploy_production.sh for main branch deployments"
    exit 1
fi

# Build the web application for preview (debug mode for faster builds)
echo "🔨 Building Flutter web application for preview..."
flutter build web --debug

# Check if build was successful
if [ ! -d "build/web" ]; then
    echo "❌ Error: Web build failed - build/web directory not found"
    exit 1
fi

echo "✅ Preview build completed successfully"

# Create a backup of the build directory
echo "💾 Creating backup of preview build..."
cp -r build/web /tmp/flutter_web_preview_backup_$(date +%s) 2>/dev/null || true

# Handle uncommitted changes by committing them temporarily
echo "💾 Handling uncommitted changes..."
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "📝 Committing current changes temporarily..."
    git add .
    git commit -m "Temporary commit before preview deployment - $(date '+%Y-%m-%d %H:%M:%S')" || true
fi

# Create preview branch name
PREVIEW_BRANCH="preview-$CURRENT_BRANCH"
echo "🔄 Creating/updating preview branch: $PREVIEW_BRANCH"

# Switch to preview branch
if ! git checkout "$PREVIEW_BRANCH" 2>/dev/null; then
    echo "📝 Creating preview branch: $PREVIEW_BRANCH"
    git checkout -b "$PREVIEW_BRANCH"
fi

# Clean the preview branch (remove all files except .git)
echo "🧹 Cleaning preview branch..."
find . -maxdepth 1 -mindepth 1 -not -name ".git" -not -name "build" -exec rm -rf {} + 2>/dev/null || true

# Copy only the build/web contents to root
echo "📁 Copying preview web build files..."
if [ -d "build/web" ]; then
    cp -r build/web/* . 2>/dev/null || true
    cp -r build/web/.* . 2>/dev/null || true
else
    # Try to use the backup if build/web doesn't exist
    BACKUP_DIR=$(ls -t /tmp/flutter_web_preview_backup_* 2>/dev/null | head -1)
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
    echo "ℹ️  No changes to commit - preview build is identical to previous build"
else
    # Commit the changes
    echo "💾 Committing preview build..."
    git commit -m "Deploy preview build from $CURRENT_BRANCH - $(date '+%Y-%m-%d %H:%M:%S')"
    
    # Push to remote
    echo "🚀 Pushing to remote preview branch..."
    git push origin "$PREVIEW_BRANCH" --force
    
    echo "✅ Preview build deployed successfully!"
    echo "🌐 Preview URL: https://$PREVIEW_BRANCH.flutter-app-demo.pages.dev"
fi

# Switch back to original branch
echo "🔄 Switching back to $CURRENT_BRANCH branch..."
git checkout "$CURRENT_BRANCH"

# Clean up backup directories
echo "🧹 Cleaning up backup directories..."
rm -rf /tmp/flutter_web_preview_backup_* 2>/dev/null || true

echo "🎉 Preview deployment completed!"
echo ""
echo "📋 Summary:"
echo "   • Preview build created in build/web/"
echo "   • Files copied to $PREVIEW_BRANCH branch"
echo "   • Changes committed and pushed to remote"
echo "   • Preview URL: https://$PREVIEW_BRANCH.flutter-app-demo.pages.dev"
