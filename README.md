# FOUNDIT - Smart Campus Lost & Found System

[![GitHub Release](https://img.shields.io/badge/Download-APK-brightgreen)](https://github.com/Kushwahaabhay/FOUNDIT/releases)
[![Version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/Kushwahaabhay/FOUNDIT)

**A polished Android app for GCET students to report and find lost items on campus.**

> ⚠️ **Note:** This repository contains template code. You'll need to configure Firebase and Cloudinary with your own credentials. See [SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md) for details.

## 📱 Project Overview

FOUNDIT is a campus-exclusive lost & found application built with Flutter, featuring:
- **Liquid Crystal / Glassmorphism UI** with smooth animations
- **College Email-Only Authentication** (restricted to GCET domain)
- **Infinite Scroll Feed** with lazy loading
- **Smart Contact System** (WhatsApp, Call, Email deep links)
- **Admin Dashboard** for moderation
- **Real-time Updates** with Firebase Firestore
- **Image Upload** with Firebase Storage
- **Search & Filters** by category, location, and status

## 👥 Team Members

**College:** Galgotias College of Engineering & Technology (GCET)  
**Semester:** III, Department: Data Science  
**Mentor:** Dr. Anju Chandna

**Team:**
- Kushwaha Abhaykumar Dharmendra — 2400971630037
- Hemant Kumar — 2400971630028
- Ayush Singhal — 2400971630016
- Gurav Sahani — 2400971630025

## 🚀 Features

### MVP Features (Implemented)
✅ **Authentication**
- College email-only signup (Google Sign-In with domain restriction)
- Profile completion (name, roll number, phone)
- Secure session management

✅ **Post Lost/Found Items**
- Toggle between Lost/Found status
- Category selection (ID Card, Wallet, Electronics, Keys, Books, Others)
- Location dropdown (predefined campus areas)
- Image upload from camera or gallery
- Rich text description

✅ **Feed Screen**
- Infinite scroll with pagination
- Pull-to-refresh
- Glass card UI with blur effects
- Filter by status (All/Lost/Found)
- Skeleton loaders

✅ **Item Details**
- Hero animation for images
- Full item information
- Contact buttons (WhatsApp, Call, Email)
- Mark as resolved (owner only)
- Edit/Delete (owner only)

✅ **Search & Filters**
- Keyword search in title/description
- Filter by category, location, date range
- Sort by newest

✅ **Admin Dashboard**
- View all posts
- Delete any post
- Mark posts as resolved
- View analytics

### Future Scope (Scaffolded)
🔄 **Smart Matching** - AI-powered suggestions for matching lost/found items  
🔄 **Push Notifications** - Real-time alerts for matches and messages  
🔄 **In-App Chat** - Direct messaging between users  
🔄 **Map Integration** - Visual location pinning  
🔄 **Image Recognition** - ML Kit for automatic categorization

## 🛠️ Tech Stack

- **Framework:** Flutter 3.35.6+ (Dart 3.9.2+)
- **Backend:** Firebase
  - Authentication (Google Sign-In)
  - Firestore (Database)
  - Storage (Images)
  - Cloud Functions (Optional)
  - Cloud Messaging (Push Notifications)
- **State Management:** Riverpod
- **UI:** Material Design 3 with custom glassmorphism theme

## 📦 Dependencies

| Package | Purpose |
|---------|---------|
| `firebase_core` | Firebase initialization |
| `firebase_auth` | User authentication |
| `cloud_firestore` | Real-time database |
| `firebase_storage` | Image storage |
| `firebase_messaging` | Push notifications |
| `google_sign_in` | College email verification |
| `flutter_riverpod` | State management |
| `cached_network_image` | Efficient image loading |
| `image_picker` | Camera/gallery access |
| `url_launcher` | WhatsApp/Call/Email links |
| `shimmer` | Skeleton loaders |
| `photo_view` | Image zoom |
| `connectivity_plus` | Offline detection |
| `flutter_local_notifications` | Local notifications |

## 🔧 Setup Instructions

### Prerequisites
- Flutter SDK 3.35.6 or higher
- Android Studio / VS Code with Flutter extensions
- Firebase account
- Git

### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd foundit_app
```

### Step 2: Install Dependencies
```bash
flutter pub get
```

### Step 3: Firebase Setup

#### 3.1 Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project" and name it "FOUNDIT-GCET"
3. Enable Google Analytics (optional)

#### 3.2 Add Android App
1. In Firebase Console, click "Add App" → Android
2. Register app with package name: `com.gcet.foundit.foundit_app`
3. Download `google-services.json`
4. Place it in `android/app/` directory

#### 3.3 Enable Firebase Services
1. **Authentication:**
   - Go to Authentication → Sign-in method
   - Enable "Google" provider
   - Add authorized domain: your-app-domain.com

2. **Firestore Database:**
   - Go to Firestore Database → Create database
   - Start in **test mode** (we'll add rules later)
   - Choose region closest to India (asia-south1)

3. **Storage:**
   - Go to Storage → Get Started
   - Start in **test mode**

4. **Cloud Messaging (Optional):**
   - Already enabled by default
   - Note the Server Key for later

#### 3.4 Configure Firebase in Flutter
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure --project=foundit-gcet
```

This will automatically generate `lib/firebase_options.dart`.

#### 3.5 Update Firestore Security Rules
In Firebase Console → Firestore Database → Rules, paste:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Helper function to check if user is authenticated
    function isSignedIn() {
      return request.auth != null;
    }
    
    // Helper function to check if user is admin
    function isAdmin() {
      return isSignedIn() && 
             get(/databases/$(database)/documents/users/$(request.auth.uid)).data.isAdmin == true;
    }
    
    // Helper function to check if user owns the document
    function isOwner(userId) {
      return isSignedIn() && request.auth.uid == userId;
    }
    
    // Users collection
    match /users/{userId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn() && request.auth.uid == userId;
      allow update: if isOwner(userId) || isAdmin();
      allow delete: if isAdmin();
    }
    
    // Items collection (Lost & Found posts)
    match /items/{itemId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn() && 
                      request.resource.data.postedByUid == request.auth.uid;
      allow update: if isOwner(resource.data.postedByUid) || isAdmin();
      allow delete: if isOwner(resource.data.postedByUid) || isAdmin();
    }
    
    // Admin actions log
    match /adminActions/{actionId} {
      allow read: if isAdmin();
      allow write: if isAdmin();
    }
    
    // Notifications
    match /notifications/{notificationId} {
      allow read: if isSignedIn() && 
                    resource.data.userId == request.auth.uid;
      allow write: if isSignedIn();
    }
  }
}
```

#### 3.6 Update Storage Security Rules
In Firebase Console → Storage → Rules:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /items/{itemId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
                     request.resource.size < 5 * 1024 * 1024 && // 5MB limit
                     request.resource.contentType.matches('image/.*');
    }
  }
}
```

### Step 4: Configure Email Domain Restriction

Edit `lib/src/core/constants.dart` and set your college email domain:

```dart
static const String allowedEmailDomain = '@galgotiasuniversity.edu.in';
```

### Step 5: Add Admin User

After first user signs up:
1. Go to Firebase Console → Firestore Database
2. Find the user document in `users` collection
3. Add field: `isAdmin: true` (boolean)

Or use this script after running the app once:
```bash
# In Firebase Console → Firestore → users → [user-id]
# Manually add: isAdmin = true
```

### Step 6: Run the App

#### On Emulator
```bash
flutter run
```

#### On Physical Device
1. Enable Developer Options on Android device
2. Enable USB Debugging
3. Connect device via USB
4. Run: `flutter run`

## 🏗️ Project Structure

```
foundit_app/
├── lib/
│   ├── main.dart                          # App entry point
│   └── src/
│       ├── core/
│       │   ├── constants.dart             # App constants & config
│       │   ├── theme.dart                 # Glassmorphism theme
│       │   ├── utils.dart                 # Helper functions
│       │   └── validators.dart            # Input validators
│       ├── services/
│       │   ├── firebase_service.dart      # Firebase initialization
│       │   ├── auth_service.dart          # Authentication logic
│       │   ├── storage_service.dart       # Image upload/download
│       │   ├── notification_service.dart  # Push notifications
│       │   └── matching_service.dart      # Smart matching (future)
│       ├── models/
│       │   ├── user_model.dart            # User data model
│       │   ├── item_model.dart            # Lost/Found item model
│       │   └── message_model.dart         # Chat messages (future)
│       ├── providers/
│       │   ├── auth_provider.dart         # Auth state management
│       │   ├── feed_provider.dart         # Feed data & pagination
│       │   ├── post_provider.dart         # Post creation/editing
│       │   └── admin_provider.dart        # Admin operations
│       ├── screens/
│       │   ├── splash_screen.dart         # Splash with animation
│       │   ├── auth/
│       │   │   ├── login_screen.dart      # Google Sign-In
│       │   │   └── register_profile.dart  # Profile completion
│       │   ├── feed/
│       │   │   ├── feed_screen.dart       # Main feed with tabs
│       │   │   ├── item_card.dart         # Glass card widget
│       │   │   └── item_details_screen.dart
│       │   ├── post/
│       │   │   └── create_post_screen.dart
│       │   ├── admin/
│       │   │   ├── admin_dashboard_screen.dart
│       │   │   └── manage_posts_screen.dart
│       │   ├── profile/
│       │   │   └── profile_screen.dart
│       │   └── settings/
│       │       └── settings_screen.dart
│       ├── widgets/
│       │   ├── glass_card.dart            # Glassmorphism card
│       │   ├── custom_buttons.dart        # Themed buttons
│       │   ├── category_chip.dart         # Category selector
│       │   └── skeleton_feed.dart         # Loading placeholder
│       └── routes/
│           └── app_router.dart            # Navigation setup
├── assets/
│   ├── images/                            # App images
│   ├── icons/                             # Custom icons
│   └── fonts/                             # Poppins font files
├── test/                                  # Unit & widget tests
├── android/                               # Android-specific config
├── .env.example                           # Environment variables template
└── README.md                              # This file
```

## 🎨 UI Design Guidelines

### Glassmorphism Theme
- **Background:** Gradient with subtle animation
- **Cards:** Frosted glass effect with `BackdropFilter`
- **Blur:** 10-20px sigma
- **Border Radius:** 18-24px
- **Shadows:** Soft, low elevation
- **Colors:** Calm blues/teals with transparency

### Typography
- **Primary Font:** Poppins
- **Headings:** Poppins SemiBold/Bold
- **Body:** Poppins Regular/Medium

### Animations
- Hero transitions for images
- Card reveal animations
- Skeleton loaders
- Pull-to-refresh indicator

## 📱 Building for Release

### Debug APK (for testing)
```bash
flutter build apk --debug
```
Output: `build/app/outputs/flutter-apk/app-debug.apk`

### Release APK (unsigned)
```bash
flutter build apk --release
```

### Signed Release APK (for Play Store)

#### 1. Generate Keystore
```bash
keytool -genkey -v -keystore foundit-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias foundit
```

#### 2. Create `android/key.properties`
```properties
storePassword=<your-store-password>
keyPassword=<your-key-password>
keyAlias=foundit
storeFile=../foundit-release-key.jks
```

#### 3. Update `android/app/build.gradle`
Add before `android` block:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

Inside `android` block, add:
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
    }
}
```

#### 4. Build Signed APK/AAB
```bash
# APK
flutter build apk --release

# AAB (for Play Store)
flutter build appbundle --release
```

## 🧪 Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Test
```bash
flutter test test/services/auth_service_test.dart
```

### Generate Test Coverage
```bash
flutter test --coverage
```

## 🎬 Demo Script (2-minute video)

### Scene 1: Splash & Login (20 seconds)
- Show splash screen with glassmorphism effect
- Tap "Sign in with Google"
- Select college email account
- Complete profile (name, roll number, phone)

### Scene 2: Browse Feed (30 seconds)
- Show infinite scroll feed with glass cards
- Toggle between All/Lost/Found tabs
- Pull to refresh
- Tap on a Lost item card

### Scene 3: Item Details & Contact (30 seconds)
- Hero animation to full image
- Show item details (category, location, description)
- Tap WhatsApp button → opens WhatsApp
- Tap Call button → opens dialer
- Back to feed

### Scene 4: Post New Item (30 seconds)
- Tap FAB (Floating Action Button)
- Toggle to "Found"
- Fill title: "Blue Wallet"
- Select category: "Wallet"
- Select location: "Library - 2nd Floor"
- Add description
- Upload image from gallery
- Tap "Post" → success message

### Scene 5: Admin Dashboard (10 seconds)
- Navigate to admin panel
- Show post count analytics
- Delete a spam post
- Mark item as resolved

## 📊 Firestore Schema

### Collection: `users`
```json
{
  "uid": "string",
  "name": "string",
  "rollNo": "string",
  "email": "string",
  "phone": "string (optional)",
  "isAdmin": "boolean",
  "createdAt": "timestamp"
}
```

### Collection: `items`
```json
{
  "itemId": "string",
  "title": "string",
  "description": "string",
  "category": "string (ID Card|Wallet|Electronics|Keys|Books|Others)",
  "status": "string (lost|found|resolved)",
  "location": "string",
  "imageUrl": "string",
  "postedByUid": "string",
  "contactPhone": "string",
  "contactEmail": "string",
  "createdAt": "timestamp",
  "lastUpdated": "timestamp",
  "possibleMatches": "array<string> (future)"
}
```

### Collection: `adminActions`
```json
{
  "actionId": "string",
  "adminUid": "string",
  "action": "string (delete|resolve|flag)",
  "itemId": "string",
  "timestamp": "timestamp"
}
```

## 🔐 Security & Privacy

- ✅ College email domain restriction enforced
- ✅ Firestore security rules prevent unauthorized access
- ✅ Phone numbers only visible to authenticated users
- ✅ Image uploads limited to 5MB
- ✅ No API keys in repository (use environment variables)
- ✅ Admin privileges checked server-side

## 🚀 Play Store Submission Checklist

- [ ] Update `android/app/build.gradle` with correct version code
- [ ] Create app icon (1024x1024 PNG)
- [ ] Create feature graphic (1024x500 PNG)
- [ ] Write app description (short & full)
- [ ] Add screenshots (at least 2, max 8)
- [ ] Set content rating (PEGI 3 / Everyone)
- [ ] Add privacy policy URL
- [ ] Build signed AAB: `flutter build appbundle --release`
- [ ] Upload to Play Console
- [ ] Submit for review

## 📝 Project Features Summary (for Synopsis)

**FOUNDIT** is a campus-exclusive mobile application designed to streamline the lost and found process at Galgotias College of Engineering & Technology. The app features a modern glassmorphism UI with smooth animations, providing an intuitive user experience. Key features include:

- **Secure Authentication:** College email-only access ensures campus-wide security
- **Real-time Feed:** Infinite scroll feed with lazy loading for optimal performance
- **Smart Categorization:** Predefined categories and campus locations for easy filtering
- **Multi-channel Contact:** Integrated WhatsApp, phone, and email communication
- **Admin Moderation:** Dedicated dashboard for content management and analytics
- **Offline Support:** Cached data ensures functionality without internet
- **Privacy-First:** Masked contact information with user consent mechanisms

**Future Enhancements:** AI-powered smart matching using ML Kit for image recognition, in-app chat system, push notifications for real-time alerts, and interactive campus map integration.

## 🐛 Troubleshooting

### Issue: "google-services.json not found"
**Solution:** Download from Firebase Console and place in `android/app/`

### Issue: "Execution failed for task ':app:processDebugGoogleServices'"
**Solution:** Ensure package name matches in `google-services.json` and `build.gradle`

### Issue: "MissingPluginException"
**Solution:** Run `flutter clean && flutter pub get` and restart app

### Issue: "Firebase Auth domain not authorized"
**Solution:** Add your domain in Firebase Console → Authentication → Settings → Authorized domains

### Issue: Images not loading
**Solution:** Check Firebase Storage rules and ensure URLs are public-readable

## 📞 Support & Contact

For issues or questions:
- **Team Lead:** Kushwaha Abhaykumar Dharmendra
- **Mentor:** Dr. Anju Chandna
- **College:** Galgotias College of Engineering & Technology

## 📄 License

This project is developed as an academic project for GCET and is not licensed for commercial use.

## 🙏 Acknowledgments

- Dr. Anju Chandna (Project Mentor)
- GCET Department of Data Science
- Flutter & Firebase communities

---

**Built with ❤️ by Team FOUNDIT**  
*Semester III, Data Science, GCET*
