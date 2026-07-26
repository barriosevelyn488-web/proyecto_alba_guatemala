import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/constants/app_colors.dart';
import 'package:proyecto_alba_guatemala/constants/app_typography.dart';

class EmergencySosBanner extends StatelessWidget {
  final VoidCallback onSosPressed;

  const EmergencySosBanner({
    super.key,
    required this.onSosPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSosPressed,
      child: Container(
        width: double.infinity,
        height: 60,
        color: AppColors.criticalRed,
        child: const Center(
          child: Text(
            "¡PEDIR AYUDA / SOS!",
            style: AppTypography.button,
          ),
        ),
      ),
    );
  }
}
