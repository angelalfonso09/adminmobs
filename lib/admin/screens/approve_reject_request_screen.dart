import 'package:flutter/material.dart';
import '../components/widgets/action_buttons.dart';
import '../components/widgets/admin_notes_section.dart';
import '../components/dialogs/admin_confirmation_dialog.dart';
import '../components/modals/admin_notification_modal.dart';
import '../../shared/components/app_theme.dart';

class ApproveRejectRequestScreen extends StatefulWidget {
  final String? requestId;

  const ApproveRejectRequestScreen({super.key, this.requestId});

  @override
  ApproveRejectRequestScreenState createState() => ApproveRejectRequestScreenState();
}

class ApproveRejectRequestScreenState extends State<ApproveRejectRequestScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _handleApprove() {
    AdminConfirmationDialog.showApprovalConfirmation(
      context,
      requestId: widget.requestId ?? 'REQ-001',
      onConfirm: () {
        // Process approval logic here
        AdminNotificationModal.showApprovalNotification(
          context,
          requestId: widget.requestId ?? 'REQ-001',
          onConfirm: () {
            Navigator.of(context).pop(); // Go back to previous screen
          },
        );
      },
    );
  }

  void _handleReject() {
    AdminConfirmationDialog.showRejectionConfirmation(
      context,
      requestId: widget.requestId ?? 'REQ-001',
      onConfirm: () {
        // Process rejection logic here
        AdminNotificationModal.showRejectionNotification(
          context,
          requestId: widget.requestId ?? 'REQ-001',
          onConfirm: () {
            Navigator.of(context).pop(); // Go back to previous screen
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Request'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Request Details Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Request Details',
                      style: AppTextStyles.heading,
                    ),
                    const SizedBox(height: 16),
                    const Text('Requester: Alice Johnson'),
                    const SizedBox(height: 8),
                    Text('Request ID: ${widget.requestId ?? 'REQ-001'}'),
                    const SizedBox(height: 8),
                    const Text('Equipment: Laptop (Lenovo ThinkPad)'),
                    const SizedBox(height: 8),
                    const Text('Status: Pending'),
                    const SizedBox(height: 8),
                    const Text('Date: 2024-07-20'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Admin Notes Section
            AdminNotesSection(
              previousNotes: 'No previous admin notes.',
              commentController: _commentController,
            ),
            const SizedBox(height: 32),
            
            // Action Buttons
            ActionButtons(
              onApprove: _handleApprove,
              onReject: _handleReject,
            ),
          ],
        ),
      ),
    );
  }
}
