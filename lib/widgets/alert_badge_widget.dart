import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/constants/app_colors.dart';

class AlertBadgeWidget extends StatelessWidget {
  final String alertText;

  const AlertBadgeWidget({
    super.key,
    required this.alertText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.criticalRed.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.criticalRed),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.criticalRed),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              alertText,
              style: const TextStyle(
                color: AppColors.criticalRed,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
