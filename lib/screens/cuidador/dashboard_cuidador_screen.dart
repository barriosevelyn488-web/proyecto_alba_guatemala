
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardCuidadorScreen extends StatelessWidget {
  const DashboardCuidadorScreen({super.key});

  CollectionReference<Map<String, dynamic>> get _medicationsCollection =>
      FirebaseFirestore.instance.collection('medications');

  CollectionReference<Map<String, dynamic>> get _alertsCollection =>
      FirebaseFirestore.instance.collection('alerts');

  DocumentReference<Map<String, dynamic>> get _dashboardDoc =>
      FirebaseFirestore.instance
          .collection('cuidador_dashboard')
          .doc('summary');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard del Cuidador'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildAdherenceCard(),
              const SizedBox(height: 16),
              _buildAlertsSection(),
              const SizedBox(height: 16),
              _buildMedicationStockList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _dashboardDoc.snapshots(),
      builder: (context, snapshot) {
        final data = snapshot.data?.data();
        final name = data?['patientName'] as String? ?? 'Don Roberto Gómez';
        final status = data?['patientStatus'] as String? ?? 'En Línea';
        final avatarLetter = name.isNotEmpty ? name[0] : 'A';

        return Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.green.shade700,
              child: Text(
                avatarLetter,
                style: const TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _statusDot(status == 'En Línea'),
                      const SizedBox(width: 8),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Cuidador',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAdherenceCard() {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _dashboardDoc.snapshots(),
      builder: (context, snapshot) {
        final data = snapshot.data?.data();
        final adherence = (data?['adherencePercent'] as num?)?.toDouble() ?? 92.0;
        final indicatorColor = adherence >= 85
            ? Colors.green
            : adherence >= 65
                ? Colors.orange
                : Colors.red;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              _buildAdherenceGauge(adherence, indicatorColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Adherencia a tratamientos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Porcentaje de cumplimiento en los últimos 7 días',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      '${adherence.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: indicatorColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAdherenceGauge(double value, Color color) {
    return SizedBox(
      width: 96,
      height: 96,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: value / 100,
            color: color,
            backgroundColor: Colors.grey.shade200,
            strokeWidth: 10,
          ),
          Text(
            '${value.toStringAsFixed(0)}%',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsSection() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _alertsCollection
          .where('active', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        final alerts = snapshot.data?.docs ?? const [];

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alertas críticas',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              if (snapshot.connectionState == ConnectionState.waiting)
                const Center(child: CircularProgressIndicator())
              else if (alerts.isEmpty)
                const Text(
                  'No hay alertas activas en este momento.',
                  style: TextStyle(color: Colors.black87),
                )
              else
                Column(
                  children: alerts
                      .take(3)
                      .map((doc) => _buildAlertTile(doc.data()))
                      .toList(),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAlertTile(Map<String, dynamic> data) {
    final title = data['title'] as String? ?? 'Alerta importante';
    final subtitle = data['subtitle'] as String? ??
        'La toma no fue confirmada o hubo retraso en el horario.';
    final priority = data['priority'] as String? ?? 'Alta';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              priority,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationStockList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _medicationsCollection
          .orderBy('stock', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        final medicines = snapshot.data?.docs ?? const [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stock de medicamentos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            if (snapshot.connectionState == ConnectionState.waiting)
              const Center(child: CircularProgressIndicator())
            else if (medicines.isEmpty)
              const Text(
                'No se encontraron medicamentos en el inventario.',
                style: TextStyle(color: Colors.black87),
              )
            else
              Column(
                children: medicines
                    .take(4)
                    .map((doc) => _buildMedicationTile(doc.data()))
                    .toList(),
              ),
          ],
        );
      },
    );
  }

  Widget _buildMedicationTile(Map<String, dynamic> data) {
    final name = data['name'] as String? ?? 'Medicamento';
    final stock = data['stock'] as int? ?? 0;
    final threshold = data['threshold'] as int? ?? 10;
    final stockPercent = threshold > 0 ? (stock / threshold).clamp(0.0, 1.0) : 0.0;
    final isUrgent = stock <= threshold;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$stock unidades',
                style: TextStyle(
                  color: isUrgent ? Colors.red : Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: stockPercent,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(
                isUrgent ? Colors.red : Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            isUrgent ? 'Stock crítico' : 'Nivel suficiente',
            style: TextStyle(
              fontSize: 12,
              color: isUrgent ? Colors.red.shade700 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusDot(bool online) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: online ? Colors.green : Colors.orange,
        shape: BoxShape.circle,
      ),
    );
  }
}