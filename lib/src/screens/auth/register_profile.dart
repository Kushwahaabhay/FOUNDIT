import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../core/validators.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/custom_buttons.dart';
import '../feed/feed_screen.dart';

/// Profile completion screen after Google Sign-In
class RegisterProfileScreen extends ConsumerStatefulWidget {
  const RegisterProfileScreen({super.key});
  
  @override
  ConsumerState<RegisterProfileScreen> createState() => _RegisterProfileScreenState();
}

class _RegisterProfileScreenState extends ConsumerState<RegisterProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _rollNoController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  
  @override
  void dispose() {
    _nameController.dispose();
    _rollNoController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  
  Future<void> _completeProfile() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      final authService = ref.read(authServiceProvider);
      await authService.completeUserProfile(
        name: _nameController.text.trim(),
        rollNo: _rollNoController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
      );
      
      if (!mounted) return;
      AppUtils.showSnackBar(context, 'Profile completed successfully!');
      
      // Navigate to FeedScreen and clear navigation stack
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const FeedScreen()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      AppUtils.showSnackBar(
        context,
        e.toString().replaceAll('Exception: ', ''),
        isError: true,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppTheme.darkGradient : AppTheme.lightGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Header
                    Text(
                      'Complete Your Profile',
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We need a few more details',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    
                    // Form Card
                    GlassCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          // Name Field
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: Validators.validateName,
                            textCapitalization: TextCapitalization.words,
                          ),
                          const SizedBox(height: 16),
                          
                          // Roll Number Field
                          TextFormField(
                            controller: _rollNoController,
                            decoration: const InputDecoration(
                              labelText: 'Roll Number',
                              prefixIcon: Icon(Icons.badge),
                            ),
                            validator: Validators.validateRollNumber,
                          ),
                          const SizedBox(height: 16),
                          
                          // Phone Field (Optional)
                          TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number (Optional)',
                              prefixIcon: Icon(Icons.phone),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: Validators.validatePhone,
                          ),
                          const SizedBox(height: 24),
                          
                          // Submit Button
                          SizedBox(
                            width: double.infinity,
                            child: GlassButton(
                              text: 'Complete Profile',
                              icon: Icons.check,
                              onPressed: _isLoading ? null : _completeProfile,
                              isLoading: _isLoading,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
