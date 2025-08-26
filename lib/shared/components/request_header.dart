import 'package:flutter/material.dart';
import 'app_theme.dart';

class RequestHeader extends StatelessWidget {
  final String name;
  final String email;
  final String role;

  const RequestHeader({
    Key? key,
    required this.name,
    required this.email,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: ClipOval(
            child: Image.asset(
              'assets/images/avatar.png',
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to icon if image fails to load
                return Icon(
                  Icons.person, 
                  size: 40, 
                  color: AppColors.primary
                );
              },
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTextStyles.cardTitle.copyWith(fontSize: 20),
              ),
              SizedBox(height: 4),
              Text(
                email,
                style: AppTextStyles.cardMeta,
              ),
            ],
          ),
        ),
        Text(
          role,
          style: AppTextStyles.cardSubtitle.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
