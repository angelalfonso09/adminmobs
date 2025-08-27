import 'package:flutter/material.dart';
import '../../components/app_theme.dart';
import 'approve_reject_request_screen.dart';

void main() => runApp(const ApproveRejectRequestApp());

class ApproveRejectRequestApp extends StatelessWidget {
  const ApproveRejectRequestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Approve/Reject Request',
      theme: AppTheme.theme,
      home: const ApproveRejectRequestScreen(),
    );
  }
}
