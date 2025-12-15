# FOUNDIT Release Notes

---

## 🎉 v1.0.2 - December 16, 2024

### ✨ New Features

- **Poster Name Display**: Item cards now show "Posted by [FirstName]"
- **Custom App Icon**: New FOUNDIT branding replaces default Flutter icon
- **Firebase Hosting**: Web app live at https://foundit-gcet.web.app
- **Environment Variables**: All sensitive keys moved to `.env` file

### 🔧 Improvements

- Improved spacing between item cards (12px gap)
- Better sign-out flow - redirects to login screen
- Removed unnecessary profile completion screen
- Enhanced Firestore security rules with input validation

### 🐛 Bug Fixes

- Fixed Google Sign-In OAuth client ID for web
- Fixed WhatsApp button not working on Android
- Fixed user name not appearing on posts
- Fixed Firestore permission denied errors

### 🔐 Security

- Enabled college email domain restriction
- Added server-side validation in Firestore rules
- Environment variables for API keys
- Updated `.gitignore` to protect secrets

---

## 📱 v1.0.1 - December 13, 2024

### ✨ New Features

- **Web Platform Support**: Full Flutter Web compatibility
- **Cloudinary Integration**: Free image hosting (replaced Firebase Storage)
- **Cross-platform Image Picker**: Works on Android, iOS, and Web

### 🔧 Improvements

- Firebase CLI integration for automated setup
- Automated Firestore index deployment
- Responsive design for all screen sizes
- Project cleanup - removed unnecessary files

### 🐛 Bug Fixes

- Fixed web image picker errors
- Fixed Firestore index errors
- Fixed Cloudinary 401 authentication

---

## 🚀 v1.0.0 - November 9, 2024

### Initial Release

- **Core Features**
  - Google Sign-In with college email restriction
  - Post lost/found items with photos
  - Real-time feed with filters
  - Search by category, location, status
  - Direct contact via WhatsApp/Phone/Email

- **Admin Features**
  - Dashboard with statistics
  - Post moderation (delete/resolve)
  - Activity logging

- **Design**
  - Glassmorphism UI theme
  - Dark mode support
  - Skeleton loaders
  - Hero animations

---

## 📥 Download

| Version | APK | Web |
|---------|-----|-----|
| v1.0.2 | [Download](https://github.com/Kushwahaabhay/FOUNDIT/releases) | [Live](https://foundit-gcet.web.app) |
| v1.0.1 | [Download](https://github.com/Kushwahaabhay/FOUNDIT/releases) | - |
| v1.0.0 | [Download](https://github.com/Kushwahaabhay/FOUNDIT/releases) | - |

---

## 🔮 Roadmap

### Planned Features

| Feature | Status | Target |
|---------|--------|--------|
| Push Notifications | 🔄 Planned | v1.1.0 |
| In-App Chat | 🔄 Planned | v1.2.0 |
| Smart Matching (AI) | 🔄 Research | v2.0.0 |
| Map Integration | 🔄 Planned | v1.3.0 |

---

## 📞 Support

For issues or feature requests:
- **GitHub Issues**: [Create Issue](https://github.com/Kushwahaabhay/FOUNDIT/issues)
- **Email**: kushwahaabhay099@gmail.com

---

**Made with ❤️ by GCET Data Science Team**