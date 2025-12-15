# FOUNDIT - Smart Campus Lost & Found System

<p align="center">
  <img src="assets/icons/app_icon.png" alt="FOUNDIT Logo" width="120" height="120">
</p>

<p align="center">
  <a href="https://foundit-gcet.web.app"><img src="https://img.shields.io/badge/🌐_Live_Demo-foundit--gcet.web.app-blue?style=for-the-badge" alt="Live Demo"></a>
  <a href="https://github.com/Kushwahaabhay/FOUNDIT/releases"><img src="https://img.shields.io/badge/📱_Download-APK-brightgreen?style=for-the-badge" alt="Download APK"></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black" alt="Firebase">
  <img src="https://img.shields.io/badge/Dart-0175C2?logo=dart" alt="Dart">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License">
</p>

---

## 📋 Overview

**FOUNDIT** is a modern, cross-platform mobile and web application designed to help GCET college students and staff report, track, and recover lost items on campus. Built with Flutter and Firebase, it provides a seamless experience for connecting people who have lost items with those who have found them.

### 🎯 Problem Statement

Every day, students lose valuable items on campus - ID cards, wallets, keys, electronics, and more. Traditional methods like notice boards and WhatsApp groups are inefficient and disorganized. FOUNDIT solves this by providing a centralized, searchable platform with real-time notifications.

---

## ✨ Features

### For Students
| Feature | Description |
|---------|-------------|
| 🔐 **Secure Login** | Google Sign-In with college email domain restriction |
| 📝 **Post Items** | Report lost or found items with photos and details |
| 🔍 **Smart Search** | Filter by category, location, and status |
| 📍 **Location Tags** | Predefined campus locations for easy identification |
| 📞 **Direct Contact** | WhatsApp and phone integration to contact finders |
| 👤 **Profile Management** | Edit roll number and phone number |

### For Administrators
| Feature | Description |
|---------|-------------|
| 📊 **Dashboard** | View statistics and manage all posts |
| 🗑️ **Moderation** | Delete inappropriate or resolved posts |
| ✅ **Status Updates** | Mark items as resolved |
| 📋 **Activity Logs** | Track admin actions |

### Technical Features
- 🎨 **Modern UI** - Glassmorphism design with smooth animations
- 🌙 **Dark Mode** - Full dark theme support
- 📱 **Cross-Platform** - Android, iOS, and Web
- 🔄 **Real-time Updates** - Instant feed refresh with Firestore
- 📸 **Image Optimization** - Compressed uploads via Cloudinary
- 🔒 **Secure** - Firebase security rules with input validation

---

## 📱 Screenshots

| Feed Screen | Post Item | Profile |
|:-----------:|:---------:|:-------:|
| Browse all lost/found items | Report with photo | View your posts |

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| **Frontend** | Flutter 3.0+, Dart |
| **State Management** | Riverpod |
| **Backend** | Firebase (Firestore, Auth) |
| **Image Storage** | Cloudinary |
| **Hosting** | Firebase Hosting |
| **Authentication** | Google Sign-In |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.0 or higher
- Dart SDK
- Firebase CLI
- A Firebase project
- A Cloudinary account (free tier)

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

3. **Create environment file**
   ```bash
   cp .env.example .env
   ```
   Then edit `.env` with your credentials (see [Environment Setup](#environment-setup))

4. **Configure Firebase**
   ```bash
   flutterfire configure --project=your-project-id
   ```

5. **Deploy Firestore rules and indexes**
   ```bash
   firebase deploy --only firestore
   ```

6. **Run the app**
   ```bash
   # For Android
   flutter run
   
   # For Web
   flutter run -d chrome --web-port=5000
   
   # For iOS
   flutter run -d ios
   ```

### Environment Setup

Create a `.env` file in the project root with:

```env
# Cloudinary
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_UPLOAD_PRESET=foundit_preset

# Google OAuth
GOOGLE_WEB_CLIENT_ID=your_client_id.apps.googleusercontent.com

# Firebase Web
FIREBASE_WEB_API_KEY=your_web_api_key
FIREBASE_WEB_APP_ID=your_web_app_id
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
FIREBASE_STORAGE_BUCKET=your_project.firebasestorage.app
FIREBASE_MESSAGING_SENDER_ID=your_sender_id

# Firebase Android
FIREBASE_ANDROID_API_KEY=your_android_api_key
FIREBASE_ANDROID_APP_ID=your_android_app_id
```

---

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
└── src/
    ├── core/                 # Constants, theme, utils, validators
    ├── models/               # Data models (User, Item)
    ├── providers/            # Riverpod providers
    ├── screens/              # UI screens
    │   ├── auth/             # Login, Register
    │   ├── feed/             # Main feed, Item card, Details
    │   ├── post/             # Create post
    │   ├── profile/          # User profile
    │   └── admin/            # Admin dashboard
    ├── services/             # Firebase, Auth, Storage services
    └── widgets/              # Reusable widgets
```

---

## 🔐 Security

- ✅ Email domain restriction (college emails only)
- ✅ Firestore security rules with owner-based access
- ✅ Input validation on client and server
- ✅ Admin actions logging
- ✅ Environment variables for sensitive data
- ✅ No hardcoded credentials in source code

---

## 🌐 Live Demo

**Web App:** [https://foundit-gcet.web.app](https://foundit-gcet.web.app)

**Note:** Sign-in is restricted to `@galgotiacollege.edu` email addresses.

---

## 📥 Download

**Android APK:** [Download Latest Release](https://github.com/Kushwahaabhay/FOUNDIT/releases/latest)

---

## 👥 Team

**Institution:** Galgotias College of Engineering & Technology (GCET)  
**Program:** B.Tech Data Science, Semester III  
**Subject:** Mini Project  
**Mentor:** Dr. Anju Chandna

| Name | Roll Number | Role |
|------|-------------|------|
| Kushwaha Abhaykumar Dharmendra | 2400971630037 | Team Lead
| Hemant Kumar | 2400971630028 
| Ayush Singhal | 2400971630016
| Gurav Sahani | 2400971630025
---

## 📄 Documentation

- [Quick Start Guide](QUICK_START.md)
- [Setup Instructions](SETUP_INSTRUCTIONS.md)
- [Deployment Guide](DEPLOYMENT_GUIDE.md)
- [Cloudinary Setup](CLOUDINARY_SETUP.md)
- [Troubleshooting](TROUBLESHOOTING.md)
- [Changelog](CHANGELOG.md)
- [Release Notes](RELEASE_NOTES.md)

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 📞 Contact

**Email:** kushwahaabhay099@gmail.com  
**GitHub:** [@Kushwahaabhay](https://github.com/Kushwahaabhay)

---

<p align="center">
  <b>Made with ❤️ for GCET College Community</b><br>
  <i>December 2025</i>
</p>