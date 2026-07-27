import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_alba_guatemala/constants/app_colors.dart';
import 'package:proyecto_alba_guatemala/providers/auth_provider.dart';
import 'package:proyecto_alba_guatemala/providers/medication_provider.dart';
import 'package:proyecto_alba_guatemala/widgets/medication_card.dart';

class InventarioBotiquinScreen extends StatefulWidget {
  const InventarioBotiquinScreen({super.key});

  @override
  State<InventarioBotiquinScreen> createState() =>
      _InventarioBotiquinScreenState();
}

class _InventarioBotiquinScreenState extends State<InventarioBotiquinScreen> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final medicationProvider =
          Provider.of<MedicationProvider>(context, listen: false);
      final userId = authProvider.currentUser?.id ?? '';
      medicationProvider.fetchMedications(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario del Botiquín'),
      ),
      body: Consumer<MedicationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.medications.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'No hay medicamentos registrados en el botiquín. Añade los medicamentos del paciente para comenzar a recibir recordatorios.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final lowStock =
              provider.medications.where((m) => m.stock <= 5).toList();

          return ListView(
            padding: const EdgeInsets.only(top: 16, bottom: 24),
            children: [
              if (lowStock.isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Atención: Stock bajo',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Estos medicamentos tienen poco stock y debes reponerlos pronto:',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        ...lowStock.map(
                          (medication) => Text(
                            '${medication.name} — ${medication.stock} unidades',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ...provider.medications.map(
                (medication) => MedicationCard(
                  medication: medication,
                  isTaken: provider.takenStatus[medication.id] ?? false,
                  onTakenChanged: (value) {
                    provider.markAsTaken(medication.id, value ?? false);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
