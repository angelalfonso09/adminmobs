import 'package:flutter/material.dart';
import '../../shared/components/app_theme.dart';
import '../../shared/components/request_header.dart';
import '../../shared/components/request_info_section.dart';
import '../../shared/components/request_details_section.dart';
import '../../shared/components/admin_notes_section.dart';
import '../../shared/components/action_buttons.dart';

class ApproveRejectRequestScreen extends StatefulWidget {
  final String requestId;
  
  const ApproveRejectRequestScreen({super.key, this.requestId = "EP-2024-001"});

  @override
  ApproveRejectRequestScreenState createState() =>
      ApproveRejectRequestScreenState();
}

class ApproveRejectRequestScreenState extends State<ApproveRejectRequestScreen> {
  final TextEditingController _adminCommentController = TextEditingController();

  @override
  void dispose() {
    _adminCommentController.dispose();
    super.dispose();
  }

  void _approveRequest() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Request Approved'),
        content: const Text('You have approved the request.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'))
        ],
      ),
    );
  }

  void _rejectRequest() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Request Rejected'),
        content: const Text('You have rejected the request.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sample data - in real app this would come from API/database
    final requestData = <String, dynamic>{
      'requesterName': "Alice Johnson",
      'requesterEmail': "alice.j@entrypass.com",
      'userRole': "User",
      'requestId': widget.requestId,
      'status': "Approved",
      'submissionDate': "2024-07-20",
      'securedBy': "2024-07-27",
      'equipmentDetails': "Laptop (Lenovo ThinkPad)",
      'quantity': 1,
      'destination': "ComLab 502",
      'purpose': "",
      'entryScheduleDate': "October 26, 2023",
      'entryScheduleTime': "09:00 AM - 05:00 PM",
      'entryScheduleLocation': "ComLab 501",
      'previousAdminNotes': "Initial review complete. Awaiting additional details on material usage. Contacted requester for clarification.",
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Details'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with user info
                RequestHeader(
                  name: requestData['requesterName'] as String,
                  email: requestData['requesterEmail'] as String,
                  role: requestData['userRole'] as String,
                ),
                
                const SizedBox(height: 24),

                // Request info section
                RequestInfoSection(
                  requestId: requestData['requestId'] as String,
                  status: requestData['status'] as String,
                  submissionDate: requestData['submissionDate'] as String,
                  securedBy: requestData['securedBy'] as String,
                ),

                const Divider(height: 32, thickness: 1, color: AppColors.divider),

                // Equipment details and entry schedule
                RequestDetailsSection(
                  equipmentDetails: requestData['equipmentDetails'] as String,
                  quantity: requestData['quantity'] as int,
                  destination: requestData['destination'] as String,
                  purpose: requestData['purpose'] as String,
                  entryScheduleDate: requestData['entryScheduleDate'] as String,
                  entryScheduleTime: requestData['entryScheduleTime'] as String,
                  entryScheduleLocation: requestData['entryScheduleLocation'] as String,
                ),

                const Divider(height: 32, thickness: 1, color: AppColors.divider),

                // Admin notes section
                AdminNotesSection(
                  previousNotes: requestData['previousAdminNotes'] as String,
                  commentController: _adminCommentController,
                ),

                const SizedBox(height: 24),

                // Action buttons
                ActionButtons(
                  onApprove: _approveRequest,
                  onReject: _rejectRequest,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
