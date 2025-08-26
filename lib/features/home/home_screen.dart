import 'package:flutter/material.dart';
import '../../shared/models/request_data.dart';
import '../../shared/models/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Home tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Color(0xFF517690),
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              _showComingSoon('Notifications');
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showComingSoon('Settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome header
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF517690),
                    Color(0xFF517690).withOpacity(0.8),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.admin_panel_settings,
                          size: 30,
                          color: Color(0xFF517690),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back, Admin!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Manage your system efficiently',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Dashboard stats
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dashboard Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Stats cards
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildStatCard(
                        'Total Requests',
                        RequestData.searchRequests().length.toString(),
                        Icons.description,
                        Color(0xFF517690),
                        () => _navigateToRequests(),
                      ),
                      _buildStatCard(
                        'Active Users',
                        UserData.getActiveUsersCount().toString(),
                        Icons.people,
                        Colors.green,
                        () => _navigateToUsers(),
                      ),
                      _buildStatCard(
                        'Pending Requests',
                        RequestData.searchRequests()
                            .where((r) => r.status == 'Pending')
                            .length
                            .toString(),
                        Icons.pending_actions,
                        Colors.orange,
                        () => _navigateToRequests(),
                      ),
                      _buildStatCard(
                        'Inactive Users',
                        UserData.getInactiveUsersCount().toString(),
                        Icons.person_off,
                        Colors.red,
                        () => _navigateToUsers(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Quick actions
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildActionCard(
                        'View All Requests',
                        Icons.list_alt,
                        Color(0xFF517690),
                        () => _navigateToRequests(),
                      ),
                      _buildActionCard(
                        'Search & Filter',
                        Icons.search,
                        Colors.purple,
                        () => _navigateToSearch(),
                      ),
                      _buildActionCard(
                        'Manage Users',
                        Icons.people_alt,
                        Colors.teal,
                        () => _navigateToUsers(),
                      ),
                      _buildActionCard(
                        'Entry Logs',
                        Icons.history,
                        Colors.indigo,
                        () => _navigateToEntryLogs(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Recent activity
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildActivityItem(
                          'New request submitted by John Doe',
                          '2 minutes ago',
                          Icons.note_add,
                          Colors.blue,
                        ),
                        Divider(height: 1),
                        _buildActivityItem(
                          'User Sarah Wilson enabled',
                          '15 minutes ago',
                          Icons.person_add,
                          Colors.green,
                        ),
                        Divider(height: 1),
                        _buildActivityItem(
                          'Request #REQ-003 approved',
                          '1 hour ago',
                          Icons.check_circle,
                          Colors.green,
                        ),
                        Divider(height: 1),
                        _buildActivityItem(
                          'Admin login detected',
                          '2 hours ago',
                          Icons.login,
                          Color(0xFF517690),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 100), // Bottom padding for floating button
          ],
        ),
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        time,
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  void _handleNavigation(int index) {
    switch (index) {
      case 0:
        // Already on Home screen
        break;
      case 1:
        // Navigate to All Requests screen
        _navigateToRequests();
        break;
      case 2:
        // Navigate to Search screen
        _navigateToSearch();
        break;
      case 3:
        // Navigate to Users screen
        _navigateToUsers();
        break;
      case 4:
        // Navigate to Entry Logs screen
        _navigateToEntryLogs();
        break;
    }
  }

  void _navigateToRequests() {
    Navigator.pushNamedAndRemoveUntil(context, '/requests', (route) => false);
  }

  void _navigateToSearch() {
    Navigator.pushNamed(context, '/search');
  }

  void _navigateToUsers() {
    Navigator.pushNamed(context, '/users');
  }

  void _navigateToEntryLogs() {
    Navigator.pushNamed(context, '/entry-logs');
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
}
