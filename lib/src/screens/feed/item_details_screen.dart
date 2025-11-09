import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../core/constants.dart';
import '../../providers/feed_provider.dart';
import '../../providers/post_provider.dart';
import '../../services/firebase_service.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/custom_buttons.dart';

/// Item details screen with contact options
class ItemDetailsScreen extends ConsumerWidget {
  final String itemId;
  
  const ItemDetailsScreen({
    super.key,
    required this.itemId,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(itemProvider(itemId));
    final currentUserId = FirebaseService.currentUserId;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: itemAsync.when(
        data: (item) {
          if (item == null) {
            return const Center(child: Text('Item not found'));
          }
          
          final isOwner = item.postedByUid == currentUserId;
          
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                if (item.hasImage)
                  Hero(
                    tag: 'item-${item.itemId}',
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => _ImageViewer(imageUrl: item.imageUrl!),
                          ),
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: item.imageUrl!,
                        height: 400,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                
                // Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status and Category
                      Row(
                        children: [
                          StatusChip(status: item.status),
                          const SizedBox(width: 8),
                          CategoryChip(category: item.category),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Title
                      Text(
                        item.title,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 16),
                      
                      // Location and Time
                      GlassCard(
                        child: Column(
                          children: [
                            _buildInfoRow(
                              Icons.location_on,
                              'Location',
                              item.location,
                              context,
                            ),
                            const Divider(),
                            _buildInfoRow(
                              Icons.access_time,
                              'Posted',
                              AppUtils.formatDateTime(item.createdAt),
                              context,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Description
                      GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.description,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Contact Buttons (if not owner and not resolved)
                      if (!isOwner && !item.isResolved) ...[
                        GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Contact Owner',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 16),
                              
                              // WhatsApp
                              if (item.hasPhone)
                                _ContactButton(
                                  icon: Icons.chat,
                                  label: 'WhatsApp',
                                  color: const Color(0xFF25D366),
                                  onTap: () => _launchWhatsApp(context, item.contactPhone!, item.title),
                                ),
                              const SizedBox(height: 12),
                              
                              // Call
                              if (item.hasPhone)
                                _ContactButton(
                                  icon: Icons.phone,
                                  label: 'Call',
                                  color: AppTheme.primaryBlue,
                                  onTap: () => _launchPhone(context, item.contactPhone!),
                                ),
                              const SizedBox(height: 12),
                              
                              // Email
                              _ContactButton(
                                icon: Icons.email,
                                label: 'Email',
                                color: AppTheme.secondaryTeal,
                                onTap: () => _launchEmail(context, item.contactEmail, item.title),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      
                      // Owner Actions
                      if (isOwner && !item.isResolved) ...[
                        GlassCard(
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: GlassButton(
                                  text: 'Mark as Resolved',
                                  icon: Icons.check_circle,
                                  color: AppTheme.statusResolved,
                                  onPressed: () => _markAsResolved(context, ref, item.itemId),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: GlassOutlineButton(
                                  text: 'Delete Post',
                                  icon: Icons.delete,
                                  color: Colors.red,
                                  onPressed: () => _deletePost(context, ref, item.itemId, item.imageUrl),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
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
  
  Widget _buildInfoRow(IconData icon, String label, String value, BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryBlue),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }
  
  Future<void> _launchWhatsApp(BuildContext context, String phone, String title) async {
    final confirmed = await AppUtils.showConfirmDialog(
      context,
      title: 'Contact via WhatsApp',
      message: 'This will open WhatsApp to contact the owner.',
    );
    
    if (!confirmed) return;
    
    final url = AppUtils.getWhatsAppLink(
      phone,
      'Hi! I saw your post about "$title" on FOUNDIT.',
    );
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        AppUtils.showSnackBar(context, 'Could not open WhatsApp', isError: true);
      }
    }
  }
  
  Future<void> _launchPhone(BuildContext context, String phone) async {
    final confirmed = await AppUtils.showConfirmDialog(
      context,
      title: 'Call Owner',
      message: 'This will open your phone dialer.',
    );
    
    if (!confirmed) return;
    
    final url = AppUtils.getPhoneCallLink(phone);
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (context.mounted) {
        AppUtils.showSnackBar(context, 'Could not open dialer', isError: true);
      }
    }
  }
  
  Future<void> _launchEmail(BuildContext context, String email, String title) async {
    final url = AppUtils.getEmailLink(
      email,
      'Regarding: $title',
      'Hi! I saw your post about "$title" on FOUNDIT.\n\n',
    );
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (context.mounted) {
        AppUtils.showSnackBar(context, 'Could not open email client', isError: true);
      }
    }
  }
  
  Future<void> _markAsResolved(BuildContext context, WidgetRef ref, String itemId) async {
    final confirmed = await AppUtils.showConfirmDialog(
      context,
      title: 'Mark as Resolved',
      message: 'Are you sure you want to mark this item as resolved?',
    );
    
    if (!confirmed) return;
    
    try {
      final postService = ref.read(postProvider);
      await postService.markAsResolved(itemId);
      
      if (context.mounted) {
        AppUtils.showSnackBar(context, AppConstants.successMarkedResolved);
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        AppUtils.showSnackBar(context, e.toString(), isError: true);
      }
    }
  }
  
  Future<void> _deletePost(BuildContext context, WidgetRef ref, String itemId, String? imageUrl) async {
    final confirmed = await AppUtils.showConfirmDialog(
      context,
      title: 'Delete Post',
      message: 'Are you sure you want to delete this post? This action cannot be undone.',
      confirmText: 'Delete',
    );
    
    if (!confirmed) return;
    
    try {
      final postService = ref.read(postProvider);
      await postService.deletePost(itemId, imageUrl);
      
      if (context.mounted) {
        AppUtils.showSnackBar(context, AppConstants.successPostDeleted);
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        AppUtils.showSnackBar(context, e.toString(), isError: true);
      }
    }
  }
}

class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  
  const _ContactButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: color),
          ],
        ),
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final String imageUrl;
  
  const _ImageViewer({required this.imageUrl});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(imageUrl),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    );
  }
}
