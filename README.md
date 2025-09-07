# Flutter Demo App

A modern Flutter application built for both **Web** and **macOS Desktop** platforms using the same codebase. This project demonstrates best practices in Flutter development, including clean architecture, state management, and cross-platform compatibility.

## 🌐 Live Demo

**Web Application**: [https://flutter-app-demo.pages.dev](https://flutter-app-demo.pages.dev)

The live web version is deployed on Cloudflare Pages and showcases the full functionality of the Flutter web application.

## 🚀 Features

- **Cross-Platform**: Single codebase for Web and macOS Desktop
- **Material 3**: Modern design system with adaptive theming
- **Responsive Design**: Adapts to different screen sizes and platforms
- **State Management**: Riverpod for efficient state management
- **Navigation**: Go Router for declarative routing
- **Clean Architecture**: Feature-based folder structure
- **Modern UI**: Google Fonts, responsive layouts, and smooth animations

## 📱 Supported Platforms

- **Web**: Chrome, Firefox, Safari, Edge
- **macOS Desktop**: Native macOS application

## 🛠️ Tech Stack

- **Flutter**: ^3.10.0
- **Dart**: ^3.0.0
- **Riverpod**: State management
- **Go Router**: Navigation
- **Google Fonts**: Typography
- **Universal Platform**: Platform detection

## 📋 Prerequisites

- Flutter SDK (^3.10.0)
- Dart SDK (^3.0.0)
- **For macOS**: Xcode installed
- **For Web**: Modern web browser

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone <repository-url>
cd flutter_demo_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run the Application

#### For Web (Development):
```bash
# Option 1: Use the optimized development script (recommended)
./shell_scripts/run_web_dev.sh

# Option 2: Use local HTTP server (most reliable, avoids CanvasKit issues)
./shell_scripts/run_web_dev.sh --local

# Option 3: Standard Flutter command
flutter run -d chrome
```

#### For macOS Desktop:
```bash
flutter run -d macos
```

#### List Available Devices:
```bash
flutter devices
```

### 4. Build for Production

#### Web Build:
```bash
flutter build web --release
```

#### macOS Build:
```bash
flutter build macos --release
```

#### Build Both Platforms:
```bash
flutter build web --release && flutter build macos --release
```

## 🚀 Deployment

### Web Deployment (Cloudflare Pages)
The web application is deployed to **Cloudflare Pages** with a modern branch strategy:

- **Production URL**: [https://flutter-app-demo.pages.dev](https://flutter-app-demo.pages.dev)
- **Preview URLs**: `https://{hash}.flutter-app-demo.pages.dev`

### Branch Strategy
- **`main`** → Production deployment (automatic)
- **`develop`** → Preview deployment (automatic)
- **`staging`** → Preview deployment (automatic)
- **`feature/*`** → Preview deployment (automatic)

### Deployment Scripts

#### Production Deployment
```bash
# Deploy to production (from main branch only)
./shell_scripts/deploy_production.sh
```

#### Preview Deployment
```bash
# Deploy preview (from any branch except main)
./shell_scripts/deploy_preview.sh
```

#### Setup Branch Strategy
```bash
# Set up recommended branch structure
./shell_scripts/setup_branches.sh
```

### Automated Deployment
The project includes GitHub Actions for automatic deployments:

1. **Push to `main`** → Production deployment
2. **Push to `develop/staging/feature/*`** → Preview deployment
3. **Create Pull Request** → Preview deployment with PR comment

### Environment Configuration
- **Production**: Optimized build with production API endpoints
- **Preview**: Debug build with staging API endpoints
- **Environment Variables**: Configured in Cloudflare Pages dashboard

For detailed setup instructions, see [CLOUDFLARE_SETUP.md](CLOUDFLARE_SETUP.md).

## 📖 Development Workflow

- **[DEVELOPMENT_WORKFLOW.md](DEVELOPMENT_WORKFLOW.md)** - Complete development process from feature to production
- **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - Quick command reference for common tasks

## 🧪 Testing

Run the test suite:
```bash
flutter test
```

## 📁 Project Structure

```
lib/
├── core/
│   ├── theme/
│   │   └── app_theme.dart          # App theming
│   ├── router/
│   │   └── app_router.dart         # Navigation configuration
│   ├── constants/
│   │   └── app_constants.dart      # App constants
│   └── utils/
│       ├── platform_utils.dart     # Platform detection
│       └── responsive_utils.dart   # Responsive design helpers
├── features/
│   ├── home/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   └── widgets/
│   │   └── domain/
│   │       └── models/
│   ├── profile/
│   │   ├── presentation/
│   │   └── domain/
│   └── settings/
│       ├── presentation/
│       └── domain/
├── shared/
│   ├── presentation/
│   │   ├── widgets/
│   │   └── pages/
│   └── domain/
│       └── models/
└── main.dart                        # App entry point
```

### Shell Scripts
```
shell_scripts/
├── run_web_dev.sh                   # Web development server script
├── deploy_production.sh             # Production deployment script
├── deploy_preview.sh                # Preview deployment script
├── setup_branches.sh                # Branch strategy setup script
└── deploy_web.sh                    # Legacy web deployment script
```

### Environment Configuration
```
env.production                       # Production environment variables
env.preview                          # Preview environment variables
```

### GitHub Actions
```
.github/workflows/
└── deploy.yml                       # Automated deployment workflow
```

### Documentation
```
DEVELOPMENT_WORKFLOW.md              # Complete development process guide
QUICK_REFERENCE.md                   # Quick command reference
CLOUDFLARE_SETUP.md                  # Cloudflare Pages setup guide
```

## 🎨 Design System

### Theme
- **Material 3**: Latest design system
- **Adaptive Theming**: Light and dark mode support
- **Platform-Specific**: Optimized for web and desktop

### Colors
- **Primary**: Blue-based color scheme
- **Adaptive**: Automatically adjusts for light/dark themes

### Typography
- **Font**: Inter (Google Fonts)
- **Responsive**: Scales appropriately across devices

## 🔧 Development

### Code Formatting
```bash
flutter format .
```

### Code Analysis
```bash
flutter analyze
```

### Hot Reload
- **Web**: Automatic hot reload in browser
- **macOS**: Hot reload with `r` key in terminal

## 📦 Dependencies

### Core Dependencies
- `flutter_riverpod`: State management
- `go_router`: Navigation
- `google_fonts`: Typography
- `gap`: Consistent spacing
- `http`: Networking
- `universal_platform`: Platform detection
- `logging`: Logging utilities

### Dev Dependencies
- `flutter_test`: Testing framework
- `flutter_lints`: Code linting

## 🌐 Web-Specific Features

- **SEO Optimized**: Meta tags and structured data
- **PWA Ready**: Progressive Web App capabilities
- **Responsive**: Mobile-first design approach
- **Performance**: Optimized for web delivery

## 🖥️ macOS-Specific Features

- **Native Feel**: macOS-specific UI patterns
- **Window Management**: Proper window sizing and behavior
- **Menu Integration**: Native menu bar support
- **File System**: Platform-appropriate file handling

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and ensure they pass
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod for state management
- Google Fonts for typography
- Material Design for the design system

## 🔧 Troubleshooting

### CanvasKit Loading Issues
If you encounter errors like "Failed to fetch dynamically imported module" or CanvasKit loading problems:

```bash
# Use the local server approach (most reliable)
./shell_scripts/run_web_dev.sh --local
```

**Note**: The local server approach uses a development-specific HTML file (`index_dev.html`) with more permissive Content Security Policy settings to allow CanvasKit loading.

### Chrome Launch Issues
If Chrome takes too long to launch or crashes:

```bash
# Kill existing Chrome processes
pkill -f "Google Chrome"

# Use the optimized script
./shell_scripts/run_web_dev.sh
```

### Build Issues
If you encounter build errors:

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter build web --debug
```

### Hot Reload Not Working
If hot reload stops working:

```bash
# Press 'R' for hot restart instead of 'r' for hot reload
# Or restart the development server
```

## 📞 Support

If you encounter any issues or have questions, please:
1. Check the existing issues
2. Create a new issue with detailed information
3. Provide steps to reproduce any bugs

---

**Built with ❤️ using Flutter and modern development practices**