import 'package:flutter/material.dart';
import '../models/user.dart';

class UserCard extends StatelessWidget {
  final User user;
  final int index;
  final Function(int) onEdit;
  final Function(int) onToggleStatus;

  const UserCard({
    Key? key,
    required this.user,
    required this.index,
    required this.onEdit,
    required this.onToggleStatus,
  }) : super(key: key);

  Color getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Color(0xFF517690);
      case 'Inactive':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color getRoleColor(String role) {
    switch (role) {
      case 'Admin':
        return Colors.purple;
      case 'User':
        return Color(0xFF517690);
      default:
        return Colors.grey;
    }
  }

  IconData getUserIcon(bool isFemale) {
    return isFemale ? Icons.person : Icons.person_outline;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Header with avatar and basic info
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Color(0xFF517690).withOpacity(0.1),
                  child: Icon(
                    getUserIcon(user.isFemale),
                    size: 32,
                    color: Color(0xFF517690),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'ID: ${user.id}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                // Status badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: getStatusColor(user.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: getStatusColor(user.status)),
                  ),
                  child: Text(
                    user.status,
                    style: TextStyle(
                      color: getStatusColor(user.status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // User details
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailColumn('Role', user.role, getRoleColor(user.role)),
                      ),
                      Expanded(
                        child: _buildDetailColumn('Department', user.department, Colors.grey[700]!),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _buildDetailRow(Icons.calendar_today, 'Joined', user.joinDate),
                ],
              ),
            ),
            
            SizedBox(height: 16),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => onEdit(index),
                    icon: Icon(Icons.edit, size: 18),
                    label: Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Color(0xFF517690),
                      side: BorderSide(color: Color(0xFF517690)),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => onToggleStatus(index),
                    icon: Icon(
                      user.status == 'Active' ? Icons.toggle_off : Icons.toggle_on,
                      size: 18,
                    ),
                    label: Text(user.status == 'Active' ? 'Disable' : 'Enable'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: user.status == 'Active' ? Colors.red : Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
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
