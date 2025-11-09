# Quick Fix - Image Upload Error

## ❌ Error You're Seeing

```
401 bad response
Upload failed
```

## ✅ Solution (2 minutes)

### The Problem:
Cloudinary upload preset is either:
- Not created yet
- Not set to "Unsigned" mode

### The Fix:

1. **Go to Cloudinary Console**
   ```
   https://cloudinary.com/console
   ```

2. **Login** with your account

3. **Click Settings** (gear icon) → **Upload** tab

4. **Scroll to "Upload presets"**

5. **Check if `foundit_preset` exists:**

   **If it exists:**
   - Click on it
   - Make sure **Signing Mode** is **"Unsigned"**
   - If it's "Signed", change to "Unsigned"
   - Click "Save"

   **If it doesn't exist:**
   - Click "Add upload preset"
   - Preset name: `foundit_preset`
   - Signing Mode: **Unsigned** ⚠️
   - Folder: `foundit/items`
   - Click "Save"

6. **Wait 1 minute**

7. **Try uploading image again**

## ✅ Verification

After creating/fixing the preset:
- [ ] Preset name is exactly: `foundit_preset`
- [ ] Signing Mode is: **Unsigned** (not Signed!)
- [ ] Folder is: `foundit/items`
- [ ] Waited 1 minute

## 🧪 Test

1. Open app
2. Create new post
3. Add image
4. Upload should work ✅

---

**Still not working?**
- Double-check preset is "Unsigned"
- Wait 2-3 minutes
- Restart the app
- Try again

---

**This is the most common issue!** Once the preset is "Unsigned", uploads will work perfectly.
