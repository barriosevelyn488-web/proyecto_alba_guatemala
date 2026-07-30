import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/constants/app_colors.dart';
import 'package:proyecto_alba_guatemala/widgets/bottom_nav_bar.dart';
import 'package:proyecto_alba_guatemala/widgets/top_role_header.dart';

class RecetasHistorialScreen extends StatelessWidget {
  static const List<Map<String, String>> _recetas = [
    {
      'doctor': 'Dra. Ana Pérez',
      'fecha': '18 Jul 2026',
      'medicamentos': 'Paracetamol, Amoxicilina',
    },
    {
      'doctor': 'Dr. Carlos Méndez',
      'fecha': '10 Jul 2026',
      'medicamentos': 'Metformina, Losartán',
    },
    {
      'doctor': 'Dra. Sofía Torres',
      'fecha': '02 Jul 2026',
      'medicamentos': 'Vitamina D, Omeprazol',
    },
  ];

  const RecetasHistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'RECETAS Y PRESCRIPCIONES',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Column(
        children: [
          const TopRoleHeader(
            nombrePaciente: 'María López',
            estado: 'En línea',
            ultimaToma: '08:30 a. m.',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_rounded),
                      label: const Text('FOTOGRAFIAR Y SUBIR NUEVA RECETA'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.secondaryBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _recetas.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return _buildRecetaCard(context, _recetas[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (_) {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.secondaryBlue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRecetaCard(BuildContext context, Map<String, String> receta) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.secondaryBlue.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.description_outlined,
                color: AppColors.secondaryBlue,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    receta['doctor']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    receta['fecha']!,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Medicamentos: ${receta['medicamentos']}',
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Abriendo receta...')),
                          );
                        },
                        icon: const Icon(Icons.open_in_new, size: 18),
                        label: const Text('Ver PDF'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.secondaryBlue,
                          side: const BorderSide(color: AppColors.secondaryBlue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Compartiendo receta...')),
                          );
                        },
                        icon: const Icon(Icons.share, size: 18),
                        label: const Text('Compartir'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.secondaryBlue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
