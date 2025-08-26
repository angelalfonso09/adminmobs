import 'package:flutter/material.dart';
import 'app_theme.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const ActionButtons({
    Key? key,
    required this.onApprove,
    required this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(Icons.check, color: Colors.white),
            label: Text(
              'Approve',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: onApprove,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.approved,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(Icons.close, color: Colors.white),
            label: Text(
              'Reject',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: onReject,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.rejected,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
            ),
          ),
        ),
      ],
    );
  }
}
