# Development Workflow Procedure

This document outlines the complete process for working on the develop branch and deploying updates to production.

## 📋 Overview

Our development workflow follows a **Git Flow** pattern with the following branches:
- **`main`** - Production branch (stable, deployed to production)
- **`develop`** - Development branch (integration branch for features)
- **`staging`** - Staging branch (pre-production testing)
- **`feature/*`** - Feature branches (individual feature development)

## 🌿 Branch Strategy

```
main (production) ←─── develop ←─── feature/feature-name
     ↑                    ↑              ↑
   Auto deploy        Auto deploy    Auto deploy
   to production      to preview     to preview
```

## 🚀 Development Workflow

### Phase 1: Feature Development

#### 1.1 Create Feature Branch
```bash
# Ensure you're on develop branch
git checkout develop
git pull origin develop

# Create and switch to new feature branch
git checkout -b feature/your-feature-name

# Example:
git checkout -b feature/add-user-authentication
```

#### 1.2 Work on Feature
```bash
# Make your changes
# Edit files, add new features, fix bugs, etc.

# Stage changes
git add .

# Commit changes with descriptive message
git commit -m "feat: add user authentication system

- Add login/logout functionality
- Implement JWT token handling
- Add user profile management
- Update UI components for auth flow"
```

#### 1.3 Push Feature Branch
```bash
# Push feature branch to remote
git push origin feature/your-feature-name
```

#### 1.4 Test Feature Locally
```bash
# Run tests
flutter test

# Run development server
./shell_scripts/run_web_dev.sh

# Or use local server (most reliable)
./shell_scripts/run_web_dev.sh --local
```

#### 1.5 Deploy Feature for Preview
```bash
# Deploy feature branch for preview testing
./shell_scripts/deploy_preview.sh

# This will create a preview URL like:
# https://preview-feature-your-feature-name.flutter-app-demo.pages.dev
```

### Phase 2: Integration to Develop

#### 2.1 Create Pull Request
1. Go to GitHub repository
2. Click "Compare & pull request" for your feature branch
3. Set base branch to `develop`
4. Add descriptive title and description
5. Request review from team members
6. Link any related issues

#### 2.2 Code Review Process
- **Reviewer**: Check code quality, functionality, and adherence to standards
- **Author**: Address review comments and make necessary changes
- **Testing**: Verify feature works in preview environment
- **Approval**: Get at least one approval before merging

#### 2.3 Merge to Develop
```bash
# After PR approval, merge to develop
# This can be done via GitHub UI or locally:

git checkout develop
git pull origin develop
git merge feature/your-feature-name
git push origin develop
```

#### 2.4 Clean Up Feature Branch
```bash
# Delete local feature branch
git branch -d feature/your-feature-name

# Delete remote feature branch
git push origin --delete feature/your-feature-name
```

### Phase 3: Staging and Testing

#### 3.1 Deploy Develop to Staging
```bash
# Switch to develop branch
git checkout develop
git pull origin develop

# Deploy to staging for integration testing
git checkout staging
git merge develop
git push origin staging

# Deploy staging to preview
./shell_scripts/deploy_preview.sh
```

#### 3.2 Staging Testing
- **URL**: `https://preview-staging.flutter-app-demo.pages.dev`
- **Testing**: Full integration testing, user acceptance testing
- **Performance**: Load testing, performance validation
- **Cross-browser**: Test on different browsers and devices

#### 3.3 Fix Issues Found in Staging
```bash
# If issues found, fix them in develop branch
git checkout develop

# Make fixes
git add .
git commit -m "fix: resolve staging issues

- Fix authentication bug
- Improve performance
- Update error handling"

# Push fixes
git push origin develop

# Re-deploy to staging
git checkout staging
git merge develop
git push origin staging
./shell_scripts/deploy_preview.sh
```

### Phase 4: Production Deployment

#### 4.1 Pre-Production Checklist
- [ ] All tests passing
- [ ] Code review completed
- [ ] Staging testing successful
- [ ] Performance validated
- [ ] Security review completed
- [ ] Documentation updated
- [ ] Rollback plan prepared

#### 4.2 Deploy to Production
```bash
# Switch to main branch
git checkout main
git pull origin main

# Merge develop to main
git merge develop

# Deploy to production
./shell_scripts/deploy_production.sh

# Push main branch
git push origin main
```

#### 4.3 Post-Deployment Verification
- [ ] Production URL accessible: `https://flutter-app-demo.pages.dev`
- [ ] All features working correctly
- [ ] Performance metrics normal
- [ ] Error monitoring shows no critical issues
- [ ] User feedback positive

## 🔧 Development Commands Reference

### Branch Management
```bash
# List all branches
git branch -a

# Switch to branch
git checkout branch-name

# Create new branch
git checkout -b new-branch-name

# Delete local branch
git branch -d branch-name

# Delete remote branch
git push origin --delete branch-name
```

### Deployment Commands
```bash
# Deploy preview (from any branch except main)
./shell_scripts/deploy_preview.sh

# Deploy production (from main branch only)
./shell_scripts/deploy_production.sh

# Run development server
./shell_scripts/run_web_dev.sh

# Run local development server
./shell_scripts/run_web_dev.sh --local
```

### Testing Commands
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage

# Analyze code
flutter analyze

# Format code
flutter format .
```

## 🚨 Emergency Procedures

### Hotfix Process
```bash
# Create hotfix branch from main
git checkout main
git checkout -b hotfix/critical-bug-fix

# Make urgent fix
git add .
git commit -m "hotfix: fix critical production bug"

# Deploy hotfix to production
./shell_scripts/deploy_production.sh

# Merge back to develop
git checkout develop
git merge hotfix/critical-bug-fix
git push origin develop
```

### Rollback Procedure
```bash
# If production deployment fails
git checkout main
git log --oneline  # Find last good commit
git reset --hard <last-good-commit-hash>
git push origin main --force

# Re-deploy production
./shell_scripts/deploy_production.sh
```

## 📊 Environment URLs

| Environment | Branch | URL | Purpose |
|-------------|--------|-----|---------|
| **Production** | `main` | `https://flutter-app-demo.pages.dev` | Live production site |
| **Staging** | `staging` | `https://preview-staging.flutter-app-demo.pages.dev` | Pre-production testing |
| **Development** | `develop` | `https://preview-develop.flutter-app-demo.pages.dev` | Integration testing |
| **Feature** | `feature/*` | `https://preview-feature-*.flutter-app-demo.pages.dev` | Feature testing |

## 🔍 Quality Gates

### Code Quality
- [ ] Code follows project style guidelines
- [ ] No linting errors (`flutter analyze`)
- [ ] All tests passing (`flutter test`)
- [ ] Code coverage meets requirements
- [ ] No security vulnerabilities

### Functional Quality
- [ ] Feature works as specified
- [ ] No regression in existing functionality
- [ ] Performance meets requirements
- [ ] UI/UX follows design standards
- [ ] Cross-browser compatibility verified

### Deployment Quality
- [ ] Build completes successfully
- [ ] Preview deployment accessible
- [ ] All environment variables configured
- [ ] Monitoring and logging working
- [ ] Rollback plan tested

## 📝 Best Practices

### Commit Messages
Use conventional commit format:
```
type(scope): description

feat(auth): add user login functionality
fix(ui): resolve button alignment issue
docs(readme): update installation instructions
refactor(api): simplify data fetching logic
test(auth): add unit tests for login
```

### Branch Naming
- **Features**: `feature/description` (e.g., `feature/user-dashboard`)
- **Bugfixes**: `fix/description` (e.g., `fix/login-error`)
- **Hotfixes**: `hotfix/description` (e.g., `hotfix/security-patch`)
- **Chores**: `chore/description` (e.g., `chore/update-dependencies`)

### Pull Request Guidelines
- **Title**: Clear, descriptive title
- **Description**: Detailed explanation of changes
- **Screenshots**: Include UI changes
- **Testing**: Describe how changes were tested
- **Breaking Changes**: Note any breaking changes
- **Related Issues**: Link to related issues/PRs

## 🆘 Troubleshooting

### Common Issues

#### Build Failures
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter build web --release
```

#### Preview Not Working
```bash
# Check branch name
git branch --show-current

# Ensure not on main branch
git checkout develop

# Re-deploy
./shell_scripts/deploy_preview.sh
```

#### Production Deployment Issues
```bash
# Check you're on main branch
git branch --show-current

# Ensure no uncommitted changes
git status

# Re-deploy
./shell_scripts/deploy_production.sh
```

### Getting Help
- **Documentation**: Check `README.md` and `CLOUDFLARE_SETUP.md`
- **Issues**: Create GitHub issue for bugs or questions
- **Team**: Contact team members for urgent issues
- **Logs**: Check Cloudflare Pages build logs for deployment issues

## 📚 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Cloudflare Pages Documentation](https://developers.cloudflare.com/pages/)
- [Git Flow Guide](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

**Last Updated**: September 7, 2025  
**Version**: 1.0  
**Maintainer**: Development Team
