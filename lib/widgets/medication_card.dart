import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/models/medication_model.dart';
import 'package:proyecto_alba_guatemala/constants/app_colors.dart';

class MedicationCard extends StatelessWidget {
  final MedicationModel medication;
  final bool isTaken;
  final Function(bool?) onTakenChanged;

  const MedicationCard({
    super.key,
    required this.medication,
    required this.isTaken,
    required this.onTakenChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medication.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text('${medication.dosage} - ${medication.frequency}'),
                  const SizedBox(height: 4),
                  Text(
                    'Disponibles: ${medication.stock} pastillas',
                    style: TextStyle(
                      color: medication.stock <= 5
                          ? Colors.orange.shade800
                          : Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    medication.instructions,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: isTaken,
              onChanged: onTakenChanged,
              activeColor: AppColors.primaryGreen,
              tristate: false,
            ),
          ],
        ),
      ),
    );
  }
}
