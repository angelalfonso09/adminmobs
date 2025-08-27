import 'package:flutter/material.dart';

void main() => runApp(const AdminApp());

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Requests',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      home: const SimpleRequestsScreen(),
    );
  }
}

class SimpleRequestsScreen extends StatelessWidget {
  const SimpleRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Requests'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SimpleRequestCard(
            name: 'Maria Santos',
            id: 'REQ-001-A',
            status: 'Approved',
            equipment: 'Laptop (Lenovo ThinkPad)',
            date: '2024-07-20',
          ),
          SimpleRequestCard(
            name: 'James Rodriguez',
            id: 'REQ-002-B',
            status: 'Pending',
            equipment: 'Monitor (Dell 24")',
            date: '2024-07-21',
          ),
          SimpleRequestCard(
            name: 'Sarah Kim',
            id: 'REQ-003-C',
            status: 'Rejected',
            equipment: 'Keyboard (Mechanical)',
            date: '2024-07-22',
          ),
          SimpleRequestCard(
            name: 'Michael Chen',
            id: 'REQ-004-D',
            status: 'Approved',
            equipment: 'Mouse (Wireless)',
            date: '2024-07-23',
          ),
          SimpleRequestCard(
            name: 'Jessica Thompson',
            id: 'REQ-005-E',
            status: 'Pending',
            equipment: 'Headset (Bluetooth)',
            date: '2024-07-24',
          ),
          SimpleRequestCard(
            name: 'David Martinez',
            id: 'REQ-006-F',
            status: 'Rejected',
            equipment: 'Webcam (HD)',
            date: '2024-07-25',
          ),
          SimpleRequestCard(
            name: 'Lisa Anderson',
            id: 'REQ-007-G',
            status: 'Approved',
            equipment: 'Docking Station',
            date: '2024-07-26',
          ),
          SimpleRequestCard(
            name: 'Robery Garcia',
            id: 'REQ-008-H',
            status: 'Pending',
            equipment: 'External Hard Drive',
            date: '2024-07-27',
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
    super.key,
    required this.name,
    required this.id,
    required this.status,
    required this.equipment,
    required this.date,
  });

  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return const Color(0xFF517690);
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
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            const SizedBox(height: 8),
            Text(
              'Request ID: $id',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Equipment: $equipment',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
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
