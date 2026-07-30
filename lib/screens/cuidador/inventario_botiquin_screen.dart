import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_alba_guatemala/providers/medication_provider.dart';
import 'package:proyecto_alba_guatemala/constants/app_colors.dart';

class InventarioBotiquinScreen extends StatefulWidget {
  const InventarioBotiquinScreen({super.key});

  @override
  State<InventarioBotiquinScreen> createState() =>
      _InventarioBotiquinScreenState();
}

class _InventarioBotiquinScreenState extends State<InventarioBotiquinScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MedicationProvider>().fetchMedications('user-id-cuidador');
    });
  }

  @override
  Widget build(BuildContext context) {
    final medProvider = context.watch<MedicationProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario del Botiquín'),
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: medProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : medProvider.medications.isEmpty
              ? const Center(
                  child: Text('No hay medicamentos en el inventario.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: medProvider.medications.length,
                  itemBuilder: (context, index) {
                    final med = medProvider.medications[index];

                    // Definición de umbrales y colores de aviso
                    Color badgeColor;
                    String statusText;

                    if (med.stock <= 2) {
                      badgeColor = Colors.red;
                      statusText = '¡Crítico! Stock muy bajo';
                    } else if (med.stock <=
                        MedicationProvider.lowStockThreshold) {
                      badgeColor = Colors.orange;
                      statusText = 'Pocas pastillas restantes';
                    } else {
                      badgeColor = Colors.green;
                      statusText = 'Stock suficiente';
                    }

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: badgeColor, width: 1.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  med.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: badgeColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: badgeColor),
                                  ),
                                  child: Text(
                                    '${med.stock} uds.',
                                    style: TextStyle(
                                      color: badgeColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                                'Dosis: ${med.dosage} | Frecuencia: ${med.frequency}'),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  med.stock <=
                                          MedicationProvider.lowStockThreshold
                                      ? Icons.warning_amber_rounded
                                      : Icons.check_circle_outline,
                                  color: badgeColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  statusText,
                                  style: TextStyle(
                                    color: badgeColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
