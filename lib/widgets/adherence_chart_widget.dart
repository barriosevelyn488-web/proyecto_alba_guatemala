import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart'; // Se necesitará este paquete

/// Un widget que muestra un gráfico de barras del cumplimiento de la medicación.
class AdherenceChartWidget extends StatelessWidget {
  // Datos mock para 6 meses. En una implementación real, vendrían de un provider.
  final Map<String, double> monthlyAdherence;

  const AdherenceChartWidget({
    super.key,
    this.monthlyAdherence = const {
      'Ene': 95.0,
      'Feb': 92.0,
      'Mar': 88.0,
      'Abr': 98.0,
      'May': 90.0,
      'Jun': 93.0,
    },
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Adherencia (Últimos 6 Meses)',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 20),
            // Aquí iría el widget BarChart del paquete fl_chart
            const AspectRatio(
              aspectRatio: 1.7,
              child: Center(
                child: Text(
                  'Gráfico de barras (requiere fl_chart)',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
