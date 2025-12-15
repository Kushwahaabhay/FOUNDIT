# FOUNDIT - Quick Start Guide

Get the app running in under 10 minutes!

---

## ⚡ Express Setup

### 1️⃣ Clone & Install (2 min)

```bash
git clone https://github.com/Kushwahaabhay/FOUNDIT.git
cd FOUNDIT
flutter pub get
```

### 2️⃣ Create Environment File (1 min)

```bash
cp .env.example .env
```

### 3️⃣ Firebase Setup (5 min)

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create new project → `foundit-yourname`
3. Add Android app:
   - Package: `com.gcet.foundit.foundit_app`
   - Download `google-services.json` → `android/app/`
4. Add Web app → Copy config to `.env`
5. Enable Authentication → Google Sign-In
6. Create Firestore Database

### 4️⃣ Cloudinary Setup (2 min)

1. Go to [Cloudinary](https://cloudinary.com/) → Sign up
2. Copy Cloud Name from dashboard
3. Settings → Upload → Add preset:
   - Name: `foundit_preset`
   - Mode: **Unsigned**
4. Update `.env`:
   ```
   CLOUDINARY_CLOUD_NAME=your_cloud_name
   CLOUDINARY_UPLOAD_PRESET=foundit_preset
   ```

### 5️⃣ Run! 🚀

```bash
# Android
flutter run

# Web
flutter run -d chrome --web-port=5000
```

---

## ✅ Setup Checklist

| Step | Status |
|------|--------|
| Clone repository | ⬜ |
| Run `flutter pub get` | ⬜ |
| Create `.env` file | ⬜ |
| Firebase project created | ⬜ |
| `google-services.json` added | ⬜ |
| Google Auth enabled | ⬜ |
| Firestore created | ⬜ |
| Cloudinary account created | ⬜ |
| Upload preset created | ⬜ |
| `.env` values filled | ⬜ |
| App runs successfully | ⬜ |

---

## 👤 Make Yourself Admin

After signing in:

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Firestore Database → `users` collection
3. Click on your user document
4. Add field:
   - Field: `isAdmin`
   - Type: `boolean`
   - Value: `true`
5. Save

Now you'll see the Admin Dashboard in the app!

---

## 🧪 Quick Test

| Test | Expected Result |
|------|-----------------|
| Open app | Splash screen → Login |
| Sign in | Google popup → Feed screen |
| Create post | Fill form → Post appears in feed |
| View details | Tap card → Details with contact buttons |
| Admin dashboard | (If admin) See stats and all posts |

---

## 🆘 Common Issues

| Problem | Solution |
|---------|----------|
| `google-services.json` not found | Download from Firebase Console |
| Google Sign-In fails | Add SHA-1: `cd android && ./gradlew signingReport` |
| Image upload fails | Check Cloudinary preset is "Unsigned" |
| Permission denied | Run `firebase deploy --only firestore:rules` |

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for more.

---

## 📚 More Documentation

- [Full Setup Guide](SETUP_INSTRUCTIONS.md)
- [Cloudinary Setup](CLOUDINARY_SETUP.md)
- [Deployment Guide](DEPLOYMENT_GUIDE.md)
- [Troubleshooting](TROUBLESHOOTING.md)

---

**Ready? Let's go! 🚀**

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
