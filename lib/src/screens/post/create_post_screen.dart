import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../core/validators.dart';
import '../../providers/post_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/custom_buttons.dart';

/// Create post screen for posting lost/found items
class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});
  
  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  
  String _status = AppConstants.statusLost;
  String? _selectedCategory;
  String? _selectedLocation;
  XFile? _imageFile;
  bool _isLoading = false;
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  
  Future<void> _pickImage(ImageSource source) async {
    try {
      final postService = ref.read(postProvider);
      final file = source == ImageSource.camera
          ? await postService.pickImageFromCamera()
          : await postService.pickImageFromGallery();
      
      if (file != null) {
        setState(() => _imageFile = file);
      }
    } catch (e) {
      if (mounted) {
        AppUtils.showSnackBar(context, e.toString(), isError: true);
      }
    }
  }
  
  Future<void> _createPost() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_selectedCategory == null) {
      AppUtils.showSnackBar(context, 'Please select a category', isError: true);
      return;
    }
    
    if (_selectedLocation == null) {
      AppUtils.showSnackBar(context, 'Please select a location', isError: true);
      return;
    }
    
    setState(() => _isLoading = true);
    
    try {
      final postService = ref.read(postProvider);
      await postService.createPost(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory!,
        status: _status,
        location: _selectedLocation!,
        imageFile: _imageFile,
        contactPhone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
      );
      
      if (!mounted) return;
      AppUtils.showSnackBar(context, AppConstants.successPostCreated);
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      AppUtils.showSnackBar(context, e.toString(), isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Toggle
              GlassCard(
                child: Row(
                  children: [
                    Expanded(
                      child: _StatusButton(
                        label: 'Lost',
                        isSelected: _status == AppConstants.statusLost,
                        onTap: () => setState(() => _status = AppConstants.statusLost),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatusButton(
                        label: 'Found',
                        isSelected: _status == AppConstants.statusFound,
                        onTap: () => setState(() => _status = AppConstants.statusFound),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Image Picker
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Photo',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    if (_imageFile != null)
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: kIsWeb
                                ? FutureBuilder<Uint8List>(
                                    future: _imageFile!.readAsBytes(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Image.memory(
                                          snapshot.data!,
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        );
                                      }
                                      return Container(
                                        height: 200,
                                        width: double.infinity,
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                  )
                                : Image.file(
                                    File(_imageFile!.path),
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.white),
                              onPressed: () => setState(() => _imageFile = null),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: GlassOutlineButton(
                              text: 'Camera',
                              icon: Icons.camera_alt,
                              onPressed: () => _pickImage(ImageSource.camera),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: GlassOutlineButton(
                              text: 'Gallery',
                              icon: Icons.photo_library,
                              onPressed: () => _pickImage(ImageSource.gallery),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'e.g., Blue Wallet',
                ),
                validator: Validators.validateTitle,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 16),
              
              // Category
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                ),
                items: AppConstants.itemCategories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
                validator: Validators.validateCategory,
              ),
              const SizedBox(height: 16),
              
              // Location
              DropdownButtonFormField<String>(
                initialValue: _selectedLocation,
                decoration: const InputDecoration(
                  labelText: 'Location',
                ),
                items: AppConstants.campusLocations.map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedLocation = value),
                validator: Validators.validateLocation,
              ),
              const SizedBox(height: 16),
              
              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Provide details to help identify the item',
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                maxLength: AppConstants.maxDescriptionLength,
                validator: Validators.validateDescription,
              ),
              const SizedBox(height: 16),
              
              // Phone (Optional)
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Contact Phone (Optional)',
                  hintText: 'Your phone number',
                ),
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone,
              ),
              const SizedBox(height: 24),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: GlassButton(
                  text: 'Post Item',
                  icon: Icons.send,
                  onPressed: _isLoading ? null : _createPost,
                  isLoading: _isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  
  const _StatusButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final color = label == 'Lost' ? AppTheme.statusLost : AppTheme.statusFound;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 2),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

enum ImageSource { camera, gallery }
