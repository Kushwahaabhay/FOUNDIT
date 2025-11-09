import 'package:cloud_firestore/cloud_firestore.dart';

/// User model for FOUNDIT app
/// Represents a registered user (student) in the system
class UserModel {
  final String uid;
  final String name;
  final String rollNo;
  final String email;
  final String? phone;
  final bool isAdmin;
  final DateTime createdAt;
  
  UserModel({
    required this.uid,
    required this.name,
    required this.rollNo,
    required this.email,
    this.phone,
    this.isAdmin = false,
    required this.createdAt,
  });
  
  /// Create UserModel from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      name: data['name'] ?? '',
      rollNo: data['rollNo'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'],
      isAdmin: data['isAdmin'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
  
  /// Create UserModel from JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      rollNo: json['rollNo'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      isAdmin: json['isAdmin'] ?? false,
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
  
  /// Convert UserModel to JSON map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'rollNo': rollNo,
      'email': email,
      'phone': phone,
      'isAdmin': isAdmin,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
  
  /// Create a copy with updated fields
  UserModel copyWith({
    String? uid,
    String? name,
    String? rollNo,
    String? email,
    String? phone,
    bool? isAdmin,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      rollNo: rollNo ?? this.rollNo,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isAdmin: isAdmin ?? this.isAdmin,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  
  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, rollNo: $rollNo, email: $email, isAdmin: $isAdmin)';
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.uid == uid;
  }
  
  @override
  int get hashCode => uid.hashCode;
}
