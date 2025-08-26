import 'package:flutter/material.dart';
import 'features/requests/review_request_screen.dart';
import 'features/search/search_filter_screen.dart';
import 'features/entry_logs/entry_logs_screen.dart';
import 'features/users/manage_users_screen.dart';
import 'features/home/home_screen.dart';
import 'shared/models/request_data.dart';

void main() => runApp(AdminApp());

class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/requests': (context) => SimpleRequestsScreen(),
        '/search': (context) => SearchFilterScreen(),
        '/users': (context) => ManageUsersScreen(),
        '/entry-logs': (context) => EntryLogsScreen(),
      },
    );
  }
}

class SimpleRequestsScreen extends StatefulWidget {
  @override
  _SimpleRequestsScreenState createState() => _SimpleRequestsScreenState();
}

class _SimpleRequestsScreenState extends State<SimpleRequestsScreen> {
  String selectedFilter = 'All';
  int _currentIndex = 1; // Start with "All Requests" tab
  List<Request> filteredRequests = [];

  @override
  void initState() {
    super.initState();
    _updateFilteredRequests();
  }

  void _updateFilteredRequests() {
    List<Request> allRequests = RequestData.searchRequests(); // Get all requests
    
    if (selectedFilter == 'All') {
      filteredRequests = allRequests;
    } else {
      filteredRequests = allRequests.where((request) => request.status == selectedFilter).toList();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Requests'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Text('Filter: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF517690)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: selectedFilter,
                    underline: SizedBox(), // Remove default underline
                    icon: Icon(Icons.arrow_drop_down, color: Color(0xFF517690)),
                    style: TextStyle(color: Color(0xFF517690), fontWeight: FontWeight.w600),
                    items: ['All', 'Approved', 'Pending', 'Rejected']
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFilter = newValue!;
                        _updateFilteredRequests();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // Results counter
          if (filteredRequests.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey.shade50,
              child: Row(
                children: [
                  Icon(Icons.list, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Text(
                    'Showing ${filteredRequests.length} ${selectedFilter == 'All' ? 'request' : selectedFilter.toLowerCase()} request${filteredRequests.length != 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: filteredRequests.isEmpty 
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.filter_list_off,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No requests found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        selectedFilter == 'All' 
                          ? 'No requests available'
                          : 'No $selectedFilter requests found',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filteredRequests.length,
                  itemBuilder: (context, index) {
                    final request = filteredRequests[index];
                    return SimpleRequestCard(
                      name: 'Alice Johnson',
                      id: request.id,
                      status: request.status,
                      equipment: request.equipmentType,
                      date: request.date,
                    );
                  },
                ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          // Handle navigation based on selected tab
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
  
  void _handleNavigation(int index) {
    switch (index) {
      case 0:
        // Navigate to Home screen
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        break;
      case 1:
        // Already on All Requests screen
        break;
      case 2:
        // Navigate to Search screen
        Navigator.pushNamed(context, '/search');
        break;
      case 3:
        // Navigate to Users screen
        Navigator.pushNamed(context, '/users');
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
        backgroundColor: Colors.blue,
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
        return Color(0xFF517690); // Your custom approved color
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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReviewRequestScreen(requestId: id),
            ),
          );
        },
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
      ),
    );
  }
}
