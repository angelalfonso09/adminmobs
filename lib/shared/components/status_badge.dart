import 'package:flutter/material.dart';
import 'app_theme.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    
    switch (status) {
      case 'Approved':
        backgroundColor = AppColors.approved.withOpacity(0.1);
        textColor = AppColors.approved;
        break;
      case 'Rejected':
        backgroundColor = AppColors.rejected;
        textColor = Colors.white;
        break;
      case 'Pending':
        backgroundColor = AppColors.pending.withOpacity(0.1);
        textColor = AppColors.pending;
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status,
        style: AppTextStyles.statusBadge.copyWith(color: textColor),
      ),
    );
  }
}
