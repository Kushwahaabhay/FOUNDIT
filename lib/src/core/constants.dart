/// Core constants and configuration for FOUNDIT app
/// 
/// IMPORTANT: Update [allowedEmailDomain] with your college's actual email domain
class AppConstants {
  // App Info
  static const String appName = 'FOUNDIT';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Smart Campus Lost & Found';
  
  // College Configuration
  // TODO: Update this with actual GCET email domain
  static const String allowedEmailDomain = '@galgotiacollege.edu';
  static const String collegeName = 'Galgotias College of Engineering & Technology';
  static const String collegeShort = 'GCET';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String itemsCollection = 'items';
  static const String adminActionsCollection = 'adminActions';
  static const String notificationsCollection = 'notifications';
  static const String chatsCollection = 'chats'; // Future use
  
  // Item Categories
  static const List<String> itemCategories = [
    'ID Card',
    'Wallet',
    'Electronics',
    'Keys',
    'Books',
    'Bag/Backpack',
    'Clothing',
    'Accessories',
    'Documents',
    'Others',
  ];
  
  // Campus Locations (predefined areas)
  // TODO: Update with actual GCET campus locations
  static const List<String> campusLocations = [
    'Main Gate',
    'Library - Ground Floor',
    'Library - 1st Floor',
    'Library - 2nd Floor',
    'Block A - Ground Floor',
    'Block A - 1st Floor',
    'Block A - 2nd Floor',
    'Block B - Ground Floor',
    'Block B - 1st Floor',
    'Block B - 2nd Floor',
    'Block C - Ground Floor',
    'Block C - 1st Floor',
    'Cafeteria',
    'Auditorium',
    'Sports Complex',
    'Parking Area',
    'Computer Lab 1',
    'Computer Lab 2',
    'Seminar Hall',
    'Admin Block',
    'Other',
  ];
  
  // Item Status
  static const String statusLost = 'lost';
  static const String statusFound = 'found';
  static const String statusResolved = 'resolved';
  
  // Pagination
  static const int feedPageSize = 20;
  static const int maxImageSizeMB = 5;
  static const int maxDescriptionLength = 500;
  
  // Contact Methods
  static const String contactWhatsApp = 'whatsapp';
  static const String contactCall = 'call';
  static const String contactEmail = 'email';
  
  // Feature Flags (for future features)
  static const bool enableSmartMatching = false; // AI matching
  static const bool enableInAppChat = false;
  static const bool enablePushNotifications = false;
  static const bool enableMapView = false;
  static const bool enableImageRecognition = false;
  
  // UI Constants
  static const double cardBorderRadius = 20.0;
  static const double glassBlurSigma = 15.0;
  static const double cardElevation = 4.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
  
  // Error Messages
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'No internet connection. Please check your network.';
  static const String errorInvalidEmail = 'Please use your college email address.';
  static const String errorImageUpload = 'Failed to upload image. Please try again.';
  static const String errorPermissionDenied = 'Permission denied. Please enable in settings.';
  
  // Success Messages
  static const String successPostCreated = 'Post created successfully!';
  static const String successPostUpdated = 'Post updated successfully!';
  static const String successPostDeleted = 'Post deleted successfully!';
  static const String successMarkedResolved = 'Item marked as resolved!';
  
  // Validation
  static const int minTitleLength = 3;
  static const int maxTitleLength = 100;
  static const int minDescriptionLength = 10;
  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 15;
}
