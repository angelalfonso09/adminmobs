import 'package:flutter/material.dart';
import '../models/entry_log.dart';

class EntryLogCard extends StatelessWidget {
  final EntryLog log;

  const EntryLogCard({Key? key, required this.log}) : super(key: key);

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

  IconData getRoleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'student':
        return Icons.school;
      case 'faculty':
        return Icons.work;
      case 'visitor':
        return Icons.person_outline;
      case 'security officer':
        return Icons.security;
      default:
        return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with name and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xFF517690).withOpacity(0.1),
                        child: Icon(
                          getRoleIcon(log.role), 
                          color: Color(0xFF517690),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              log.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              log.role,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: getStatusColor(log.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: getStatusColor(log.status)),
                  ),
                  child: Text(
                    log.status,
                    style: TextStyle(
                      color: getStatusColor(log.status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 12),
            
            // Entry details
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildDetailRow(Icons.access_time, 'Time', log.time),
                  SizedBox(height: 8),
                  _buildDetailRow(Icons.location_on, 'Location', log.location),
                  SizedBox(height: 8),
                  _buildDetailRow(Icons.calendar_today, 'Date', log.date),
                  SizedBox(height: 8),
                  _buildDetailRow(Icons.confirmation_number, 'Log ID', log.id),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
            fontSize: 13,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
