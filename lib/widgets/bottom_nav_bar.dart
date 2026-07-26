import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/models/user_model.dart';
import 'package:proyecto_alba_guatemala/constants/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final UserRole role;
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.role,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColors.primaryGreen,
      unselectedItemColor: Colors.grey,
      items: _getItemsForRole(role),
    );
  }

  List<BottomNavigationBarItem> _getItemsForRole(UserRole role) {
    switch (role) {
      case UserRole.senior:
        return const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.medication), label: 'Agenda'),
          BottomNavigationBarItem(icon: Icon(Icons.support_agent), label: 'Ayuda'),
        ];
      case UserRole.caregiver:
        return const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Monitor'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Botiquín'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ];
      case UserRole.doctor:
        return const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Pacientes'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Agenda'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ];
    }
  }
}
