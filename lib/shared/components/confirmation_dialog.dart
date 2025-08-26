import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final Color confirmColor;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.confirmText,
    this.cancelText = 'Cancel',
    required this.confirmColor,
    required this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  static void showApprovalConfirmation(
    BuildContext context, {
    required String requestId,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Approve Request',
          message: 'Are you sure you want to approve request $requestId?',
          confirmText: 'Approve',
          confirmColor: Color(0xFF517690),
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
        return ConfirmationDialog(
          title: 'Reject Request',
          message: 'Are you sure you want to reject request $requestId?',
          confirmText: 'Reject',
          confirmColor: Colors.red,
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
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onCancel != null) {
              onCancel!();
            }
          },
          child: Text(
            cancelText,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            confirmText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
