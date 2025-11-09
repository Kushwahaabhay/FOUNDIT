import 'package:cloud_firestore/cloud_firestore.dart';

/// Item model for lost/found items in FOUNDIT app
class ItemModel {
  final String itemId;
  final String title;
  final String description;
  final String category;
  final String status; // 'lost', 'found', 'resolved'
  final String location;
  final String? imageUrl;
  final String postedByUid;
  final String? contactPhone;
  final String contactEmail;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final List<String> possibleMatches; // For future smart matching
  
  // Additional fields for display
  final String? postedByName;
  
  ItemModel({
    required this.itemId,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.location,
    this.imageUrl,
    required this.postedByUid,
    this.contactPhone,
    required this.contactEmail,
    required this.createdAt,
    required this.lastUpdated,
    this.possibleMatches = const [],
    this.postedByName,
  });
  
  /// Create ItemModel from Firestore document
  factory ItemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ItemModel(
      itemId: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      status: data['status'] ?? 'lost',
      location: data['location'] ?? '',
      imageUrl: data['imageUrl'],
      postedByUid: data['postedByUid'] ?? '',
      contactPhone: data['contactPhone'],
      contactEmail: data['contactEmail'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastUpdated: (data['lastUpdated'] as Timestamp?)?.toDate() ?? DateTime.now(),
      possibleMatches: List<String>.from(data['possibleMatches'] ?? []),
      postedByName: data['postedByName'],
    );
  }
  
  /// Create ItemModel from JSON map
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      itemId: json['itemId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      status: json['status'] ?? 'lost',
      location: json['location'] ?? '',
      imageUrl: json['imageUrl'],
      postedByUid: json['postedByUid'] ?? '',
      contactPhone: json['contactPhone'],
      contactEmail: json['contactEmail'] ?? '',
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastUpdated: json['lastUpdated'] is Timestamp
          ? (json['lastUpdated'] as Timestamp).toDate()
          : DateTime.parse(json['lastUpdated'] ?? DateTime.now().toIso8601String()),
      possibleMatches: List<String>.from(json['possibleMatches'] ?? []),
      postedByName: json['postedByName'],
    );
  }
  
  /// Convert ItemModel to JSON map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'title': title,
      'description': description,
      'category': category,
      'status': status,
      'location': location,
      'imageUrl': imageUrl,
      'postedByUid': postedByUid,
      'contactPhone': contactPhone,
      'contactEmail': contactEmail,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastUpdated': Timestamp.fromDate(lastUpdated),
      'possibleMatches': possibleMatches,
      'postedByName': postedByName,
    };
  }
  
  /// Create a copy with updated fields
  ItemModel copyWith({
    String? itemId,
    String? title,
    String? description,
    String? category,
    String? status,
    String? location,
    String? imageUrl,
    String? postedByUid,
    String? contactPhone,
    String? contactEmail,
    DateTime? createdAt,
    DateTime? lastUpdated,
    List<String>? possibleMatches,
    String? postedByName,
  }) {
    return ItemModel(
      itemId: itemId ?? this.itemId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      postedByUid: postedByUid ?? this.postedByUid,
      contactPhone: contactPhone ?? this.contactPhone,
      contactEmail: contactEmail ?? this.contactEmail,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      possibleMatches: possibleMatches ?? this.possibleMatches,
      postedByName: postedByName ?? this.postedByName,
    );
  }
  
  /// Check if item is lost
  bool get isLost => status.toLowerCase() == 'lost';
  
  /// Check if item is found
  bool get isFound => status.toLowerCase() == 'found';
  
  /// Check if item is resolved
  bool get isResolved => status.toLowerCase() == 'resolved';
  
  /// Check if item has image
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;
  
  /// Check if item has phone contact
  bool get hasPhone => contactPhone != null && contactPhone!.isNotEmpty;
  
  @override
  String toString() {
    return 'ItemModel(itemId: $itemId, title: $title, status: $status, category: $category)';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ItemModel && other.itemId == itemId;
  }
  
  @override
  int get hashCode => itemId.hashCode;
}
