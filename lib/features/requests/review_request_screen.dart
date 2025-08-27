import 'package:flutter/material.dart';
import '../../shared/components/notification_modal.dart';
import '../../shared/components/confirmation_dialog.dart';

class ReviewRequestScreen extends StatefulWidget {
  final String requestId;
  
  const ReviewRequestScreen({super.key, required this.requestId});

  @override
  ReviewRequestScreenState createState() => ReviewRequestScreenState();
}

class ReviewRequestScreenState extends State<ReviewRequestScreen> {
  final TextEditingController _adminCommentController = TextEditingController();

  @override
  void dispose() {
    _adminCommentController.dispose();
    super.dispose();
  }

  void _approveRequest() {
    // Show confirmation dialog first
    ConfirmationDialog.showApprovalConfirmation(
      context,
      requestId: widget.requestId,
      onConfirm: () {
        // After confirmation, show success notification
        NotificationModal.showApprovalNotification(
          context,
          requestId: widget.requestId,
          onConfirm: () {
            // Navigate back to previous screen after notification
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _rejectRequest() {
    // Show confirmation dialog first
    ConfirmationDialog.showRejectionConfirmation(
      context,
      requestId: widget.requestId,
      onConfirm: () {
        // After confirmation, show rejection notification
        NotificationModal.showRejectionNotification(
          context,
          requestId: widget.requestId,
          onConfirm: () {
            // Navigate back to previous screen after notification
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const String requesterName = "Alice Johnson";
    const String requesterEmail = "alice.j@entrypass.com";
    const String userRole = "User";

    final String requestId = widget.requestId;
    const String status = "Approved";
    const String submissionDate = "2024-07-20";
    const String securedBy = "2024-07-27";

    const String equipmentDetails = "Laptop (Lenovo ThinkPad)";
    const int quantity = 1;
    const String destination = "ComLab 502";
    const String purpose = ""; // Empty string since no purpose shown

    const String entryScheduleDate = "October 26, 2023";
    const String entryScheduleTime = "09:00 AM - 05:00 PM";
    const String entryScheduleLocation = "ComLab 501";

    const String previousAdminNotes =
        "Initial review complete. Awaiting additional details on material usage. Contacted requester for clarification.";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Avatar, Name, Email, Role
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(Icons.person, size: 40, color: Colors.blue),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(requesterName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(requesterEmail,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    const Text(userRole,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54)),
                  ],
                ),
                const SizedBox(height: 24),

                // Request ID and Status Row
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Request ID",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    Text("Status",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(requestId, style: const TextStyle(fontSize: 14)),
                    const Text(status,
                        style: TextStyle(
                            fontSize: 14,
                            color: status == "Approved"
                                ? Color(0xFF517690)
                                : (status == "Rejected"
                                    ? Colors.red
                                    : Colors.orange),
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 12),

                // Submission Date and Secured By Row
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Submission Date",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    Text("Secured By",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(submissionDate, style: TextStyle(fontSize: 14)),
                    Text(securedBy, style: TextStyle(fontSize: 14)),
                  ],
                ),
                const Divider(height: 32, thickness: 1),

                // Equipment Details & Entry Schedule
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column - Equipment Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Equipment Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                          const SizedBox(height: 8),
                          const Text(equipmentDetails, style: TextStyle(fontSize: 14)),
                          const SizedBox(height: 8),
                          const Text("Quantity",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14)),
                          Text(quantity.toString(), style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 8),
                          const Text("Destination",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14)),
                          const Text(destination, style: TextStyle(fontSize: 14)),
                          const SizedBox(height: 8),
                          const Text("Purpose",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14)),
                          Text(purpose.isNotEmpty ? purpose : "-", style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),

                    const SizedBox(width: 24),

                    // Right Column - Entry Schedule
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Entry Schedule",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                          SizedBox(height: 8),
                          Text(entryScheduleDate, style: TextStyle(fontSize: 14)),
                          Text(entryScheduleTime, style: TextStyle(fontSize: 14)),
                          Text(entryScheduleLocation, style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),

                const Divider(height: 32, thickness: 1),

                // Previous Admin Notes
                const Text("Previous Admin Notes",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                const SizedBox(height: 8),
                const Text(previousAdminNotes, style: TextStyle(fontSize: 14)),
                const SizedBox(height: 24),

                // Admin Comments Input
                const Text("Admin Comments (Optional)",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                const SizedBox(height: 8),
                TextField(
                  controller: _adminCommentController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Add your comments here...',
                  ),
                ),
                const SizedBox(height: 24),

                // Approve and Reject buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.check),
                        label: const Text('Approve'),
                        onPressed: _approveRequest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF517690),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.close),
                        label: const Text('Reject'),
                        onPressed: _rejectRequest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
