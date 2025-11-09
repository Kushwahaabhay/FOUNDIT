# FOUNDIT - Quick Start Guide

## ⚡ Get Running in 10 Minutes

### Step 1: Install Dependencies (2 min)
```bash
flutter pub get
```

### Step 2: Download Fonts (3 min)
1. Go to https://fonts.google.com/specimen/Poppins
2. Click "Download family"
3. Extract ZIP
4. Copy these files to `assets/fonts/`:
   - `Poppins-Regular.ttf`
   - `Poppins-Medium.ttf`
   - `Poppins-SemiBold.ttf`
   - `Poppins-Bold.ttf`

**OR** Skip fonts and use system default:
- Remove `fontFamily: 'Poppins'` from `lib/src/core/theme.dart`

### Step 3: Setup Firebase & Cloudinary (10 min)

#### Firebase (for Auth & Database):
1. Create Firebase project at https://console.firebase.google.com/
2. Add Android app: `com.gcet.foundit.foundit_app`
3. Download `google-services.json` → `android/app/`
4. Enable Authentication (Google)
5. Create Firestore Database (any region)
6. Add Firestore security rules
7. Get config values and fill `lib/firebase_options.dart`

#### Cloudinary (for Images):
1. Sign up at https://cloudinary.com/users/register/free
2. Get your **Cloud name** from dashboard
3. Create upload preset: `foundit_preset` (unsigned)
4. Update `lib/src/services/storage_service.dart` with cloud name

**See CLOUDINARY_SETUP.md for detailed steps**

### Step 4: Update Email Domain
Edit `lib/src/core/constants.dart`:
```dart
static const String allowedEmailDomain = '@galgotiasuniversity.edu.in';
```

### Step 5: Run App
```bash
flutter run
```

## 🎯 First Time Setup Checklist

- [ ] Dependencies installed (`flutter pub get`)
- [ ] Fonts downloaded (or removed from theme)
- [ ] Firebase project created
- [ ] `google-services.json` in `android/app/`
- [ ] Email domain updated in constants.dart
- [ ] App runs successfully
- [ ] Can sign in with college email
- [ ] Can create a test post
- [ ] Admin user added in Firestore

## 🔥 Firebase Quick Setup

### Enable Authentication
1. Firebase Console → Authentication
2. Sign-in method → Google → Enable
3. Add support email → Save

### Create Firestore
1. Firebase Console → Firestore Database
2. Create database → Test mode
3. Location: asia-south1 (Mumbai)
4. Enable

### Create Storage
1. Firebase Console → Storage
2. Get Started → Test mode
3. Done

### Add Security Rules
Copy from `README.md` → Firestore Rules and Storage Rules

## 👤 Add Admin User

After first sign-in:
1. Firebase Console → Firestore
2. `users` collection → Your user document
3. Add field: `isAdmin` = `true` (boolean)
4. Save

## 🧪 Test the App

### Test Authentication
1. Sign in with college email
2. Complete profile
3. Should see feed screen

### Test Posting
1. Tap FAB (+ button)
2. Toggle Lost/Found
3. Add title, category, location
4. Add description
5. Upload image (optional)
6. Post

### Test Admin
1. Add yourself as admin (see above)
2. Restart app
3. Tap admin icon in feed
4. Should see dashboard

## 🐛 Common Issues

### "google-services.json not found"
**Fix:** Ensure file is in `android/app/` directory

### "Package name mismatch"
**Fix:** Check `android/app/build.gradle` → `applicationId` matches Firebase

### "Firebase not initialized"
**Fix:** Ensure `FirebaseService.initialize()` is in `main()`

### Images not uploading
**Fix:** Check Firebase Storage rules, internet connection, file size

### Fonts not working
**Fix:** Ensure font files are in `assets/fonts/` and names match `pubspec.yaml`

## 📱 Build APK

### Debug (for testing)
```bash
flutter build apk --debug
```
Output: `build/app/outputs/flutter-apk/app-debug.apk`

### Release (for distribution)
```bash
flutter build apk --release
```

## 📚 Need More Help?

- **Full Setup:** See `SETUP_GUIDE.md`
- **Deployment:** See `DEPLOYMENT_GUIDE.md`
- **Features:** See `README.md`
- **Demo:** See `DEMO_SCRIPT.md`

## 🎬 Record Demo

1. Create 5-10 test posts
2. Follow `DEMO_SCRIPT.md`
3. Use screen recorder
4. Keep it under 2 minutes

## 📞 Team Contacts

**Team Lead:** Kushwaha Abhaykumar Dharmendra  
**Mentor:** Dr. Anju Chandna

## ✅ Ready to Present?

- [ ] App runs smoothly
- [ ] Test data created
- [ ] Demo video recorded
- [ ] Documentation reviewed
- [ ] Team members trained
- [ ] Presentation prepared

---

**You're all set! 🚀**

If you encounter any issues, check the detailed guides in the documentation folder.

Good luck with your project presentation!
