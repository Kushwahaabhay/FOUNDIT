import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants.dart';
import '../models/item_model.dart';
import '../services/firebase_service.dart';
import '../services/storage_service.dart';
import '../services/matching_service.dart';

/// Storage service provider
final storageServiceProvider = Provider<StorageService>((ref) => StorageService());

/// Matching service provider
final matchingServiceProvider = Provider<MatchingService>((ref) => MatchingService());

/// Post provider for creating and managing posts
final postProvider = Provider<PostService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final matchingService = ref.watch(matchingServiceProvider);
  return PostService(storageService, matchingService);
});

/// Post service class
class PostService {
  final StorageService _storageService;
  final MatchingService _matchingService;
  final FirebaseFirestore _firestore = FirebaseService.firestore;
  
  PostService(this._storageService, this._matchingService);
  
  /// Create new post
  Future<String> createPost({
    required String title,
    required String description,
    required String category,
    required String status,
    required String location,
    File? imageFile,
    String? contactPhone,
  }) async {
    try {
      final userId = FirebaseService.currentUserId;
      if (userId == null) throw Exception('User not signed in');
      
      final userEmail = FirebaseService.currentUserEmail;
      if (userEmail == null) throw Exception('User email not found');
      
      // Generate item ID
      final itemId = _firestore.collection(AppConstants.itemsCollection).doc().id;
      
      // Upload image if provided
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await _storageService.uploadItemImage(imageFile, itemId);
      }
      
      // Create item model
      final item = ItemModel(
        itemId: itemId,
        title: title,
        description: description,
        category: category,
        status: status,
        location: location,
        imageUrl: imageUrl,
        postedByUid: userId,
        contactPhone: contactPhone,
        contactEmail: userEmail,
        createdAt: DateTime.now(),
        lastUpdated: DateTime.now(),
      );
      
      // Save to Firestore
      await _firestore
          .collection(AppConstants.itemsCollection)
          .doc(itemId)
          .set(item.toJson());
      
      // Run smart matching if enabled
      if (AppConstants.enableSmartMatching) {
        final matches = await _matchingService.findPossibleMatches(item);
        if (matches.isNotEmpty) {
          await _matchingService.updatePossibleMatches(itemId, matches);
        }
      }
      
      return itemId;
    } catch (e) {
      throw Exception('Failed to create post: ${e.toString()}');
    }
  }
  
  /// Update existing post
  Future<void> updatePost({
    required String itemId,
    String? title,
    String? description,
    String? category,
    String? location,
    File? newImageFile,
    String? contactPhone,
  }) async {
    try {
      final updates = <String, dynamic>{
        'lastUpdated': Timestamp.now(),
      };
      
      if (title != null) updates['title'] = title;
      if (description != null) updates['description'] = description;
      if (category != null) updates['category'] = category;
      if (location != null) updates['location'] = location;
      if (contactPhone != null) updates['contactPhone'] = contactPhone;
      
      // Upload new image if provided
      if (newImageFile != null) {
        final imageUrl = await _storageService.uploadItemImage(newImageFile, itemId);
        updates['imageUrl'] = imageUrl;
      }
      
      await _firestore
          .collection(AppConstants.itemsCollection)
          .doc(itemId)
          .update(updates);
    } catch (e) {
      throw Exception('Failed to update post: ${e.toString()}');
    }
  }
  
  /// Mark post as resolved
  Future<void> markAsResolved(String itemId) async {
    try {
      await _firestore
          .collection(AppConstants.itemsCollection)
          .doc(itemId)
          .update({
        'status': AppConstants.statusResolved,
        'lastUpdated': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to mark as resolved: ${e.toString()}');
    }
  }
  
  /// Delete post
  Future<void> deletePost(String itemId, String? imageUrl) async {
    try {
      // Delete image from storage if exists
      if (imageUrl != null && imageUrl.isNotEmpty) {
        await _storageService.deleteItemImage(imageUrl);
      }
      
      // Delete document from Firestore
      await _firestore
          .collection(AppConstants.itemsCollection)
          .doc(itemId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete post: ${e.toString()}');
    }
  }
  
  /// Pick image from gallery
  Future<File?> pickImageFromGallery() async {
    return _storageService.pickImageFromGallery();
  }
  
  /// Pick image from camera
  Future<File?> pickImageFromCamera() async {
    return _storageService.pickImageFromCamera();
  }
}
