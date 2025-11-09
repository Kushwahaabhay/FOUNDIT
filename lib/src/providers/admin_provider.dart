import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants.dart';
import '../models/item_model.dart';
import '../services/firebase_service.dart';

/// Admin service provider
final adminProvider = Provider<AdminService>((ref) => AdminService());

/// Admin statistics provider
final adminStatsProvider = FutureProvider<AdminStats>((ref) async {
  final adminService = ref.watch(adminProvider);
  return adminService.getStatistics();
});

/// All posts provider (admin view)
final allPostsProvider = StreamProvider.autoDispose<List<ItemModel>>((ref) {
  return FirebaseService.firestore
      .collection(AppConstants.itemsCollection)
      .orderBy('createdAt', descending: true)
      .limit(100)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => ItemModel.fromFirestore(doc))
          .toList());
});

/// Admin statistics model
class AdminStats {
  final int totalPosts;
  final int lostItems;
  final int foundItems;
  final int resolvedItems;
  final int totalUsers;
  
  AdminStats({
    required this.totalPosts,
    required this.lostItems,
    required this.foundItems,
    required this.resolvedItems,
    required this.totalUsers,
  });
}

/// Admin service class
class AdminService {
  final FirebaseFirestore _firestore = FirebaseService.firestore;
  
  /// Get admin statistics
  Future<AdminStats> getStatistics() async {
    try {
      // Get total posts
      final postsSnapshot = await _firestore
          .collection(AppConstants.itemsCollection)
          .count()
          .get();
      final totalPosts = postsSnapshot.count ?? 0;
      
      // Get lost items count
      final lostSnapshot = await _firestore
          .collection(AppConstants.itemsCollection)
          .where('status', isEqualTo: AppConstants.statusLost)
          .count()
          .get();
      final lostItems = lostSnapshot.count ?? 0;
      
      // Get found items count
      final foundSnapshot = await _firestore
          .collection(AppConstants.itemsCollection)
          .where('status', isEqualTo: AppConstants.statusFound)
          .count()
          .get();
      final foundItems = foundSnapshot.count ?? 0;
      
      // Get resolved items count
      final resolvedSnapshot = await _firestore
          .collection(AppConstants.itemsCollection)
          .where('status', isEqualTo: AppConstants.statusResolved)
          .count()
          .get();
      final resolvedItems = resolvedSnapshot.count ?? 0;
      
      // Get total users
      final usersSnapshot = await _firestore
          .collection(AppConstants.usersCollection)
          .count()
          .get();
      final totalUsers = usersSnapshot.count ?? 0;
      
      return AdminStats(
        totalPosts: totalPosts,
        lostItems: lostItems,
        foundItems: foundItems,
        resolvedItems: resolvedItems,
        totalUsers: totalUsers,
      );
    } catch (e) {
      throw Exception('Failed to get statistics: ${e.toString()}');
    }
  }
  
  /// Delete any post (admin privilege)
  Future<void> deletePost(String itemId) async {
    try {
      final userId = FirebaseService.currentUserId;
      if (userId == null) throw Exception('User not signed in');
      
      // Log admin action
      await _logAdminAction(
        adminUid: userId,
        action: 'delete',
        itemId: itemId,
      );
      
      // Delete post
      await _firestore
          .collection(AppConstants.itemsCollection)
          .doc(itemId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete post: ${e.toString()}');
    }
  }
  
  /// Mark any post as resolved (admin privilege)
  Future<void> markAsResolved(String itemId) async {
    try {
      final userId = FirebaseService.currentUserId;
      if (userId == null) throw Exception('User not signed in');
      
      // Log admin action
      await _logAdminAction(
        adminUid: userId,
        action: 'resolve',
        itemId: itemId,
      );
      
      // Update post
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
  
  /// Log admin action
  Future<void> _logAdminAction({
    required String adminUid,
    required String action,
    required String itemId,
  }) async {
    try {
      await _firestore
          .collection(AppConstants.adminActionsCollection)
          .add({
        'adminUid': adminUid,
        'action': action,
        'itemId': itemId,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      debugPrint('Failed to log admin action: $e');
    }
  }
}
