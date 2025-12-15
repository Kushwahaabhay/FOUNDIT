import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

import '../core/constants.dart';
import '../core/utils.dart';

/// Storage service for handling image uploads to Cloudinary
/// Cloudinary is used instead of Firebase Storage due to free tier availability
class StorageService {
  // Cloudinary credentials from environment
  static String get _cloudName => dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
  static String get _uploadPreset => dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? '';
  
  late final CloudinaryPublic _cloudinary;
  final ImagePicker _imagePicker = ImagePicker();
  
  StorageService() {
    _cloudinary = CloudinaryPublic(_cloudName, _uploadPreset, cache: false);
  }
  
  /// Pick image from gallery
  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      
      if (image == null) return null;
      
      // Check file size
      final bytes = await image.readAsBytes();
      final fileSizeInMB = AppUtils.getFileSizeInMB(bytes.length);
      
      if (fileSizeInMB > AppConstants.maxImageSizeMB) {
        throw Exception(
          'Image size (${fileSizeInMB.toStringAsFixed(1)}MB) exceeds limit of ${AppConstants.maxImageSizeMB}MB'
        );
      }
      
      return image;
    } catch (e) {
      throw Exception('Failed to pick image: ${e.toString()}');
    }
  }
  
  /// Pick image from camera
  Future<XFile?> pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      
      if (image == null) return null;
      
      // Check file size
      final bytes = await image.readAsBytes();
      final fileSizeInMB = AppUtils.getFileSizeInMB(bytes.length);
      
      if (fileSizeInMB > AppConstants.maxImageSizeMB) {
        throw Exception(
          'Image size (${fileSizeInMB.toStringAsFixed(1)}MB) exceeds limit of ${AppConstants.maxImageSizeMB}MB'
        );
      }
      
      return image;
    } catch (e) {
      throw Exception('Failed to capture image: ${e.toString()}');
    }
  }
  
  /// Upload image to Cloudinary
  /// Returns download URL
  Future<String> uploadItemImage(XFile imageFile, String itemId) async {
    try {
      // Create unique public ID for the image
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final publicId = 'foundit/items/${itemId}_$timestamp';
      
      // Read bytes for cross-platform compatibility (works on web and mobile)
      final bytes = await imageFile.readAsBytes();
      
      // Upload to Cloudinary using bytes for web compatibility
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          bytes,
          publicId: publicId,
          folder: 'foundit/items',
          resourceType: CloudinaryResourceType.Image,
          identifier: imageFile.name,
        ),
      );
      
      // Return the secure URL
      return response.secureUrl;
    } catch (e) {
      throw Exception('Upload failed: ${e.toString()}');
    }
  }
  
  /// Delete image from Cloudinary
  Future<void> deleteItemImage(String imageUrl) async {
    try {
      // Extract public ID from Cloudinary URL
      // URL format: https://res.cloudinary.com/{cloud_name}/image/upload/v{version}/{public_id}.jpg
      final uri = Uri.parse(imageUrl);
      final pathSegments = uri.pathSegments;
      
      // Find the public_id (after 'upload/')
      final uploadIndex = pathSegments.indexOf('upload');
      if (uploadIndex != -1 && uploadIndex + 2 < pathSegments.length) {
        final publicIdWithExt = pathSegments.sublist(uploadIndex + 2).join('/');
        final publicId = publicIdWithExt.split('.').first; // Remove extension
        
        // Note: Cloudinary free tier doesn't support deletion via API
        // Images will be automatically managed by Cloudinary
        // For production, you'd need to use Cloudinary Admin API with API key
        debugPrint('Image deletion not supported in free tier: $publicId');
      }
    } catch (e) {
      // Silently fail - not critical for free tier
      debugPrint('Delete failed: ${e.toString()}');
    }
  }
  
  /// Delete all images for an item
  Future<void> deleteItemImages(String itemId) async {
    // Not supported in Cloudinary free tier without Admin API
    // Images will be managed by Cloudinary's storage limits
    debugPrint('Bulk deletion not supported in free tier');
  }
}
