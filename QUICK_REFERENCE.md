# Quick Reference - Development Commands

## 🚀 Most Common Commands

### Start Development
```bash
# Switch to develop branch
git checkout develop
git pull origin develop

# Run development server
./shell_scripts/run_web_dev.sh --local
```

### Create Feature
```bash
# Create feature branch
git checkout -b feature/your-feature-name

# Work on feature, then commit
git add .
git commit -m "feat: your feature description"

# Push feature branch
git push origin feature/your-feature-name
```

### Deploy Preview
```bash
# Deploy current branch for preview
./shell_scripts/deploy_preview.sh
# URL: https://preview-{branch-name}.flutter-app-demo.pages.dev
```

### Merge to Develop
```bash
# After PR approval
git checkout develop
git merge feature/your-feature-name
git push origin develop
```

### Deploy to Production
```bash
# Switch to main and merge develop
git checkout main
git merge develop

# Deploy to production
./shell_scripts/deploy_production.sh
# URL: https://flutter-app-demo.pages.dev
```

## 🔧 Testing Commands

```bash
# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
flutter format .
```

## 🌐 Environment URLs

| Environment | URL |
|-------------|-----|
| **Production** | https://flutter-app-demo.pages.dev |
| **Staging** | https://preview-staging.flutter-app-demo.pages.dev |
| **Development** | https://preview-develop.flutter-app-demo.pages.dev |

## 🚨 Emergency Commands

```bash
# Rollback production
git checkout main
git reset --hard <last-good-commit>
git push origin main --force
./shell_scripts/deploy_production.sh

# Hotfix
git checkout main
git checkout -b hotfix/critical-fix
# Make fix, then deploy
./shell_scripts/deploy_production.sh
```
