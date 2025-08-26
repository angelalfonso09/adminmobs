import 'package:flutter/material.dart';
import 'app_theme.dart';

class AdminNotesSection extends StatelessWidget {
  final String previousNotes;
  final TextEditingController commentController;

  const AdminNotesSection({
    Key? key,
    required this.previousNotes,
    required this.commentController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Previous Admin Notes
        Text(
          "Previous Admin Notes",
          style: AppTextStyles.heading,
        ),
        SizedBox(height: 8),
        Text(previousNotes, style: AppTextStyles.cardBody),
        SizedBox(height: 24),

        // Admin Comments Input
        Text(
          "Admin Comments (Optional)",
          style: AppTextStyles.heading,
        ),
        SizedBox(height: 8),
        TextField(
          controller: commentController,
          maxLines: 3,
          style: AppTextStyles.cardBody,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.cardBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.cardBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            hintText: 'Add your comments here...',
            hintStyle: TextStyle(color: AppColors.textSecondary),
            contentPadding: EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}
