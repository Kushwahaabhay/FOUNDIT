import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme.dart';

/// Glassmorphism card widget with blur effect
/// Implements the liquid crystal / frosted glass UI design
class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsets? padding;
  final Color? color;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  
  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.padding,
    this.color,
    this.onTap,
    this.width,
    this.height,
  });
  
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Widget card = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? const EdgeInsets.all(16),
          decoration: AppTheme.glassDecoration(
            color: color,
            borderRadius: borderRadius,
            isDark: isDark,
          ),
          child: child,
        ),
      ),
    );
    
    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: card,
      );
    }
    
    return card;
  }
}
