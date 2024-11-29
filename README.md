# Flutter Chat App

A modern, feature-rich chat application built with Flutter. This app provides a seamless messaging experience with a clean, intuitive interface inspired by popular messaging platforms.

## Features

- **Authentication**
  - Phone number authentication
  - OTP verification
  - Profile setup

- **Messaging**
  - Real-time chat functionality
  - Message status indicators
  - Timestamp display
  - Media sharing support

- **User Interface**
  - Modern, clean design
  - Custom theme support
  - Responsive layout
  - Custom animations

- **Profile Management**
  - User profile customization
  - Status updates
  - Profile picture management

- **Settings**
  - Chat customization
  - Notification preferences
  - Privacy settings
  - Data usage settings


## Technical Details

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.1.2
  intl_phone_field: ^3.2.0
  url_launcher: ^6.3.1
```

### Custom Fonts
- Mulish (Regular, Bold, SemiBold)
- Lato (SemiBold)

### Assets
- Images directory: `assets/images/`
- Fonts directory: `assets/fonts/`

## Getting Started

### Prerequisites
- Flutter SDK (^3.5.4)
- Dart SDK
- Android Studio / Xcode

### Installation

1. Clone the repository
```bash
git clone https://github.com/ahammednibras81/flutter_chat_app.git
```

2. Navigate to project directory
```bash
cd flutter_chat_app
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   ├── app_colors.dart
│   ├── app_theme.dart
│   └── app_typography.dart
├── models/
│   └── messages_model.dart
├── screens/
│   ├── welcome_screen.dart
│   ├── chat_screen.dart
│   ├── settings_screen.dart
│   └── ...
├── widgets/
│   ├── my_appbar.dart
│   ├── chat_widget.dart
│   └── ...
└── main.dart
```

## Design System

The app uses a consistent design system with:
- Custom color palette
- Typography scale
- Component library
- Responsive layouts

## Security

- Phone number verification
- Secure data storage
- Privacy-focused design

## Author

**Ahammed Nibras**

Made with ❤️ in Flutter
