import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'constants.dart';

/// Utility functions for FOUNDIT app
class AppUtils {
  /// Format timestamp to readable date
  static String formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(dateTime);
    }
  }
  
  /// Format timestamp to full date and time
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy • hh:mm a').format(dateTime);
  }
  
  /// Validate email domain (college email only)
  static bool isValidCollegeEmail(String email) {
    return email.toLowerCase().endsWith(AppConstants.allowedEmailDomain.toLowerCase());
  }
  
  /// Mask phone number for privacy (show last 2 digits only)
  static String maskPhoneNumber(String phone) {
    if (phone.length < 4) return phone;
    return 'XXXXXXXX${phone.substring(phone.length - 2)}';
  }
  
  /// Generate WhatsApp deep link
  static String getWhatsAppLink(String phone, String message) {
    // Remove all non-numeric characters
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    // Add country code if not present (assuming India +91)
    final fullPhone = cleanPhone.startsWith('91') ? cleanPhone : '91$cleanPhone';
    final encodedMessage = Uri.encodeComponent(message);
    return 'https://wa.me/$fullPhone?text=$encodedMessage';
  }
  
  /// Generate phone call link
  static String getPhoneCallLink(String phone) {
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    return 'tel:$cleanPhone';
  }
  
  /// Generate email link
  static String getEmailLink(String email, String subject, String body) {
    final encodedSubject = Uri.encodeComponent(subject);
    final encodedBody = Uri.encodeComponent(body);
    return 'mailto:$email?subject=$encodedSubject&body=$encodedBody';
  }
  
  /// Show snackbar message
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
  
  /// Show confirmation dialog
  static Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }
  
  /// Show loading dialog
  static void showLoadingDialog(BuildContext context, {String message = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(message),
          ],
        ),
      ),
    );
  }
  
  /// Hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.pop(context);
  }
  
  /// Get file size in MB
  static double getFileSizeInMB(int bytes) {
    return bytes / (1024 * 1024);
  }
  
  /// Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
  
  /// Generate unique ID
  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
  
  /// Check if string contains keyword (case-insensitive)
  static bool containsKeyword(String text, String keyword) {
    return text.toLowerCase().contains(keyword.toLowerCase());
  }
  
  /// Calculate similarity score between two strings (simple Jaccard similarity)
  /// Used for smart matching feature
  static double calculateSimilarity(String str1, String str2) {
    final words1 = str1.toLowerCase().split(RegExp(r'\s+'));
    final words2 = str2.toLowerCase().split(RegExp(r'\s+'));
    
    final set1 = words1.toSet();
    final set2 = words2.toSet();
    
    final intersection = set1.intersection(set2).length;
    final union = set1.union(set2).length;
    
    return union > 0 ? intersection / union : 0.0;
  }
  
  /// Get status display text
  static String getStatusDisplayText(String status) {
    switch (status.toLowerCase()) {
      case 'lost':
        return 'Lost';
      case 'found':
        return 'Found';
      case 'resolved':
        return 'Resolved';
      default:
        return status;
    }
  }
  
  /// Get status icon
  static IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'lost':
        return Icons.search;
      case 'found':
        return Icons.check_circle;
      case 'resolved':
        return Icons.done_all;
      default:
        return Icons.help_outline;
    }
  }
  
  /// Get category icon
  static IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'id card':
        return Icons.badge;
      case 'wallet':
        return Icons.account_balance_wallet;
      case 'electronics':
        return Icons.devices;
      case 'keys':
        return Icons.key;
      case 'books':
        return Icons.menu_book;
      case 'bag/backpack':
        return Icons.backpack;
      case 'clothing':
        return Icons.checkroom;
      case 'accessories':
        return Icons.watch;
      case 'documents':
        return Icons.description;
      default:
        return Icons.category;
    }
  }
}
