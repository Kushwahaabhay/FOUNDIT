# Cloudinary Setup Guide

## 🎯 Why Cloudinary?

Firebase Storage requires billing even in US regions. Cloudinary offers:
- ✅ **FREE** - 25GB storage, 25GB bandwidth/month
- ✅ **No payment method** required
- ✅ **Fast** - Global CDN
- ✅ **Easy** - Simple API

---

## 🚀 Quick Setup (5 minutes)

### Step 1: Create Cloudinary Account

1. Go to: https://cloudinary.com/users/register/free
2. Fill in:
   - **Email:** Your email
   - **Password:** Create password
   - **Cloud name:** Choose a unique name (e.g., `foundit-gcet`)
3. Click **"Create Account"**
4. Verify your email

### Step 2: Get Your Credentials

1. After login, you'll see the **Dashboard**
2. Look for **"Account Details"** section
3. You'll see:
   - **Cloud name:** (e.g., `dxyz123abc`)
   - **API Key:** (not needed for upload)
   - **API Secret:** (not needed for upload)

4. **Copy your Cloud name** - you'll need this!

### Step 3: Create Upload Preset ⚠️ CRITICAL STEP

1. In Cloudinary Dashboard, click **Settings** (gear icon)
2. Click **Upload** tab
3. Scroll to **"Upload presets"**
4. Click **"Add upload preset"**
5. Fill in:
   - **Preset name:** `foundit_preset` (exactly this!)
   - **Signing Mode:** Select **"Unsigned"** ⚠️⚠️⚠️ MUST BE UNSIGNED!
   - **Folder:** `foundit/items`
6. Click **"Save"**
7. **Wait 1 minute** for changes to apply

**IMPORTANT:** If Signing Mode is "Signed", you'll get 401 error!

### Step 4: Update Your Code

Open `lib/src/services/storage_service.dart` and update:

```dart
static const String _cloudName = 'YOUR_CLOUD_NAME'; // Replace with your cloud name
static const String _uploadPreset = 'foundit_preset'; // Keep as is
```

**Example:**
```dart
static const String _cloudName = 'dxyz123abc'; // Your actual cloud name
static const String _uploadPreset = 'foundit_preset';
```

### Step 5: Install Dependencies

```bash
flutter pub get
```

### Step 6: Test It!

```bash
flutter run
```

Try uploading an image - it should work!

---

## ✅ Verification

After setup, check:
- [ ] Cloudinary account created
- [ ] Cloud name copied
- [ ] Upload preset created (unsigned)
- [ ] Code updated with cloud name
- [ ] Dependencies installed
- [ ] App runs without errors
- [ ] Can upload images

---

## 📊 Free Tier Limits

| Resource | Free Tier | Your Usage (Estimated) |
|----------|-----------|------------------------|
| Storage | 25 GB | ~1 GB (plenty!) |
| Bandwidth | 25 GB/month | ~5 GB/month |
| Transformations | 25,000/month | ~1,000/month |
| Images | Unlimited | ~500 images |

**Conclusion:** More than enough for your college project!

---

## 🎯 What Changed in Your Code

### Before (Firebase Storage):
```dart
firebase_storage: ^12.3.4
```

### After (Cloudinary):
```dart
cloudinary_public: ^0.21.0
```

### Code Changes:
- ✅ `storage_service.dart` - Updated to use Cloudinary
- ✅ `firebase_service.dart` - Removed Storage reference
- ✅ `pubspec.yaml` - Replaced package

**Everything else stays the same!**

---

## 🐛 Troubleshooting

### Issue: "Invalid cloud name"
**Solution:** 
- Check you copied the correct cloud name from dashboard
- No spaces, no special characters
- Should be lowercase

### Issue: "Upload preset not found"
**Solution:**
- Make sure preset name is exactly: `foundit_preset`
- Make sure signing mode is **"Unsigned"**
- Wait 1-2 minutes after creating preset

### Issue: "Upload failed"
**Solution:**
- Check internet connection
- Verify cloud name and preset are correct
- Check image file size (should be < 5MB)

### Issue: Package version conflict
**Solution:**
```bash
flutter clean
flutter pub get
```

---

## 📸 How It Works

1. User picks image from gallery/camera
2. App uploads to Cloudinary
3. Cloudinary returns secure URL
4. URL is saved in Firestore
5. Images are displayed using cached_network_image

**Benefits:**
- Fast global CDN
- Automatic optimization
- Secure HTTPS URLs
- No Firebase billing issues

---

## 🔐 Security Notes

### Upload Preset Security:
- **Unsigned preset** allows uploads without API key
- Safe for mobile apps
- Cloudinary handles abuse prevention
- You can add restrictions in preset settings

### Recommended Restrictions:
1. In Cloudinary Dashboard → Settings → Upload
2. Edit your preset
3. Add restrictions:
   - **Max file size:** 5 MB
   - **Allowed formats:** jpg, png, jpeg
   - **Max dimensions:** 1920x1920

---

## 💡 Pro Tips

### Tip 1: Image Optimization
Cloudinary automatically optimizes images for web/mobile!

### Tip 2: Transformations
You can resize images on-the-fly by modifying URLs:
```
Original: https://res.cloudinary.com/.../image.jpg
Thumbnail: https://res.cloudinary.com/.../w_200,h_200,c_fill/image.jpg
```

### Tip 3: Monitor Usage
Check your usage in Cloudinary Dashboard → Reports

### Tip 4: Backup
Cloudinary keeps your images safe with automatic backups

---

## 🎉 Summary

**Setup Time:** 5 minutes  
**Cost:** FREE  
**Storage:** 25GB  
**Speed:** Fast (global CDN)  
**Reliability:** Enterprise-grade  

**Result:** Working image uploads without Firebase billing! ✅

---

## 📞 Need Help?

If you're stuck:
1. Check your cloud name is correct
2. Verify upload preset is "unsigned"
3. Make sure you ran `flutter pub get`
4. Try `flutter clean` then `flutter run`

**Cloudinary Support:** https://support.cloudinary.com/

---

**Next:** Run the app and test image upload!
