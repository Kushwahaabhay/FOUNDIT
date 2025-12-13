# FOUNDIT - Smart Campus Lost & Found System

[![GitHub Release](https://img.shields.io/badge/Download-APK-brightgreen)](https://github.com/Kushwahaabhay/FOUNDIT/releases)
[![Version](https://img.shields.io/badge/version-2.0.0-blue)](https://github.com/Kushwahaabhay/FOUNDIT)

**A modern Flutter app for GCET students to report and find lost items on campus.**

> ⚠️ **Security Notice:** All API keys have been replaced with template values for security. You'll need to configure Firebase and Cloudinary with your own credentials.
> 
> 🔒 **Safe for Distribution:** This repository contains no sensitive data and is ready for open-source use.

## 🎯 Features

- **Smart Feed System**: Browse lost and found items with real-time updates
- **Google Authentication**: Secure login with college email domain restriction  
- **Image Upload**: High-quality image support with Cloudinary integration
- **Advanced Search & Filter**: Find items by category, location, and status
- **Admin Dashboard**: Comprehensive management tools for administrators
- **Glassmorphism UI**: Modern, elegant design with smooth animations
- **Cross-Platform**: Works on Android, iOS, and Web

## 📱 Download

**Latest Release**: [Download APK](https://github.com/Kushwahaabhay/FOUNDIT/releases/latest)

## 🚀 Quick Setup

### Prerequisites
- Flutter SDK (3.0+)
- Firebase account
- Cloudinary account (free tier)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Kushwahaabhay/FOUNDIT.git
   cd FOUNDIT
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project at https://console.firebase.google.com
   - Enable Authentication (Google Sign-In) and Firestore Database
   - Run: `flutterfire configure --project=your-project-id`
   - This will generate `lib/firebase_options.dart` automatically

4. **Configure Cloudinary**
   - Create account at https://cloudinary.com
   - Create an unsigned upload preset named `foundit_preset`
   - Update your cloud name in `lib/src/services/storage_service.dart`:
   ```dart
   static const String _cloudName = 'your-cloud-name';
   ```

5. **Deploy Firestore Indexes**
   ```bash
   firebase deploy --only firestore:indexes
   ```

6. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase (Firestore, Authentication)  
- **Storage**: Cloudinary (Image hosting)
- **State Management**: Riverpod
- **UI**: Material Design 3 with Glassmorphism

## 📖 Usage

### For Students
1. **Sign in** with your college Google account
2. **Report Lost Item**: Create a post with details and photo
3. **Report Found Item**: Help others by posting found items
4. **Browse & Search**: Find your items using filters
5. **Contact**: Reach out to item owners directly

### For Administrators  
1. **Monitor Activity**: View all posts and users
2. **Manage Content**: Review and moderate posts
3. **User Management**: Handle accounts and permissions

## 🔧 Configuration Files

The following files contain sensitive information and are not included in the repository:

- `lib/firebase_options.dart` - Firebase configuration
- `android/app/google-services.json` - Android Firebase config
- `firebase.json` - Firebase project settings
- `firestore.indexes.json` - Database indexes

Use the setup instructions above to generate these files for your own Firebase project.

## 👥 Team

**College:** Galgotias College of Engineering & Technology (GCET)  
**Department:** Data Science, Semester III  
**Mentor:** Dr. Anju Chandna

**Team Members:**
- Kushwaha Abhaykumar Dharmendra — 2400971630037
- Hemant Kumar — 2400971630028
- Ayush Singhal — 2400971630016
- Gurav Sahani — 2400971630025

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit changes: `git commit -m 'Add feature'`
4. Push to branch: `git push origin feature-name`
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, email kushwahaabhay099@gmail.com or create an issue on GitHub.

---

**Made with ❤️ for GCET College Community**