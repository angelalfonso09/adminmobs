import 'package:flutter/material.dart';
import '../../../shared/components/app_theme.dart';

class AdminConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Color confirmColor;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const AdminConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    this.cancelText = 'Cancel',
    required this.confirmColor,
    required this.onConfirm,
    this.onCancel,
  });

  static void showApprovalConfirmation(
    BuildContext context, {
    required String requestId,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AdminConfirmationDialog(
          title: 'Approve Request',
          message: 'Are you sure you want to approve request $requestId?',
          confirmText: 'Approve',
          confirmColor: AppColors.approved,
          onConfirm: onConfirm,
        );
      },
    );
  }

  static void showRejectionConfirmation(
    BuildContext context, {
    required String requestId,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AdminConfirmationDialog(
          title: 'Reject Request',
          message: 'Are you sure you want to reject request $requestId?',
          confirmText: 'Reject',
          confirmColor: AppColors.rejected,
          onConfirm: onConfirm,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(
        title,
        style: AppTextStyles.heading.copyWith(fontSize: 20),
      ),
      content: Text(
        message,
        style: AppTextStyles.cardBody.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onCancel != null) onCancel!();
          },
          child: Text(
            cancelText,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmColor,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          child: Text(
            confirmText,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
