import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../providers/admin_provider.dart';
import '../../widgets/glass_card.dart';
import '../feed/item_card.dart';

/// Admin dashboard screen for managing posts
class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(adminStatsProvider);
    final allPostsAsync = ref.watch(allPostsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Statistics
            Text(
              'Statistics',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            
            statsAsync.when(
              data: (stats) => Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Total Posts',
                          value: stats.totalPosts.toString(),
                          icon: Icons.post_add,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          title: 'Total Users',
                          value: stats.totalUsers.toString(),
                          icon: Icons.people,
                          color: AppTheme.secondaryTeal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Lost',
                          value: stats.lostItems.toString(),
                          icon: Icons.search,
                          color: AppTheme.statusLost,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          title: 'Found',
                          value: stats.foundItems.toString(),
                          icon: Icons.check_circle,
                          color: AppTheme.statusFound,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _StatCard(
                    title: 'Resolved',
                    value: stats.resolvedItems.toString(),
                    icon: Icons.done_all,
                    color: AppTheme.statusResolved,
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Error: $error'),
            ),
            
            const SizedBox(height: 32),
            
            // All Posts
            Text(
              'All Posts',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            
            allPostsAsync.when(
              data: (posts) {
                if (posts.isEmpty) {
                  return const Center(child: Text('No posts'));
                }
                
                return Column(
                  children: posts.map((post) {
                    return Column(
                      children: [
                        ItemCard(item: post),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _markAsResolved(context, ref, post.itemId),
                                icon: const Icon(Icons.check),
                                label: const Text('Resolve'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.statusResolved,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _deletePost(context, ref, post.itemId),
                                icon: const Icon(Icons.delete),
                                label: const Text('Delete'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Error: $error'),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _markAsResolved(BuildContext context, WidgetRef ref, String itemId) async {
    final confirmed = await AppUtils.showConfirmDialog(
      context,
      title: 'Mark as Resolved',
      message: 'Mark this post as resolved?',
    );
    
    if (!confirmed) return;
    
    try {
      final adminService = ref.read(adminProvider);
      await adminService.markAsResolved(itemId);
      
      if (context.mounted) {
        AppUtils.showSnackBar(context, 'Post marked as resolved');
      }
    } catch (e) {
      if (context.mounted) {
        AppUtils.showSnackBar(context, e.toString(), isError: true);
      }
    }
  }
  
  Future<void> _deletePost(BuildContext context, WidgetRef ref, String itemId) async {
    final confirmed = await AppUtils.showConfirmDialog(
      context,
      title: 'Delete Post',
      message: 'Permanently delete this post?',
      confirmText: 'Delete',
    );
    
    if (!confirmed) return;
    
    try {
      final adminService = ref.read(adminProvider);
      await adminService.deletePost(itemId);
      
      if (context.mounted) {
        AppUtils.showSnackBar(context, 'Post deleted');
      }
    } catch (e) {
      if (context.mounted) {
        AppUtils.showSnackBar(context, e.toString(), isError: true);
      }
    }
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });
  
  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
}
