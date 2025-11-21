import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

List<BoxShadow> commonBoxShadow = [
  BoxShadow(
    color: AppColors.blue900.withValues(alpha: 0.1),
    blurRadius: 12,
    offset: Offset(0, 4),
  ),
  BoxShadow(
    color: AppColors.blue500.withValues(alpha: 0.05),
    blurRadius: 2,
    offset: Offset(0, 1),
  ),
];
