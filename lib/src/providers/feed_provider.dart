import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants.dart';
import '../models/item_model.dart';
import '../services/firebase_service.dart';

/// Feed filter state
enum FeedFilter { all, lost, found }

/// Feed filter provider
final feedFilterProvider = StateProvider<FeedFilter>((ref) => FeedFilter.all);

/// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Selected category filter provider
final categoryFilterProvider = StateProvider<String?>((ref) => null);

/// Selected location filter provider
final locationFilterProvider = StateProvider<String?>((ref) => null);

/// Items stream provider with filters
final itemsStreamProvider = StreamProvider.autoDispose<List<ItemModel>>((ref) {
  final filter = ref.watch(feedFilterProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  final categoryFilter = ref.watch(categoryFilterProvider);
  final locationFilter = ref.watch(locationFilterProvider);
  
  Query<Map<String, dynamic>> query = FirebaseService.firestore
      .collection(AppConstants.itemsCollection)
      .orderBy('createdAt', descending: true);
  
  // Apply status filter
  if (filter == FeedFilter.lost) {
    query = query.where('status', isEqualTo: AppConstants.statusLost);
  } else if (filter == FeedFilter.found) {
    query = query.where('status', isEqualTo: AppConstants.statusFound);
  } else {
    // Show both lost and found, exclude resolved
    query = query.where('status', whereIn: [
      AppConstants.statusLost,
      AppConstants.statusFound,
    ]);
  }
  
  // Apply category filter
  if (categoryFilter != null && categoryFilter.isNotEmpty) {
    query = query.where('category', isEqualTo: categoryFilter);
  }
  
  // Apply location filter
  if (locationFilter != null && locationFilter.isNotEmpty) {
    query = query.where('location', isEqualTo: locationFilter);
  }
  
  // Limit results for pagination
  query = query.limit(AppConstants.feedPageSize);
  
  return query.snapshots().map((snapshot) {
    var items = snapshot.docs
        .map((doc) => ItemModel.fromFirestore(doc))
        .toList();
    
    // Apply search filter (client-side)
    if (searchQuery.isNotEmpty) {
      items = items.where((item) {
        final query = searchQuery.toLowerCase();
        return item.title.toLowerCase().contains(query) ||
               item.description.toLowerCase().contains(query) ||
               item.category.toLowerCase().contains(query) ||
               item.location.toLowerCase().contains(query);
      }).toList();
    }
    
    return items;
  });
});

/// User's posts provider
final userPostsProvider = StreamProvider.autoDispose<List<ItemModel>>((ref) {
  final userId = FirebaseService.currentUserId;
  if (userId == null) return Stream.value([]);
  
  return FirebaseService.firestore
      .collection(AppConstants.itemsCollection)
      .where('postedByUid', isEqualTo: userId)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => ItemModel.fromFirestore(doc))
          .toList());
});

/// Single item provider
final itemProvider = StreamProvider.autoDispose.family<ItemModel?, String>((ref, itemId) {
  return FirebaseService.firestore
      .collection(AppConstants.itemsCollection)
      .doc(itemId)
      .snapshots()
      .map((doc) => doc.exists ? ItemModel.fromFirestore(doc) : null);
});
