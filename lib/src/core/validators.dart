import 'constants.dart';

/// Input validation functions for FOUNDIT app
class Validators {
  /// Validate email format and domain
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    // Basic email format validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    // Check college domain
    if (!value.toLowerCase().endsWith(AppConstants.allowedEmailDomain.toLowerCase())) {
      return 'Please use your college email (${AppConstants.allowedEmailDomain})';
    }
    
    return null;
  }
  
  /// Validate name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    
    if (value.trim().length > 50) {
      return 'Name must be less than 50 characters';
    }
    
    // Only letters and spaces
    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegex.hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    
    return null;
  }
  
  /// Validate roll number
  static String? validateRollNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Roll number is required';
    }
    
    if (value.trim().length < 5) {
      return 'Please enter a valid roll number';
    }
    
    if (value.trim().length > 20) {
      return 'Roll number is too long';
    }
    
    return null;
  }
  
  /// Validate phone number
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Phone is optional
    }
    
    // Remove all non-numeric characters
    final cleanPhone = value.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleanPhone.length < AppConstants.minPhoneLength) {
      return 'Phone number must be at least ${AppConstants.minPhoneLength} digits';
    }
    
    if (cleanPhone.length > AppConstants.maxPhoneLength) {
      return 'Phone number is too long';
    }
    
    return null;
  }
  
  /// Validate item title
  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    
    if (value.trim().length < AppConstants.minTitleLength) {
      return 'Title must be at least ${AppConstants.minTitleLength} characters';
    }
    
    if (value.trim().length > AppConstants.maxTitleLength) {
      return 'Title must be less than ${AppConstants.maxTitleLength} characters';
    }
    
    return null;
  }
  
  /// Validate item description
  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    
    if (value.trim().length < AppConstants.minDescriptionLength) {
      return 'Description must be at least ${AppConstants.minDescriptionLength} characters';
    }
    
    if (value.trim().length > AppConstants.maxDescriptionLength) {
      return 'Description must be less than ${AppConstants.maxDescriptionLength} characters';
    }
    
    return null;
  }
  
  /// Validate category selection
  static String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a category';
    }
    
    if (!AppConstants.itemCategories.contains(value)) {
      return 'Invalid category selected';
    }
    
    return null;
  }
  
  /// Validate location selection
  static String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a location';
    }
    
    return null;
  }
  
  /// Validate required field
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}
