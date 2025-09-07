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
./run_web_dev.sh

# Option 2: Use local HTTP server (most reliable, avoids CanvasKit issues)
./run_web_dev.sh --local

# Option 3: Use the dedicated local server script
./run_web_local.sh

# Option 4: Standard Flutter command
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
The web application is deployed to **Cloudflare Pages** at:
- **Production URL**: [https://flutter-app-demo.pages.dev](https://flutter-app-demo.pages.dev)
- **Build Command**: `flutter build web --release`
- **Build Output Directory**: `build/web`

### Deployment Configuration
- **Domain**: `flutter-app-demo.pages.dev`
- **Platform**: Cloudflare Pages
- **Source Branch**: `web_builds` (contains only built web files)
- **Build Command**: None (files are pre-built)
- **Build Output Directory**: `/` (root)
- **SEO Optimized**: Complete meta tags, sitemap, and structured data

### Automated Deployment
Use the provided deployment script to build and deploy:

```bash
# Deploy web build to web_builds branch
./deploy_web.sh
```

This script will:
1. Build the Flutter web app (`flutter build web --release`)
2. Switch to `web_builds` branch
3. Copy only the built web files to the branch root
4. Commit and push changes
5. Switch back to your development branch

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
./run_web_dev.sh --local

# Or use the dedicated local server script
./run_web_local.sh
```

**Note**: The local server approach uses a development-specific HTML file (`index_dev.html`) with more permissive Content Security Policy settings to allow CanvasKit loading.

### Chrome Launch Issues
If Chrome takes too long to launch or crashes:

```bash
# Kill existing Chrome processes
pkill -f "Google Chrome"

# Use the optimized script
./run_web_dev.sh
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