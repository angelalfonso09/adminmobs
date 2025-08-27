import 'package:flutter/material.dart';
import '../components/app_theme.dart';
import '../../features/requests/models/request.dart';

class RequestDetailsModal extends StatelessWidget {
  final Request request;

  const RequestDetailsModal({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.divider)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Request Details',
                  style: AppTextStyles.heading.copyWith(fontSize: 22),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // User Avatar
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/avatar.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback to icon if image fails to load
                          return const Icon(
                            Icons.person, 
                            size: 50, 
                            color: AppColors.primary
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  _buildDetailItem('Requester', request.requester),
                  const SizedBox(height: 24),
                  _buildDetailItem('Request ID', request.id),
                  const SizedBox(height: 24),
                  _buildDetailItem('Status', request.status, isStatus: true),
                  const SizedBox(height: 24),
                  _buildDetailItem('Equipment Type', request.equipmentType),
                  const SizedBox(height: 24),
                  _buildDetailItem('Quantity', request.quantity.toString()),
                  const SizedBox(height: 24),
                  _buildDetailItem('Date', request.date),
                ],
              ),
            ),
          ),
          
          // Review Request Button
          if (request.status.toLowerCase() == 'pending')
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.divider)),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close modal
                    Navigator.of(context).pushNamed('/review_request', arguments: request);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Review Request',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, {bool isStatus = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.cardSubtitle.copyWith(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.cardBody.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isStatus ? _getStatusColor(value) : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return AppColors.approved;
      case 'rejected':
        return AppColors.rejected;
      case 'pending':
        return AppColors.pending;
      default:
        return AppColors.textPrimary;
    }
  }
}
