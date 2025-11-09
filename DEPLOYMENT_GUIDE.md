# FOUNDIT Deployment Guide

## Building for Production

### 1. Prepare Release Build

#### Update Version
Edit `pubspec.yaml`:
```yaml
version: 1.0.0+1  # version+buildNumber
```

#### Create Keystore
```bash
keytool -genkey -v -keystore foundit-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias foundit
```

**Save the passwords securely!**

#### Configure Signing
Create `android/key.properties`:
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=foundit
storeFile=../foundit-release-key.jks
```

Add to `android/app/build.gradle` (before `android` block):
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

Inside `android` block:
```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}
buildTypes {
    release {
        signingConfig signingConfigs.release
        minifyEnabled true
        shrinkResources true
    }
}
```

### 2. Build Release APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### 3. Build App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

## Google Play Store Submission

### 1. Create Play Console Account
- Go to [Google Play Console](https://play.google.com/console)
- Pay one-time $25 registration fee
- Complete account setup

### 2. Create App
1. Click "Create app"
2. Fill in details:
   - **App name:** FOUNDIT
   - **Default language:** English (United States)
   - **App or game:** App
   - **Free or paid:** Free

### 3. Store Listing

#### App Details
- **Short description:** (80 chars)
  ```
  Smart campus lost & found system for GCET students. Find your lost items fast!
  ```

- **Full description:** (4000 chars)
  ```
  FOUNDIT is a secure, campus-exclusive lost and found application designed specifically for students of Galgotias College of Engineering & Technology (GCET).

  🔍 KEY FEATURES:
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
