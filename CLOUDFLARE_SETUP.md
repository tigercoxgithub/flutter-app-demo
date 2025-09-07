# Cloudflare Pages Setup Guide

This guide explains how to configure Cloudflare Pages for the recommended branch strategy.

## 🌿 Branch Strategy

### Production Branch
- **Branch**: `main`
- **URL**: `https://flutter-app-demo.pages.dev`
- **Build Command**: `flutter build web --release`
- **Build Output Directory**: `build/web`

### Preview Branches
- **Branches**: `develop`, `staging`, `feature/*`
- **URLs**: `https://{hash}.flutter-app-demo.pages.dev`
- **Build Command**: `flutter build web --debug`
- **Build Output Directory**: `build/web`

## ⚙️ Cloudflare Pages Configuration

### 1. Project Settings

1. Go to **Workers & Pages** in Cloudflare Dashboard
2. Select your project: `flutter-app-demo`
3. Go to **Settings** > **Builds & deployments**

### 2. Production Branch Configuration

- **Production branch**: `main`
- **Enable automatic production branch deployments**: ✅ (checked)
- **Build command**: `flutter build web --release`
- **Build output directory**: `build/web`

### 3. Preview Branch Configuration

- **Preview branch control**: `Custom branches`
- **Include Preview branches**: 
  ```
  develop
  staging
  feature/*
  ```
- **Exclude Preview branches**: 
  ```
  main
  docs/*
  chore/*
  ```

### 4. Environment Variables

#### Production Environment
| Variable | Value | Description |
|----------|-------|-------------|
| `API_BASE_URL` | `https://api.flutter-demo.com` | Production API endpoint |
| `ANALYTICS_ID` | `prod-123456789` | Production analytics ID |
| `DEBUG_MODE` | `false` | Disable debug mode |
| `LOG_LEVEL` | `error` | Production log level |

#### Preview Environment
| Variable | Value | Description |
|----------|-------|-------------|
| `API_BASE_URL` | `https://staging-api.flutter-demo.com` | Staging API endpoint |
| `ANALYTICS_ID` | `staging-987654321` | Staging analytics ID |
| `DEBUG_MODE` | `true` | Enable debug mode |
| `LOG_LEVEL` | `debug` | Debug log level |

### 5. Build Configuration

#### Node.js Version
- **Node.js version**: `18.x` (or latest LTS)

#### Build Commands
- **Production**: `flutter build web --release`
- **Preview**: `flutter build web --debug`

## 🚀 Deployment Workflow

### Automatic Deployments

1. **Push to `main`** → Automatic production deployment
2. **Push to `develop`** → Automatic preview deployment
3. **Push to `staging`** → Automatic preview deployment
4. **Push to `feature/*`** → Automatic preview deployment
5. **Create Pull Request** → Automatic preview deployment

### Manual Deployments

```bash
# Production deployment (from main branch)
./shell_scripts/deploy_production.sh

# Preview deployment (from any branch except main)
./shell_scripts/deploy_preview.sh
```

## 🔧 GitHub Actions Integration

The project includes a GitHub Actions workflow (`.github/workflows/deploy.yml`) that:

1. **Runs tests** on every push and PR
2. **Builds the app** with appropriate environment variables
3. **Deploys to Cloudflare Pages** automatically
4. **Comments on PRs** with preview URLs

### Required Secrets

Add these secrets to your GitHub repository:

| Secret | Description |
|--------|-------------|
| `CLOUDFLARE_API_TOKEN` | Cloudflare API token with Pages permissions |
| `CLOUDFLARE_ACCOUNT_ID` | Your Cloudflare account ID |
| `API_BASE_URL_PROD` | Production API URL |
| `API_BASE_URL_STAGING` | Staging API URL |
| `ANALYTICS_ID_PROD` | Production analytics ID |
| `ANALYTICS_ID_STAGING` | Staging analytics ID |

## 📱 URL Structure

### Production
- **Main URL**: `https://flutter-app-demo.pages.dev`
- **Custom Domain**: (if configured)

### Preview
- **Hash-based**: `https://abc123.flutter-app-demo.pages.dev`
- **Branch-based**: `https://develop.flutter-app-demo.pages.dev`
- **PR-based**: `https://pr-123.flutter-app-demo.pages.dev`

## 🔒 Access Control

### Public Access (Default)
- All preview URLs are publicly accessible
- Production URL is publicly accessible

### Protected Access (Optional)
1. Go to **Settings** > **General** > **Enable access policy**
2. Configure Cloudflare Access rules
3. Only authenticated users can access preview deployments

## 🐛 Troubleshooting

### Build Failures
1. Check build logs in Cloudflare Pages dashboard
2. Verify environment variables are set correctly
3. Ensure Flutter version compatibility

### Preview Not Working
1. Verify branch is included in preview branch rules
2. Check that branch name matches include patterns
3. Ensure PR is from the same repository (not a fork)

### Environment Variables Not Loading
1. Verify variables are set in correct environment (Production vs Preview)
2. Check variable names match exactly (case-sensitive)
3. Ensure variables are saved in Cloudflare Pages settings

## 📚 Additional Resources

- [Cloudflare Pages Documentation](https://developers.cloudflare.com/pages/)
- [Branch Build Controls](https://developers.cloudflare.com/pages/configuration/branch-build-controls/)
- [Preview Deployments](https://developers.cloudflare.com/pages/configuration/preview-deployments/)
- [Environment Variables](https://developers.cloudflare.com/pages/configuration/build-configuration/)
