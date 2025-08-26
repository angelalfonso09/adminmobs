import 'package:flutter/material.dart';

class NotificationModal extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback? onConfirm;
  final String confirmText;

  const NotificationModal({
    Key? key,
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    this.onConfirm,
    this.confirmText = 'OK',
  }) : super(key: key);

  static void showApprovalNotification(
    BuildContext context, {
    required String requestId,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return NotificationModal(
          title: 'Request Approved',
          message: 'Request $requestId has been successfully approved.',
          icon: Icons.check_circle,
          iconColor: Color(0xFF517690),
          backgroundColor: Color(0xFF517690).withOpacity(0.1),
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
        return NotificationModal(
          title: 'Request Rejected',
          message: 'Request $requestId has been rejected.',
          icon: Icons.cancel,
          iconColor: Colors.red,
          backgroundColor: Colors.red.withOpacity(0.1),
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
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with background
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: iconColor,
              ),
            ),
            SizedBox(height: 24),
            
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            
            // Message
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            
            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onConfirm != null) {
                    onConfirm!();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: iconColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
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
            ),
          ],
        ),
      ),
    );
  }
}
