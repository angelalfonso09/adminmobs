import 'package:flutter/material.dart';
import '../../../shared/components/app_theme.dart';

class AdminNotesSection extends StatelessWidget {
  final String previousNotes;
  final TextEditingController commentController;

  const AdminNotesSection({
    super.key,
    required this.previousNotes,
    required this.commentController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Previous Admin Notes
        const Text(
          "Previous Admin Notes",
          style: AppTextStyles.heading,
        ),
        const SizedBox(height: 8),
        Text(previousNotes, style: AppTextStyles.cardBody),
        const SizedBox(height: 24),

        // Admin Comments Input
        const Text(
          "Admin Comments (Optional)",
          style: AppTextStyles.heading,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: commentController,
          maxLines: 3,
          style: AppTextStyles.cardBody,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.cardBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.cardBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            hintText: 'Add your comments here...',
            hintStyle: const TextStyle(color: AppColors.textSecondary),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}
