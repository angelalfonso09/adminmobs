import 'package:flutter/material.dart';
import 'components/app_theme.dart';
import 'approve_reject_request_screen.dart';

void main() => runApp(ApproveRejectRequestApp());

class ApproveRejectRequestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Approve/Reject Request',
      theme: AppTheme.theme,
      home: ApproveRejectRequestScreen(),
    );
  }
}
