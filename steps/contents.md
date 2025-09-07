# Flutter Demo Project Structure

This document explains the purpose and function of each first-level file and folder in the `flutter_demo` directory.

## 📁 Directories

### `build/`
Contains compiled and generated files from the Flutter build process. This includes:
- Compiled Dart code
- Generated assets
- Platform-specific build artifacts
- Test cache files

### `.dart_tool/`
Flutter and Dart tooling cache directory. Contains:
- Package resolution cache
- Build system metadata
- Tool-specific temporary files

### `lib/`
The main source code directory containing all Dart/Flutter application code:
- Core application logic
- Feature modules
- Shared components
- Main application entry point

### `test/`
Contains all test files for the Flutter application:
- Unit tests
- Widget tests
- Integration tests
- Test utilities and helpers


### `macos/`
macOS desktop platform-specific files:
- Xcode project configuration
- macOS app bundle settings
- Native macOS code (Swift)
- Platform-specific assets and configurations

### `web/`
Web platform-specific files:
- HTML templates
- Web assets (icons, favicon)
- Web manifest for PWA support
- Platform-specific configurations

### `steps/`
Documentation and instruction files:
- Development guides
- Project setup instructions
- Architecture documentation

### `.git/`
Git version control directory:
- Repository metadata
- Commit history
- Branch information
- Git configuration

## 📄 Files

### `.gitignore`
Specifies which files and directories should be ignored by Git version control:
- Build artifacts
- IDE files
- Platform-specific generated files
- Temporary and cache files

### `README.md`
Project documentation and information:
- Project description
- Setup instructions
- Usage guidelines
- Development information

### `pubspec.yaml`
Flutter project configuration file:
- Project metadata (name, description, version)
- Dependencies and their versions
- Asset declarations
- Build configuration

### `flutter_01.log`
Flutter tool execution log file:
- Error logs from Flutter commands
- Debug information
- Tool execution traces

### `.flutter-plugins-dependencies`
Generated file listing Flutter plugin dependencies:
- Plugin version information
- Dependency resolution data
- Used by Flutter build system

### `pubspec.lock`
Lock file for dependency versions:
- Exact versions of all dependencies
- Ensures reproducible builds
- Generated automatically by `flutter pub get`

### `.metadata`
Flutter project metadata:
- Flutter SDK version used
- Project creation information
- Framework version details

### `analysis_options.yaml`
Dart static analysis configuration:
- Linting rules and preferences
- Code style guidelines
- Analysis tool settings


---

## 🎯 Summary

This Flutter project follows standard Flutter project structure with:
- **Source code** in `lib/`
- **Tests** in `test/`
- **Platform-specific code** in `macos/` and `web/`
- **Configuration files** at the root level
- **Build artifacts** in `build/`
- **Documentation** in `steps/`

The project is set up for cross-platform development supporting both web and macOS desktop platforms from a single codebase.
