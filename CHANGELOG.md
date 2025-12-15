# Changelog

All notable changes to the FOUNDIT project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [1.0.2] - 2024-12-16

### Added
- ✅ **Poster Name Display** - Item cards now show "Posted by [FirstName]"
- ✅ **Custom App Icon** - Replaced Flutter logo with FOUNDIT branding
- ✅ **Environment Variables** - Sensitive keys moved to `.env` file
- ✅ **Enhanced Security Rules** - Server-side validation in Firestore rules
- ✅ **Firebase Hosting** - Web app deployed at https://foundit-gcet.web.app

### Changed
- ✅ Improved spacing between item cards in feed
- ✅ Updated profile edit to modify roll number and phone only
- ✅ Sign-out now properly redirects to login screen
- ✅ Removed profile completion screen - direct to feed after login

### Fixed
- ✅ Fixed Google Sign-In OAuth client ID for web
- ✅ Fixed WhatsApp button not working on Android
- ✅ Fixed Firestore permission denied errors
- ✅ Fixed user name not appearing on posts

### Security
- ✅ Enabled college email domain restriction
- ✅ Added input validation in Firestore rules
- ✅ Environment variables for all API keys

---

## [1.0.1] - 2024-12-10

### Added
- ✅ Cloudinary integration for image uploads (replaced Firebase Storage)
- ✅ Admin dashboard with post moderation
- ✅ Edit profile functionality

### Changed
- ✅ Migrated from Firebase Storage to Cloudinary (free tier)
- ✅ Improved image compression

### Fixed
- ✅ Fixed XFile/File type mismatch for web compatibility

---

## [1.0.0] - 2024-11-09

### Week 1-2: Project Setup & Foundation
- ✅ Initialized Flutter project with null-safety
- ✅ Setup Firebase (Auth, Firestore)
- ✅ Implemented glassmorphism theme with light/dark mode
- ✅ Created core utilities and validators
- ✅ Setup Riverpod state management
- ✅ Designed app architecture and folder structure

### Week 3-5: Core Features
- ✅ Implemented Google Sign-In with college email restriction
- ✅ Created profile completion flow
- ✅ Built infinite scroll feed with pagination
- ✅ Implemented item cards with glass effect
- ✅ Added image upload functionality
- ✅ Created post creation screen with category/location dropdowns
- ✅ Implemented item details screen with hero animations
- ✅ Added contact buttons (WhatsApp, Call, Email)

### Week 6-8: Advanced Features & Polish
- ✅ Built admin dashboard with statistics
- ✅ Implemented admin moderation (delete, resolve posts)
- ✅ Added search and filter functionality
- ✅ Created user profile screen
- ✅ Implemented mark as resolved feature
- ✅ Added pull-to-refresh on feed
- ✅ Implemented skeleton loaders
- ✅ Added Firestore security rules

### Week 9-10: Testing & Documentation
- ✅ Created unit tests for services
- ✅ Created widget tests
- ✅ Wrote comprehensive README
- ✅ Created setup and deployment guides
- ✅ Added code documentation

---

## 🔮 Future Scope (Planned)

| Feature | Priority | Status |
|---------|----------|--------|
| Push Notifications | High | ⏳ Planned |
| Smart Matching (AI) | Medium | ⏳ Planned |
| In-App Chat | Medium | ⏳ Planned |
| Map Integration | Low | ⏳ Planned |
| Multi-language | Low | ⏳ Planned |
| Image Recognition | Low | ⏳ Research |

---

## Technical Notes

- Flutter SDK: 3.0+
- Dart SDK: 3.0+
- Firebase: Firestore, Auth
- Image Storage: Cloudinary
- State Management: Riverpod
- TODO: Optimize image compression
- TODO: Add offline mode with local caching
- TODO: Implement pagination for admin dashboard

## Known Issues
- None reported

## Contributors
- Kushwaha Abhaykumar Dharmendra (Team Lead)
- Hemant Kumar
- Ayush Singhal
- Gurav Sahani

## Mentor
- Dr. Anju Chandna

---

**Version Format:** [Major.Minor.Patch]
- Major: Breaking changes
- Minor: New features
- Patch: Bug fixes
