#!/bin/bash

# Branch Setup Script
# This script sets up the recommended branch strategy for Cloudflare Pages

set -e  # Exit on any error

echo "🌿 Setting up recommended branch strategy..."

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current branch: $CURRENT_BRANCH"

# Ensure we're on main branch
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "🔄 Switching to main branch..."
    git checkout main
fi

# Create develop branch if it doesn't exist
if ! git show-ref --verify --quiet refs/heads/develop; then
    echo "📝 Creating develop branch..."
    git checkout -b develop
    echo "✅ Created develop branch"
else
    echo "ℹ️  Develop branch already exists"
    git checkout develop
fi

# Create staging branch if it doesn't exist
if ! git show-ref --verify --quiet refs/heads/staging; then
    echo "📝 Creating staging branch..."
    git checkout -b staging
    echo "✅ Created staging branch"
else
    echo "ℹ️  Staging branch already exists"
    git checkout staging
fi

# Switch back to main
git checkout main

echo "🎉 Branch setup completed!"
echo ""
echo "📋 Branch Strategy:"
echo "   • main (production) - Auto-deploys to production"
echo "   • develop - Auto-deploys to preview"
echo "   • staging - Auto-deploys to preview"
echo "   • feature/* - Auto-deploys to preview"
echo ""
echo "🚀 Next steps:"
echo "   1. Push branches to remote: git push origin main develop staging"
echo "   2. Configure Cloudflare Pages branch settings"
echo "   3. Set up environment variables for production and preview"
echo ""
echo "📖 Documentation:"
echo "   • Production: ./shell_scripts/deploy_production.sh"
echo "   • Preview: ./shell_scripts/deploy_preview.sh"
