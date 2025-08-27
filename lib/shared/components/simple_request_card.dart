import 'package:flutter/material.dart';
import '../../features/requests/models/request.dart';

class RequestCard extends StatelessWidget {
  final Request request;
  
  const RequestCard({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(request.requester),
        subtitle: Text(request.status),
        trailing: Text(request.equipmentType),
      ),
    );
  }
}
