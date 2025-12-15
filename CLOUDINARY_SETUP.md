# Cloudinary Setup Guide

Step-by-step guide to configure Cloudinary for image uploads.

---

## 🎯 Why Cloudinary?

| Feature | Firebase Storage | Cloudinary |
|---------|------------------|------------|
| Free tier | Requires billing | ✅ Generous free tier |
| Storage | 5GB | 25GB |
| Bandwidth | 1GB/day | 25GB/month |
| Payment required | Yes | ❌ No |
| CDN | Yes | ✅ Global CDN |
| Image optimization | Manual | ✅ Automatic |

---

## 🚀 Quick Setup (5 minutes)

### Step 1: Create Account

1. Go to: [Cloudinary Sign Up](https://cloudinary.com/users/register/free)
2. Fill in your details
3. Click **"Create Account"**
4. Verify your email

### Step 2: Get Cloud Name

1. Login to [Cloudinary Console](https://console.cloudinary.com/)
2. On Dashboard, find **"Account Details"**
3. Copy your **Cloud Name** (e.g., `dwrhrtnzg`)

### Step 3: Create Upload Preset ⚠️ CRITICAL

1. Go to **Settings** (gear icon) → **Upload**
2. Scroll to **"Upload presets"**
3. Click **"Add upload preset"**
4. Configure:
   | Setting | Value |
   |---------|-------|
   | Preset name | `foundit_preset` |
   | Signing Mode | **Unsigned** ⚠️ |
   | Folder | `foundit/items` |
5. Click **Save**
6. **Wait 1-2 minutes** for changes to apply

> ⚠️ **IMPORTANT:** Signing Mode MUST be "Unsigned" or you'll get 401 errors!

### Step 4: Update Environment File

Add to your `.env`:

```env
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_UPLOAD_PRESET=foundit_preset
```

### Step 5: Test Upload

1. Run the app
2. Create a new post
3. Add an image
4. Submit

If successful, image appears in your Cloudinary Media Library!

---

## 🔧 Troubleshooting

### 401 Error - Bad Request

**Cause:** Upload preset is "Signed" instead of "Unsigned"

**Fix:**
1. Go to Settings → Upload → Upload presets
2. Click on `foundit_preset`
3. Change Signing Mode to **Unsigned**
4. Save and wait 1 minute

### Image Not Uploading

**Check:**
- [ ] Cloud name is correct in `.env`
- [ ] Preset name is exactly `foundit_preset`
- [ ] Preset is Unsigned
- [ ] Internet connection is stable

### Images Not Displaying

**Cause:** Invalid cloud name or image URL

**Fix:** Verify cloud name matches your Cloudinary dashboard

---

## 📊 Cloudinary Limits (Free Tier)

| Resource | Limit |
|----------|-------|
| Storage | 25 GB |
| Monthly bandwidth | 25 GB |
| Transformations | 25,000/month |
| Max file size | 10 MB |

For a college app, these limits are more than sufficient!

---

## 🔒 Security Notes

- **Unsigned presets** are designed for client-side uploads
- Images are public by default (anyone with URL can view)
- For sensitive images, consider using signed uploads
- Cloudinary automatically scans for inappropriate content

---

## 📚 Resources

- [Cloudinary Documentation](https://cloudinary.com/documentation)
- [cloudinary_public Flutter Package](https://pub.dev/packages/cloudinary_public)
- [Image Transformation Guide](https://cloudinary.com/documentation/image_transformations)

---

## ✅ Setup Checklist

- [ ] Cloudinary account created
- [ ] Email verified
- [ ] Cloud name copied
- [ ] Upload preset `foundit_preset` created
- [ ] Preset is **Unsigned**
- [ ] `.env` updated with credentials
- [ ] Test upload successful

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
