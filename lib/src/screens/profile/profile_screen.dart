import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../providers/auth_provider.dart';
import '../../providers/feed_provider.dart';
import '../../widgets/glass_card.dart';
import '../feed/item_card.dart';
import '../auth/login_screen.dart';

/// User profile screen
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentUserProfileProvider);
    final userPostsAsync = ref.watch(userPostsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditProfileDialog(context, ref, profileAsync.value),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context, ref),
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('Profile not found'));
          }
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile Card
                GlassCard(
                  child: Column(
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppTheme.primaryBlue,
                        child: Text(
                          profile.name.isNotEmpty ? profile.name[0].toUpperCase() : '?',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Name
                      Text(
                        profile.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      
                      // Roll Number
                      Text(
                        'Roll No: ${profile.rollNo}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Email
                      _buildInfoRow(Icons.email, profile.email, context),
                      if (profile.phone != null && profile.phone!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        _buildInfoRow(Icons.phone, profile.phone!, context),
                      ],
                      
                      if (profile.isAdmin) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppTheme.accentPurple.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.admin_panel_settings, color: AppTheme.accentPurple),
                              SizedBox(width: 8),
                              Text(
                                'Admin',
                                style: TextStyle(
                                  color: AppTheme.accentPurple,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                
                // My Posts Section
                Text(
                  'My Posts',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                
                userPostsAsync.when(
                  data: (posts) {
                    if (posts.isEmpty) {
                      return GlassCard(
                        child: Column(
                          children: [
                            Icon(
                              Icons.inbox,
                              size: 60,
                              color: Colors.grey.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No posts yet',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                      );
                    }
                    
                    return Column(
                      children: posts.map((post) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ItemCard(item: post),
                      )).toList(),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Text('Error: $error'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
  
  Widget _buildInfoRow(IconData icon, String text, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: AppTheme.primaryBlue),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
  
  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await AppUtils.showConfirmDialog(
      context,
      title: 'Sign Out',
      message: 'Are you sure you want to sign out?',
    );
    
    if (!confirmed) return;
    
    try {
      final authService = ref.read(authServiceProvider);
      await authService.signOut();
      
      // Navigate to login and clear entire navigation stack
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        AppUtils.showSnackBar(context, e.toString(), isError: true);
      }
    }
  }
  
  Future<void> _showEditProfileDialog(BuildContext context, WidgetRef ref, dynamic profile) async {
    if (profile == null) return;
    
    final rollNoController = TextEditingController(text: profile.rollNo);
    final phoneController = TextEditingController(text: profile.phone ?? '');
    
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: rollNoController,
                decoration: const InputDecoration(
                  labelText: 'Roll Number',
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  hintText: '10-digit mobile number',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    
    if (result == true) {
      try {
        final authService = ref.read(authServiceProvider);
        await authService.updateProfile(
          rollNo: rollNoController.text.trim(),
          phone: phoneController.text.trim(),
        );
        
        // Refresh the profile
        ref.invalidate(currentUserProfileProvider);
        
        if (context.mounted) {
          AppUtils.showSnackBar(context, 'Profile updated successfully');
        }
      } catch (e) {
        if (context.mounted) {
          AppUtils.showSnackBar(context, e.toString(), isError: true);
        }
      }
    }
    
    rollNoController.dispose();
    phoneController.dispose();
  }
}
