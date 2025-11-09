# FOUNDIT - Setup Instructions

## 🚀 Quick Setup (15 minutes)

### Step 1: Clone Repository
```bash
git clone https://github.com/Kushwahaabhay/FOUNDIT.git
cd FOUNDIT
```

### Step 2: Install Dependencies
```bash
flutter pub get
```

### Step 3: Firebase Setup

1. Create Firebase project at https://console.firebase.google.com/
2. Add Android app with package: `com.gcet.foundit.foundit_app`
3. Download `google-services.json` → place in `android/app/`
4. Get your Firebase config values
5. Update `lib/firebase_options.dart` with your values
6. Enable Google Authentication
7. Create Firestore Database
8. Add SHA-1 certificate: Run `cd android && ./gradlew signingReport`

### Step 4: Cloudinary Setup

1. Sign up at https://cloudinary.com/
2. Get your cloud name from dashboard
3. Create upload preset (name: `foundit_preset`, mode: Unsigned)
4. Update `lib/src/services/storage_service.dart` with your cloud name

### Step 5: Configure App

Update `lib/src/core/constants.dart`:
```dart
static const String allowedEmailDomain = '@your-college-domain.edu';
```

### Step 6: Run App
```bash
flutter run
```

## 📚 Detailed Documentation

- **README.md** - Complete project documentation
- **CLOUDINARY_SETUP.md** - Cloudinary configuration
- **TROUBLESHOOTING.md** - Common issues & solutions
- **DEMO_SCRIPT.md** - Demo video guide

## 🎯 What to Configure

### Required:
1. ✅ `android/app/google-services.json` - From Firebase
2. ✅ `lib/firebase_options.dart` - Firebase config
3. ✅ `lib/src/services/storage_service.dart` - Cloudinary cloud name
4. ✅ `lib/src/core/constants.dart` - Email domain

### Optional:
5. ⏳ Download Poppins fonts (or use system default)

## 📞 Support

For issues, check:
- TROUBLESHOOTING.md
- README.md
- GitHub Issues

---

**Team:** GCET Data Science Semester III  
**Mentor:** Dr. Anju Chandna
