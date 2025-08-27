import 'package:flutter/material.dart';
import '../../../shared/components/app_theme.dart';

class AdminNotificationModal extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback? onConfirm;
  final String confirmText;

  const AdminNotificationModal({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    this.onConfirm,
    this.confirmText = 'OK',
  });

  static void showApprovalNotification(
    BuildContext context, {
    required String requestId,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AdminNotificationModal(
          title: 'Request Approved',
          message: 'Request $requestId has been successfully approved.',
          icon: Icons.check_circle,
          iconColor: AppColors.approved,
          backgroundColor: AppColors.approved.withOpacity(0.1),
          onConfirm: onConfirm,
          confirmText: 'Continue',
        );
      },
    );
  }

  static void showRejectionNotification(
    BuildContext context, {
    required String requestId,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AdminNotificationModal(
          title: 'Request Rejected',
          message: 'Request $requestId has been rejected.',
          icon: Icons.cancel,
          iconColor: AppColors.rejected,
          backgroundColor: AppColors.rejected.withOpacity(0.1),
          onConfirm: onConfirm,
          confirmText: 'Continue',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with background
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 32,
              ),
            ),
            const SizedBox(height: 24),
            
            // Title
            Text(
              title,
              style: AppTextStyles.heading.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            
            // Message
            Text(
              message,
              style: AppTextStyles.cardBody.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) onConfirm!();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  confirmText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
