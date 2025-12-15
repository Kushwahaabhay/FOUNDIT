# FOUNDIT - Complete Setup Instructions

A step-by-step guide to set up and run the FOUNDIT app locally.

---

## 📋 Prerequisites

Before you begin, ensure you have:

| Requirement | Version | Check Command |
|-------------|---------|---------------|
| Flutter SDK | 3.0+ | `flutter --version` |
| Dart SDK | 3.0+ | `dart --version` |
| Firebase CLI | Latest | `firebase --version` |
| Git | Any | `git --version` |
| Android Studio / VS Code | Latest | - |

---

## 🚀 Quick Setup (15-20 minutes)

### Step 1: Clone Repository

```bash
git clone https://github.com/Kushwahaabhay/FOUNDIT.git
cd FOUNDIT
```

### Step 2: Install Dependencies

```bash
flutter pub get
```

### Step 3: Create Environment File

```bash
# Copy the example file
cp .env.example .env
```

Edit `.env` with your actual credentials (see Step 4-6).

### Step 4: Firebase Setup

1. **Create Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Click "Add Project" → Name it (e.g., `foundit-yourname`)
   - Disable Google Analytics (optional)
   - Click "Create Project"

2. **Add Android App**
   - Click Android icon
   - Package name: `com.gcet.foundit.foundit_app`
   - App nickname: `FOUNDIT Android`
   - Get SHA-1: Run in terminal:
     ```bash
     cd android
     ./gradlew signingReport
     ```
   - Copy the SHA-1 from `Variant: debug` → paste in Firebase
   - Download `google-services.json` → place in `android/app/`

3. **Add Web App**
   - Click Web icon (</>)
   - Name: `FOUNDIT Web`
   - Copy the config values to your `.env` file

4. **Enable Authentication**
   - Go to Authentication → Sign-in method
   - Enable "Google" provider
   - Add your Web client ID

5. **Create Firestore Database**
   - Go to Firestore Database
   - Click "Create database"
   - Select "Start in production mode"
   - Choose region (asia-south1 for India)

6. **Deploy Security Rules**
   ```bash
   firebase login
   firebase use --add  # Select your project
   firebase deploy --only firestore:rules
   ```

### Step 5: Cloudinary Setup

1. **Create Account**
   - Go to [Cloudinary](https://cloudinary.com/)
   - Sign up for free

2. **Get Cloud Name**
   - Go to Dashboard
   - Copy your "Cloud Name"

3. **Create Upload Preset**
   - Go to Settings → Upload
   - Scroll to "Upload presets"
   - Click "Add upload preset"
   - Name: `foundit_preset`
   - Signing Mode: **Unsigned**
   - Click Save

4. **Update .env**
   ```env
   CLOUDINARY_CLOUD_NAME=your_cloud_name
   CLOUDINARY_UPLOAD_PRESET=foundit_preset
   ```

### Step 6: Google OAuth Setup

1. **Go to Google Cloud Console**
   - Visit [Google Cloud Console](https://console.cloud.google.com/)
   - Select your Firebase project

2. **Configure OAuth Consent Screen**
   - Go to APIs & Services → OAuth consent screen
   - User Type: External
   - Fill in app name and email
   - Add scopes: `email`, `profile`
   - Save

3. **Get Web Client ID**
   - Go to APIs & Services → Credentials
   - Find "Web client (auto created by Google Service)"
   - Copy the Client ID

4. **Update .env**
   ```env
   GOOGLE_WEB_CLIENT_ID=your_client_id.apps.googleusercontent.com
   ```

5. **Add Authorized Origins** (for web)
   - Click on the Web client
   - Add to "Authorized JavaScript origins":
     - `http://localhost:5000`
     - `https://your-project.web.app`

### Step 7: Run the App

```bash
# Android
flutter run

# Web (Chrome)
flutter run -d chrome --web-port=5000

# Web (Edge)
flutter run -d edge --web-port=5000

# iOS (Mac only)
flutter run -d ios
```

---

## 📁 Files to Configure

| File | Purpose | Required |
|------|---------|----------|
| `.env` | API keys and secrets | ✅ Yes |
| `android/app/google-services.json` | Android Firebase config | ✅ Yes (Android) |
| `lib/src/core/constants.dart` | College email domain | ✅ Yes |

---

## 🔧 Configuration Reference

### .env File Template

```env
# Cloudinary
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_UPLOAD_PRESET=foundit_preset

# Google OAuth
GOOGLE_WEB_CLIENT_ID=xxxx.apps.googleusercontent.com

# Firebase Web
FIREBASE_WEB_API_KEY=AIzaSy...
FIREBASE_WEB_APP_ID=1:xxxx:web:xxxx
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
FIREBASE_STORAGE_BUCKET=your-project.firebasestorage.app
FIREBASE_MESSAGING_SENDER_ID=xxxx

# Firebase Android
FIREBASE_ANDROID_API_KEY=AIzaSy...
FIREBASE_ANDROID_APP_ID=1:xxxx:android:xxxx
```

### College Domain

Edit `lib/src/core/constants.dart`:
```dart
static const String allowedEmailDomain = '@your-college.edu';
```

---

## 🌐 Deploy to Firebase Hosting

```bash
# Build web app
flutter build web --release

# Deploy
firebase deploy --only hosting
```

Your app will be live at: `https://your-project.web.app`

---

## 🐛 Troubleshooting

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues.

### Quick Fixes

| Issue | Solution |
|-------|----------|
| `google-services.json` not found | Download from Firebase Console |
| Google Sign-In error 10 | Add SHA-1 to Firebase |
| Permission denied (Firestore) | Deploy security rules |
| Image upload fails | Check Cloudinary preset is "Unsigned" |

---

## 📞 Support

- **GitHub Issues:** [Create Issue](https://github.com/Kushwahaabhay/FOUNDIT/issues)
- **Email:** kushwahaabhay099@gmail.com

---

**Made by GCET Data Science Team**
