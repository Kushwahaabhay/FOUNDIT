# FOUNDIT - Troubleshooting Guide

Solutions to common issues you may encounter.

---

## 🔑 Authentication Issues

### Google Sign-In Error Code 10

**Symptoms:** Sign-in fails with error code 10 on Android

**Cause:** SHA-1 fingerprint not added to Firebase

**Solution:**
1. Get SHA-1:
   ```bash
   cd android
   ./gradlew signingReport
   ```
2. Copy SHA-1 from `Variant: debug`
3. Go to Firebase Console → Project Settings → Your apps → Android
4. Click "Add fingerprint" → Paste SHA-1
5. Download new `google-services.json` → Replace in `android/app/`
6. Restart app:
   ```bash
   flutter clean && flutter run
   ```

---

### "Sign-in cancelled by user"

**Cause:** User closed the Google sign-in popup

**Solution:** Try signing in again and complete the flow

---

### "Only GCET emails allowed"

**Cause:** Trying to sign in with non-college email

**Solution:** Use your `@galgotiacollege.edu` email address

---

## 📸 Image Upload Issues

### "401 Bad Response" - Upload Fails

**Cause:** Cloudinary upload preset not configured correctly

**Solution:**
1. Go to [Cloudinary Console](https://console.cloudinary.com/)
2. Settings → Upload → Upload presets
3. Check preset `foundit_preset`:
   - **Signing Mode: Unsigned** ⚠️ (MUST be Unsigned)
   - Folder: `foundit/items` (optional)
4. If preset doesn't exist, create it with above settings
5. Wait 1-2 minutes, then try again

---

### Image Not Appearing After Upload

**Cause:** Network delay or caching

**Solution:** Pull-to-refresh on the feed

---

## 🔥 Firebase Issues

### "The query requires an index"

**Solution:**
1. Click the link in the error message
2. Firebase Console opens automatically
3. Click "Create Index"
4. Wait 2-5 minutes for index to build
5. Restart app

---

### "Permission Denied" (Firestore)

**Cause:** Security rules not deployed

**Solution:**
```bash
firebase deploy --only firestore:rules
```

---

### "Firebase App not initialized"

**Cause:** Missing Firebase configuration

**Solution:**
1. Check `.env` file has all Firebase values
2. Check `google-services.json` exists in `android/app/`
3. Run:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

---

## 🌐 Web Issues

### Google Sign-In popup blocked

**Cause:** Browser blocking popups

**Solution:** Allow popups for localhost or the hosted URL

---

### CORS Error

**Cause:** OAuth origins not configured

**Solution:**
1. Go to [Google Cloud Console](https://console.cloud.google.com/apis/credentials)
2. Edit Web OAuth client
3. Add to Authorized JavaScript origins:
   - `http://localhost:5000`
   - `https://your-project.web.app`

---

## 📱 Android Issues

### App Won't Build

**Solution:**
```bash
flutter clean
flutter pub get
cd android && ./gradlew clean && cd ..
flutter run
```

---

### WhatsApp/Phone Buttons Not Working

**Cause:** Missing queries in AndroidManifest.xml

**Solution:** Ensure `android/app/src/main/AndroidManifest.xml` has:
```xml
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW"/>
        <data android:scheme="https"/>
    </intent>
    <package android:name="com.whatsapp"/>
</queries>
```

---

## ⚙️ Environment Issues

### ".env file not found"

**Solution:**
1. Create `.env` file in project root
2. Copy contents from `.env.example`
3. Fill in your actual values

---

### "dotenv not loading"

**Cause:** `.env` not listed in assets

**Solution:** Check `pubspec.yaml` has:
```yaml
flutter:
  assets:
    - .env
```

---

## 🔄 Quick Fixes

| Problem | Quick Fix |
|---------|-----------|
| Any build error | `flutter clean && flutter pub get` |
| Signing error | Re-download `google-services.json` |
| Web not working | Check OAuth domains |
| Image upload fails | Check Cloudinary preset is "Unsigned" |
| Permission denied | `firebase deploy --only firestore:rules` |

---

## ✅ Verification Checklist

### Firebase
- [ ] Project created
- [ ] Android app added with correct package name
- [ ] SHA-1 fingerprint added
- [ ] `google-services.json` in `android/app/`
- [ ] Google Authentication enabled
- [ ] Firestore database created
- [ ] Security rules deployed

### Cloudinary
- [ ] Account created
- [ ] Cloud name added to `.env`
- [ ] Upload preset `foundit_preset` exists
- [ ] Preset signing mode is **Unsigned**

### Environment
- [ ] `.env` file exists
- [ ] All values filled in
- [ ] `.env` listed in `pubspec.yaml` assets

---

## 📞 Still Having Issues?

1. Check the error message carefully
2. Search in [GitHub Issues](https://github.com/Kushwahaabhay/FOUNDIT/issues)
3. Create a new issue with:
   - Error message/screenshot
   - Steps to reproduce
   - Flutter version (`flutter --version`)

**Email:** kushwahaabhay099@gmail.com
1. Preset exists
2. Name is exactly: `foundit_preset`
3. Signing Mode is: **Unsigned**
4. Wait 1 minute after creating

---

**Still stuck?** Check README.md for complete documentation.
