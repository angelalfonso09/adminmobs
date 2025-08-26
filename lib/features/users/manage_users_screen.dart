import 'package:flutter/material.dart';
import '../../shared/models/user.dart';
import '../../shared/components/user_card.dart';

class ManageUsersScreen extends StatefulWidget {
  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedRoleFilter = 'All';
  String selectedStatusFilter = 'All';
  List<User> filteredUsers = [];
  int _currentIndex = 3; // Users tab
  bool showArchive = false; // Archive view toggle

  final List<String> roles = ['All', 'Admin', 'User'];
  final List<String> statuses = ['All', 'Active', 'Inactive'];

  @override
  void initState() {
    super.initState();
    _updateFilteredUsers();
  }

  void _updateFilteredUsers() {
    List<User> users = UserData.getAllUsers();
    
    // Apply archive filter first
    if (showArchive) {
      // Show only disabled/inactive users in archive view
      users = users.where((user) => user.status == 'Inactive').toList();
    } else {
      // Show only active users in normal view
      users = users.where((user) => user.status == 'Active').toList();
    }
    
    // Apply role filter
    if (selectedRoleFilter != 'All') {
      users = users.where((user) => user.role == selectedRoleFilter).toList();
    }
    
    // Apply status filter (only relevant in normal view when showing all statuses)
    if (!showArchive && selectedStatusFilter != 'All') {
      users = users.where((user) => user.status == selectedStatusFilter).toList();
    }
    
    // Apply search filter
    if (_searchController.text.isNotEmpty) {
      users = users.where((user) => 
        user.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        user.email.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        user.department.toLowerCase().contains(_searchController.text.toLowerCase())
      ).toList();
    }

    setState(() {
      filteredUsers = users;
    });
  }

  void _onSearchChanged(String query) {
    _updateFilteredUsers();
  }

  void _editUser(int index) {
    final user = filteredUsers[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Row(
            children: [
              Icon(Icons.edit, color: Color(0xFF517690)),
              SizedBox(width: 8),
              Text('Edit User'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User: ${user.name}', style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 4),
              Text('Email: ${user.email}'),
              SizedBox(height: 4),
              Text('Role: ${user.role}'),
              SizedBox(height: 4),
              Text('Department: ${user.department}'),
              SizedBox(height: 16),
              Text('Edit functionality would be implemented here.', 
                   style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[600])),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Edit functionality for ${user.name} coming soon!'),
                    backgroundColor: Color(0xFF517690),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF517690)),
              child: Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  void _toggleUserStatus(int index) {
    final user = filteredUsers[index];
    final newStatus = user.status == 'Active' ? 'Inactive' : 'Active';
    final actionWord = user.status == 'Active' ? 'disable' : 'enable';
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Row(
            children: [
              Icon(
                user.status == 'Active' ? Icons.toggle_off : Icons.toggle_on,
                color: user.status == 'Active' ? Colors.red : Colors.green,
              ),
              SizedBox(width: 8),
              Text('${actionWord.substring(0, 1).toUpperCase()}${actionWord.substring(1)} ${user.role}'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Are you sure you want to $actionWord this ${user.role.toLowerCase()}?'),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User Details:', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Name: ${user.name}'),
                    Text('Email: ${user.email}'),
                    Text('Role: ${user.role}'),
                    Text('Department: ${user.department}'),
                    Text('Current Status: ${user.status}'),
                  ],
                ),
              ),
              SizedBox(height: 12),
              if (user.status == 'Active')
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'This ${user.role.toLowerCase()} will lose access to the system immediately.',
                          style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'This ${user.role.toLowerCase()} will regain access to the system.',
                          style: TextStyle(color: Colors.green.shade700, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _performStatusToggle(user, newStatus);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: user.status == 'Active' ? Colors.red : Colors.green,
              ),
              child: Text('${actionWord.substring(0, 1).toUpperCase()}${actionWord.substring(1)} ${user.role}'),
            ),
          ],
        );
      },
    );
  }

  void _performStatusToggle(User user, String newStatus) {
    // Update the user status in the data model
    UserData.updateUserStatus(user.id, newStatus);
    
    // Refresh the filtered users list
    _updateFilteredUsers();
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              newStatus == 'Active' ? Icons.check_circle : Icons.cancel,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                '${user.name} (${user.role}) has been ${newStatus.toLowerCase()}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: newStatus == 'Active' ? Colors.green : Colors.red,
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () {
            // Undo the status change
            UserData.updateUserStatus(user.id, user.status);
            _updateFilteredUsers();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Status change undone for ${user.name}'),
                backgroundColor: Color(0xFF517690),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleNavigation(int index) {
    switch (index) {
      case 0:
        // Navigate to Home screen
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        break;
      case 1:
        // Navigate to All Requests screen
        Navigator.pushNamedAndRemoveUntil(context, '/requests', (route) => false);
        break;
      case 2:
        // Navigate to Search screen
        Navigator.pushNamed(context, '/search');
        break;
      case 3:
        // Already on Users screen
        break;
      case 4:
        // Navigate to Entry Logs screen
        Navigator.pushNamed(context, '/entry-logs');
        break;
    }
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature coming soon!'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF517690),
      ),
    );
  }

  void _showBulkActionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Row(
            children: [
              Icon(Icons.settings, color: Color(0xFF517690)),
              SizedBox(width: 8),
              Text('Bulk User Actions'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Choose a bulk action to perform:'),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('Enable All Users'),
                subtitle: Text('Activate all inactive users'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmBulkAction('enable');
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel, color: Colors.red),
                title: Text('Disable All Users'),
                subtitle: Text('Deactivate all active users'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmBulkAction('disable');
                },
              ),
              ListTile(
                leading: Icon(Icons.admin_panel_settings, color: Colors.purple),
                title: Text('Enable All Admins'),
                subtitle: Text('Activate all inactive admin users'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmBulkAction('enable_admins');
                },
              ),
              ListTile(
                leading: Icon(Icons.people, color: Color(0xFF517690)),
                title: Text('Enable All Regular Users'),
                subtitle: Text('Activate all inactive regular users'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmBulkAction('enable_users');
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _confirmBulkAction(String action) {
    String title = '';
    String description = '';
    Color color = Color(0xFF517690);
    
    switch (action) {
      case 'enable':
        title = 'Enable All Users';
        description = 'This will activate all inactive users (both Admins and regular Users).';
        color = Colors.green;
        break;
      case 'disable':
        title = 'Disable All Users';
        description = 'This will deactivate all active users (both Admins and regular Users).';
        color = Colors.red;
        break;
      case 'enable_admins':
        title = 'Enable All Admins';
        description = 'This will activate all inactive Admin users only.';
        color = Colors.purple;
        break;
      case 'enable_users':
        title = 'Enable All Regular Users';
        description = 'This will activate all inactive regular Users only.';
        color = Color(0xFF517690);
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 8),
              Text('Confirm Bulk Action'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Action: $title', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(description),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.orange, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This action cannot be undone automatically. You\'ll need to manually change individual user statuses if needed.',
                        style: TextStyle(color: Colors.orange.shade700, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _performBulkAction(action);
              },
              style: ElevatedButton.styleFrom(backgroundColor: color),
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _performBulkAction(String action) {
    List<User> users = UserData.getAllUsers();
    int updatedCount = 0;
    
    switch (action) {
      case 'enable':
        for (User user in users) {
          if (user.status == 'Inactive') {
            UserData.updateUserStatus(user.id, 'Active');
            updatedCount++;
          }
        }
        break;
      case 'disable':
        for (User user in users) {
          if (user.status == 'Active') {
            UserData.updateUserStatus(user.id, 'Inactive');
            updatedCount++;
          }
        }
        break;
      case 'enable_admins':
        for (User user in users) {
          if (user.status == 'Inactive' && user.role == 'Admin') {
            UserData.updateUserStatus(user.id, 'Active');
            updatedCount++;
          }
        }
        break;
      case 'enable_users':
        for (User user in users) {
          if (user.status == 'Inactive' && user.role == 'User') {
            UserData.updateUserStatus(user.id, 'Active');
            updatedCount++;
          }
        }
        break;
    }
    
    _updateFilteredUsers();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bulk action completed. $updatedCount user(s) updated.'),
        backgroundColor: Color(0xFF517690),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showRestoreOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Row(
            children: [
              Icon(Icons.restore, color: Colors.green),
              SizedBox(width: 8),
              Text('Restore Archived Users'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Choose users to restore from archive:'),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.person_add, color: Colors.green),
                title: Text('Restore All Archived Users'),
                subtitle: Text('Restore all archived users to active status'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmRestoreAction('restore_all');
                },
              ),
              ListTile(
                leading: Icon(Icons.admin_panel_settings, color: Colors.purple),
                title: Text('Restore Archived Admins Only'),
                subtitle: Text('Restore only archived admin users'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmRestoreAction('restore_admins');
                },
              ),
              ListTile(
                leading: Icon(Icons.people, color: Color(0xFF517690)),
                title: Text('Restore Archived Users Only'),
                subtitle: Text('Restore only archived regular users'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmRestoreAction('restore_users');
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _confirmRestoreAction(String action) {
    String title = '';
    String description = '';
    
    switch (action) {
      case 'restore_all':
        title = 'Restore All Archived Users';
        description = 'This will restore all archived users (both Admins and regular Users) to active status.';
        break;
      case 'restore_admins':
        title = 'Restore Archived Admins';
        description = 'This will restore all archived Admin users to active status.';
        break;
      case 'restore_users':
        title = 'Restore Archived Users';
        description = 'This will restore all archived regular Users to active status.';
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Row(
            children: [
              Icon(Icons.info, color: Colors.blue),
              SizedBox(width: 8),
              Text('Confirm Restore'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Action: $title', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(description),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Restored users will regain access to the system immediately.',
                        style: TextStyle(color: Colors.green.shade700, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _performRestoreAction(action);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Restore'),
            ),
          ],
        );
      },
    );
  }

  void _performRestoreAction(String action) {
    List<User> users = UserData.getAllUsers();
    int restoredCount = 0;
    
    switch (action) {
      case 'restore_all':
        for (User user in users) {
          if (user.status == 'Inactive') {
            UserData.updateUserStatus(user.id, 'Active');
            restoredCount++;
          }
        }
        break;
      case 'restore_admins':
        for (User user in users) {
          if (user.status == 'Inactive' && user.role == 'Admin') {
            UserData.updateUserStatus(user.id, 'Active');
            restoredCount++;
          }
        }
        break;
      case 'restore_users':
        for (User user in users) {
          if (user.status == 'Inactive' && user.role == 'User') {
            UserData.updateUserStatus(user.id, 'Active');
            restoredCount++;
          }
        }
        break;
    }
    
    _updateFilteredUsers();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Restore completed. $restoredCount user(s) restored from archive.'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(showArchive ? 'User Archive' : 'Manage Users'),
            if (showArchive) ...[
              SizedBox(width: 8),
              Icon(Icons.archive, size: 20),
            ],
          ],
        ),
        backgroundColor: showArchive ? Colors.grey.shade700 : Color(0xFF517690),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(showArchive ? Icons.unarchive : Icons.archive),
            tooltip: showArchive ? 'Show Active Users' : 'Show Archived Users',
            onPressed: () {
              setState(() {
                showArchive = !showArchive;
                // Reset filters when switching views
                selectedRoleFilter = 'All';
                selectedStatusFilter = 'All';
                _searchController.clear();
              });
              _updateFilteredUsers();
            },
          ),
          if (!showArchive)
            IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                _showComingSoon('Add User');
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey.shade50,
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF517690)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                hintText: showArchive 
                  ? 'Search archived users by name, email, or department...'
                  : 'Search users by name, email, or department...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[600]),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
              ),
            ),
          ),

          // User status summary
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              children: [
                if (!showArchive) ...[
                  Expanded(
                    child: _buildStatusSummaryCard(
                      'Active Users',
                      UserData.getActiveUsersCount(),
                      Colors.green,
                      Icons.check_circle,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildStatusSummaryCard(
                      'Inactive Users',
                      UserData.getInactiveUsersCount(),
                      Colors.red,
                      Icons.cancel,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildStatusSummaryCard(
                      'Total Users',
                      UserData.getAllUsers().length,
                      Color(0xFF517690),
                      Icons.people,
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: _buildStatusSummaryCard(
                      'Archived Admins',
                      UserData.getAllUsers().where((u) => u.status == 'Inactive' && u.role == 'Admin').length,
                      Colors.purple,
                      Icons.admin_panel_settings,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildStatusSummaryCard(
                      'Archived Users',
                      UserData.getAllUsers().where((u) => u.status == 'Inactive' && u.role == 'User').length,
                      Colors.orange,
                      Icons.person,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildStatusSummaryCard(
                      'Total Archived',
                      UserData.getInactiveUsersCount(),
                      Colors.grey,
                      Icons.archive,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Filter dropdowns
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey.shade50,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Role', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                      SizedBox(height: 4),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF517690)),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: DropdownButton<String>(
                          value: selectedRoleFilter,
                          isExpanded: true,
                          underline: SizedBox(),
                          icon: Icon(Icons.arrow_drop_down, color: Color(0xFF517690)),
                          style: TextStyle(color: Color(0xFF517690), fontWeight: FontWeight.w600),
                          items: roles.map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              )).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRoleFilter = newValue!;
                            });
                            _updateFilteredUsers();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (!showArchive) ...[
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF517690)),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: DropdownButton<String>(
                            value: selectedStatusFilter,
                            isExpanded: true,
                            underline: SizedBox(),
                            icon: Icon(Icons.arrow_drop_down, color: Color(0xFF517690)),
                            style: TextStyle(color: Color(0xFF517690), fontWeight: FontWeight.w600),
                            items: statuses.map((String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                )).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedStatusFilter = newValue!;
                              });
                              _updateFilteredUsers();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.grey.shade600, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'Showing archived users only',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Results info
          if (filteredUsers.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey.shade50,
              child: Row(
                children: [
                  Icon(Icons.people, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Text(
                    'Showing ${filteredUsers.length} user${filteredUsers.length != 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

          // Users list
          Expanded(
            child: filteredUsers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          showArchive 
                            ? Icons.archive_outlined
                            : _searchController.text.isNotEmpty 
                              ? Icons.search_off 
                              : Icons.people_outline,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          showArchive
                            ? 'No archived users found'
                            : _searchController.text.isNotEmpty 
                              ? 'No users found' 
                              : 'No users available',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          showArchive
                            ? 'No users have been archived yet'
                            : _searchController.text.isNotEmpty
                              ? 'Try a different search term or adjust your filters'
                              : 'No users found with the selected filters',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: 16),
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      return UserCard(
                        user: filteredUsers[index],
                        index: index,
                        onEdit: _editUser,
                        onToggleStatus: _toggleUserStatus,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: showArchive 
        ? FloatingActionButton.extended(
            onPressed: () {
              _showRestoreOptionsDialog();
            },
            backgroundColor: Colors.green,
            icon: Icon(Icons.restore, color: Colors.white),
            label: Text('Restore Users', style: TextStyle(color: Colors.white)),
          )
        : FloatingActionButton.extended(
            onPressed: () {
              _showBulkActionsDialog();
            },
            backgroundColor: Color(0xFF517690),
            icon: Icon(Icons.settings, color: Colors.white),
            label: Text('Bulk Actions', style: TextStyle(color: Colors.white)),
          ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          _handleNavigation(index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF517690),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'All Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Entry Logs',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildStatusSummaryCard(String title, int count, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
