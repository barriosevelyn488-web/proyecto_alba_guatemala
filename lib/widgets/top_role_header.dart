import 'package:flutter/material.dart';
import 'package:proyecto_alba_guatemala/models/user_model.dart';

class TopRoleHeader extends StatelessWidget {
  final UserRole activeRole;
  final Function(UserRole) onRoleChanged;
  final List<UserRole> availableRoles;

  const TopRoleHeader({
    super.key,
    required this.activeRole,
    required this.onRoleChanged,
    required this.availableRoles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Viendo como: '),
          DropdownButton<UserRole>(
            value: activeRole,
            onChanged: (UserRole? newValue) {
              if (newValue != null) {
                onRoleChanged(newValue);
              }
            },
            items: availableRoles.map<DropdownMenuItem<UserRole>>((UserRole value) {
              return DropdownMenuItem<UserRole>(
                value: value,
                child: Text(value.toString().split('.').last),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
