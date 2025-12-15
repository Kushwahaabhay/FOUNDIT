# FOUNDIT Deployment Guide

Complete guide for deploying FOUNDIT to Web, Android, and iOS.

---

## 🌐 Web Deployment (Firebase Hosting)

### Quick Deploy

```bash
# Build web app
flutter build web --release

# Deploy to Firebase
firebase deploy --only hosting
```

Your app will be live at: `https://your-project.web.app`

### Detailed Steps

1. **Install Firebase CLI**
   ```bash
   npm install -g firebase-tools
   firebase login
   ```

2. **Initialize Hosting**
   ```bash
   firebase init hosting
   ```
   - Select your project
   - Public directory: `build/web`
   - Single-page app: Yes
   - Don't overwrite index.html

3. **Build & Deploy**
   ```bash
   flutter build web --release
   firebase deploy --only hosting
   ```

### Configure OAuth for Production

Add these domains in [Google Cloud Console](https://console.cloud.google.com/apis/credentials):

**Authorized JavaScript origins:**
- `https://your-project.web.app`
- `https://your-project.firebaseapp.com`

**Authorized redirect URIs:**
- `https://your-project.web.app`
- `https://your-project.firebaseapp.com`

---

## 📱 Android Deployment

### 1. Create Release Keystore

```bash
keytool -genkey -v -keystore foundit-release-key.jks -keyalias foundit -keyalg RSA -keysize 2048 -validity 10000
```

⚠️ **Save the passwords securely!**

### 2. Configure Signing

Create `android/key.properties`:
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=foundit
storeFile=../foundit-release-key.jks
```

### 3. Update build.gradle

Edit `android/app/build.gradle.kts`:

```kotlin
// Add at top
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    // Add signing config
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }
    
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
        }
    }
}
```

### 4. Build Release APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### 5. Build App Bundle (Play Store)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

---

## 🍎 iOS Deployment

### Requirements
- Mac with Xcode installed
- Apple Developer Account ($99/year)

### Build

```bash
flutter build ios --release
```

Then open Xcode:
```bash
open ios/Runner.xcworkspace
```

### Archive & Upload
1. Product → Archive
2. Distribute App → App Store Connect
3. Upload

---

## 📦 Release Checklist

### Before Release

- [ ] Update version in `pubspec.yaml`
- [ ] Test on multiple devices
- [ ] Check all features work
- [ ] Review Firestore security rules
- [ ] Update `.env` with production values
- [ ] Remove debug prints

### Version Naming

```yaml
version: 1.0.2+3
#        ^   ^ ^
#        |   | Build number (internal)
#        |   Patch version
#        Major.Minor
```

---

## 🔒 Security Checklist

- [ ] Domain restriction enabled
- [ ] Firestore rules deployed
- [ ] `.env` not committed to Git
- [ ] API keys restricted in Google Cloud
- [ ] SHA-1 added for release keystore

---

## 📊 Post-Deployment Monitoring

### Firebase Console
- Check Authentication users
- Monitor Firestore reads/writes
- Review security rule evaluations

### Google Play Console (Android)
- Monitor crash reports (Android Vitals)
- Check ANR rate
- Review user ratings

### Firebase Hosting
- View traffic analytics
- Check response times

---

## 🚀 Live URLs

| Platform | URL |
|----------|-----|
| **Web** | https://foundit-gcet.web.app |
| **Firebase Console** | https://console.firebase.google.com/project/foundit-gcet |

---

## 📞 Support

For deployment issues, contact:
- **Email:** kushwahaabhay099@gmail.com
- **GitHub:** [Create Issue](https://github.com/Kushwahaabhay/FOUNDIT/issues)
  • Post lost or found items with photos
  • Search campus-wide for your belongings
  • Contact item owners via WhatsApp, call, or email
  • Filter by category and location
  • Real-time updates
  • Secure college email-only access
  • Beautiful glassmorphism UI

  📱 HOW IT WORKS:
  1. Sign in with your GCET email
  2. Browse lost & found items
  3. Post items you've lost or found
  4. Contact owners directly
  5. Mark items as resolved when returned

  🔒 SECURITY & PRIVACY:
  • Only GCET students can access
  • Contact information protected
  • Admin moderation
  • Secure Firebase backend

  🎯 CATEGORIES:
  ID Cards, Wallets, Electronics, Keys, Books, Bags, Clothing, Accessories, Documents, and more.

  📍 CAMPUS LOCATIONS:
  Library, Blocks A/B/C, Cafeteria, Auditorium, Sports Complex, Labs, and more.

  Made with ❤️ by GCET students for GCET students.
  ```

#### Graphics
- **App icon:** 512x512 PNG (create in Canva/Figma)
- **Feature graphic:** 1024x500 PNG
- **Screenshots:** At least 2, max 8 (1080x1920 or 1080x2340)
  - Feed screen
  - Item details
  - Post creation
  - Profile screen
  - Admin dashboard

#### Categorization
- **App category:** Productivity
- **Tags:** lost and found, campus, student, college

#### Contact Details
- **Email:** your-team-email@example.com
- **Website:** (optional)
- **Privacy policy URL:** (required - create simple page)

### 4. Content Rating
1. Complete questionnaire
2. Select "No" for violence, mature content, etc.
3. Should get "Everyone" rating

### 5. App Content
- **Privacy policy:** Required (create simple page)
- **Ads:** No
- **In-app purchases:** No
- **Target audience:** Ages 13+

### 6. Release
1. Upload AAB file
2. Create release notes:
   ```
   Initial release of FOUNDIT v1.0.0
   
   Features:
   - Post lost & found items
   - Search and filter
   - Contact owners
   - Admin moderation
   - Secure authentication
   ```
3. Review and publish

## Privacy Policy Template

Create a simple HTML page:

```html
<!DOCTYPE html>
<html>
<head>
    <title>FOUNDIT Privacy Policy</title>
</head>
<body>
    <h1>Privacy Policy for FOUNDIT</h1>
    <p>Last updated: [Date]</p>
    
    <h2>Information We Collect</h2>
    <p>We collect:</p>
    <ul>
        <li>Name, email, roll number (from college account)</li>
        <li>Optional phone number</li>
        <li>Posted items (title, description, images, location)</li>
    </ul>
    
    <h2>How We Use Information</h2>
    <p>We use your information to:</p>
    <ul>
        <li>Provide lost & found services</li>
        <li>Enable communication between users</li>
        <li>Moderate content</li>
    </ul>
    
    <h2>Data Security</h2>
    <p>We use Firebase for secure data storage. Only GCET students can access the app.</p>
    
    <h2>Contact</h2>
    <p>Email: [your-email]</p>
</body>
</html>
```

Host on GitHub Pages or Firebase Hosting.

## Testing Before Release

### Internal Testing
1. Upload AAB to Play Console
2. Create internal testing track
3. Add team members as testers
4. Test for 1-2 weeks

### Closed Testing (Beta)
1. Create closed testing track
2. Invite 20-50 students
3. Collect feedback
4. Fix bugs

### Production Release
1. Promote from testing to production
2. Gradual rollout (10% → 50% → 100%)
3. Monitor crash reports
4. Respond to user reviews

## Post-Launch Checklist

- [ ] Monitor Firebase usage
- [ ] Check crash reports daily
- [ ] Respond to user reviews
- [ ] Track download numbers
- [ ] Collect user feedback
- [ ] Plan updates

## Maintenance

### Regular Updates
- Bug fixes: Every 2 weeks
- Feature updates: Every month
- Security patches: As needed

### Monitoring
- Firebase Console: Daily
- Play Console: Daily
- User reviews: Daily
- Crash reports: Daily

## Support

For deployment issues:
- Team Lead: Kushwaha Abhaykumar Dharmendra
- Mentor: Dr. Anju Chandna
