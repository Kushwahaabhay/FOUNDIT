# Troubleshooting Guide

## 🔧 Common Issues & Solutions

### Issue 1: "The query requires an index"

**When:** After login, feed screen shows error

**Solution:**
1. Click the link in the error message
2. Firebase Console opens
3. Click "Create Index"
4. Wait 2-5 minutes
5. Restart app

---

### Issue 2: "401 bad response" - Image Upload Fails

**When:** Trying to upload image in create post

**Cause:** Cloudinary upload preset not configured or not "Unsigned"

**Solution:**
1. Go to https://cloudinary.com/console
2. Login
3. Settings → Upload tab
4. Find "Upload presets"
5. Create new preset:
   - Name: `foundit_preset`
   - Signing Mode: **Unsigned** ⚠️
   - Folder: `foundit/items`
6. Save
7. Try upload again

**Verify:**
- Preset name is exactly: `foundit_preset`
- Signing mode is: **Unsigned** (not Signed!)
- Wait 1 minute after creating

---

### Issue 3: Google Sign-In Not Working

**Solution:**
1. Check SHA-1 is added to Firebase Console
2. Download new google-services.json
3. Replace in android/app/
4. Run: `flutter clean && flutter run`

---

### Issue 4: "Email domain not allowed"

**Solution:**
1. Open `lib/src/core/constants.dart`
2. Update line 12 with your actual college email domain
3. Save and restart app

---

### Issue 5: App Won't Build

**Solution:**
```bash
flutter clean
flutter pub get
flutter run -d V2334
```

---

## 📞 Quick Checks

### Cloudinary Setup:
- [ ] Account created
- [ ] Cloud name: `dwrhrtnzg`
- [ ] Upload preset: `foundit_preset`
- [ ] Preset is **Unsigned**
- [ ] Folder: `foundit/items`

### Firebase Setup:
- [ ] Google Authentication enabled
- [ ] Firestore database created
- [ ] Firestore index created
- [ ] SHA-1 added to Android app

### App Configuration:
- [ ] google-services.json in android/app/
- [ ] firebase_options.dart filled
- [ ] Email domain updated in constants.dart
- [ ] Cloudinary cloud name in storage_service.dart

---

## 🎯 Most Common Issue

**Cloudinary 401 Error** = Upload preset not "Unsigned"

Make sure:
1. Preset exists
2. Name is exactly: `foundit_preset`
3. Signing Mode is: **Unsigned**
4. Wait 1 minute after creating

---

**Still stuck?** Check README.md for complete documentation.
