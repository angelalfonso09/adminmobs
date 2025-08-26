import 'package:flutter/material.dart';
import '../../features/requests/all_requests_screen.dart';
import 'status_badge.dart';
import 'app_theme.dart';
import 'request_details_modal.dart';

class RequestCard extends StatelessWidget {
  final Request request;
  const RequestCard({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8,
      ),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Navigate to details screen
            _showRequestDetails(context);
          },
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with name and status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request.requester,
                            style: AppTextStyles.cardTitle,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'ID: ${request.id}',
                            style: AppTextStyles.cardMeta,
                          ),
                        ],
                      ),
                    ),
                    StatusBadge(status: request.status),
                  ],
                ),
                
                SizedBox(height: 12.0),
                
                // Equipment info
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Equipment Type',
                        style: AppTextStyles.cardSubtitle,
                      ),
                      SizedBox(height: 4),
                      Text(
                        request.equipmentType,
                        style: AppTextStyles.cardBody,
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity',
                            style: AppTextStyles.cardSubtitle,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              request.quantity.toString(),
                              style: AppTextStyles.cardBody.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 12.0),
                
                // Footer with date and arrow
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 4),
                        Text(
                          request.date,
                          style: AppTextStyles.cardMeta,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textSecondary,
                      size: 16,
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

  void _showRequestDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RequestDetailsModal(request: request),
    );
  }
}
