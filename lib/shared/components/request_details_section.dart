import 'package:flutter/material.dart';
import 'app_theme.dart';

class RequestDetailsSection extends StatelessWidget {
  final String equipmentDetails;
  final int quantity;
  final String destination;
  final String purpose;
  final String entryScheduleDate;
  final String entryScheduleTime;
  final String entryScheduleLocation;

  const RequestDetailsSection({
    super.key,
    required this.equipmentDetails,
    required this.quantity,
    required this.destination,
    required this.purpose,
    required this.entryScheduleDate,
    required this.entryScheduleTime,
    required this.entryScheduleLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Request Details',
          style: AppTextStyles.heading.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 16),
        
        // Equipment Details
        _buildDetailRow('Equipment', equipmentDetails),
        const SizedBox(height: 12),
        
        // Quantity
        _buildDetailRow('Quantity', quantity.toString()),
        const SizedBox(height: 12),
        
        // Destination
        _buildDetailRow('Destination', destination),
        const SizedBox(height: 12),
        
        // Purpose (if provided)
        if (purpose.isNotEmpty) ...[
          _buildDetailRow('Purpose', purpose),
          const SizedBox(height: 12),
        ],
        
        const SizedBox(height: 16),
        
        // Entry Schedule
        Text(
          'Entry Schedule',
          style: AppTextStyles.heading.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 16),
        
        _buildDetailRow('Date', entryScheduleDate),
        const SizedBox(height: 12),
        
        _buildDetailRow('Time', entryScheduleTime),
        const SizedBox(height: 12),
        
        _buildDetailRow('Location', entryScheduleLocation),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: AppTextStyles.cardSubtitle.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.cardBody.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
