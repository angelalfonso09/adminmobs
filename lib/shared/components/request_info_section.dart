import 'package:flutter/material.dart';
import 'app_theme.dart';

class RequestInfoSection extends StatelessWidget {
  final String requestId;
  final String status;
  final String submissionDate;
  final String securedBy;

  const RequestInfoSection({
    Key? key,
    required this.requestId,
    required this.status,
    required this.submissionDate,
    required this.securedBy,
  }) : super(key: key);

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return AppColors.approved;
      case 'rejected':
        return AppColors.rejected;
      case 'pending':
        return AppColors.pending;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Request ID and Status Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Request ID",
              style: AppTextStyles.cardSubtitle,
            ),
            Text(
              "Status",
              style: AppTextStyles.cardSubtitle,
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(requestId, style: AppTextStyles.cardBody),
            Text(
              status,
              style: AppTextStyles.cardSubtitle.copyWith(
                color: _getStatusColor(status),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // Submission Date and Secured By Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Submission Date",
              style: AppTextStyles.cardSubtitle,
            ),
            Text(
              "Secured By",
              style: AppTextStyles.cardSubtitle,
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(submissionDate, style: AppTextStyles.cardBody),
            Text(securedBy, style: AppTextStyles.cardBody),
          ],
        ),
      ],
    );
  }
}
