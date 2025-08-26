import 'package:flutter/material.dart';

void main() => runApp(AdminApp());

class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Requests',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: SimpleRequestsScreen(),
    );
  }
}

class SimpleRequestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Requests'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SimpleRequestCard(
            name: 'Alice Johnson',
            id: 'REQ-001-A',
            status: 'Approved',
            equipment: 'Laptop (Lenovo ThinkPad)',
            date: '2024-07-20',
          ),
          SimpleRequestCard(
            name: 'Bob Smith',
            id: 'REQ-002-B',
            status: 'Pending',
            equipment: 'Monitor (Dell 24")',
            date: '2024-07-21',
          ),
          SimpleRequestCard(
            name: 'Carol White',
            id: 'REQ-003-C',
            status: 'Rejected',
            equipment: 'Keyboard (Mechanical)',
            date: '2024-07-22',
          ),
        ],
      ),
    );
  }
}

class SimpleRequestCard extends StatelessWidget {
  final String name;
  final String id;
  final String status;
  final String equipment;
  final String date;

  const SimpleRequestCard({
    Key? key,
    required this.name,
    required this.id,
    required this.status,
    required this.equipment,
    required this.date,
  }) : super(key: key);

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Color(0xFF517690);
      case 'Rejected':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: getStatusColor(status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: getStatusColor(status)),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: getStatusColor(status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Request ID: $id',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Equipment: $equipment',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'Date: $date',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
