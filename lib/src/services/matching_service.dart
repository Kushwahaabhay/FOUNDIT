import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../core/constants.dart';
import '../core/utils.dart';
import '../models/item_model.dart';
import 'firebase_service.dart';

/// Smart matching service for finding potential matches between lost and found items
/// This is a placeholder implementation for future AI/ML integration
class MatchingService {
  final FirebaseFirestore _firestore = FirebaseService.firestore;
  
  /// Find possible matches for an item
  /// Returns list of item IDs that might match
  Future<List<String>> findPossibleMatches(ItemModel item) async {
    if (!AppConstants.enableSmartMatching) {
      return []; // Feature disabled
    }
    
    try {
      // Get opposite status items (Lost <-> Found)
      final oppositeStatus = item.isLost ? AppConstants.statusFound : AppConstants.statusLost;
      
      // Query items with same category and location
      final querySnapshot = await _firestore
          .collection(AppConstants.itemsCollection)
          .where('status', isEqualTo: oppositeStatus)
          .where('category', isEqualTo: item.category)
          .limit(20)
          .get();
      
      final matches = <String>[];
      
      // Calculate similarity scores
      for (final doc in querySnapshot.docs) {
        final otherItem = ItemModel.fromFirestore(doc);
        
        // Skip if same user
        if (otherItem.postedByUid == item.postedByUid) continue;
        
        // Calculate text similarity
        final titleSimilarity = AppUtils.calculateSimilarity(
          item.title,
          otherItem.title,
        );
        
        final descSimilarity = AppUtils.calculateSimilarity(
          item.description,
          otherItem.description,
        );
        
        // Check location match
        final locationMatch = item.location == otherItem.location;
        
        // Calculate overall score
        final score = (titleSimilarity * 0.5) + 
                     (descSimilarity * 0.3) + 
                     (locationMatch ? 0.2 : 0.0);
        
        // Add to matches if score is above threshold
        if (score > 0.4) {
          matches.add(otherItem.itemId);
        }
      }
      
      return matches;
    } catch (e) {
      debugPrint('Error finding matches: $e');
      return [];
    }
  }
  
  /// Update possible matches for an item
  Future<void> updatePossibleMatches(String itemId, List<String> matches) async {
    try {
      await _firestore
          .collection(AppConstants.itemsCollection)
          .doc(itemId)
          .update({'possibleMatches': matches});
    } catch (e) {
      debugPrint('Error updating matches: $e');
    }
  }
  
  /// Run matching for all unresolved items (admin function)
  /// This can be called periodically or triggered manually
  Future<void> runBatchMatching() async {
    if (!AppConstants.enableSmartMatching) {
      return; // Feature disabled
    }
    
    try {
      // Get all unresolved items
      final querySnapshot = await _firestore
          .collection(AppConstants.itemsCollection)
          .where('status', whereIn: [AppConstants.statusLost, AppConstants.statusFound])
          .get();
      
      // Process each item
      for (final doc in querySnapshot.docs) {
        final item = ItemModel.fromFirestore(doc);
        final matches = await findPossibleMatches(item);
        
        if (matches.isNotEmpty) {
          await updatePossibleMatches(item.itemId, matches);
        }
      }
      
      debugPrint('Batch matching completed for ${querySnapshot.docs.length} items');
    } catch (e) {
      debugPrint('Error in batch matching: $e');
    }
  }
  
  /// Future: Integrate ML Kit for image-based matching
  /// This is a placeholder for future implementation
  Future<List<String>> findMatchesByImage(String imageUrl) async {
    // TODO: Implement ML Kit Image Labeling
    // 1. Download image from URL
    // 2. Run ML Kit Image Labeler
    // 3. Extract labels (e.g., "wallet", "blue", "leather")
    // 4. Query items with similar labels
    // 5. Return matching item IDs
    
    return [];
  }
}
