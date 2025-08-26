import 'package:flutter/material.dart';
import '../../shared/components/request_card.dart';
import '../../shared/components/app_theme.dart';

class Request {
  final String id;
  final String requester;
  final String status;
  final String equipmentType;
  final int quantity;
  final String date;

  Request({
    required this.id,
    required this.requester,
    required this.status,
    required this.equipmentType,
    required this.quantity,
    required this.date,
  });
}

class AllRequestsScreen extends StatefulWidget {
  @override
  _AllRequestsScreenState createState() => _AllRequestsScreenState();
}

class _AllRequestsScreenState extends State<AllRequestsScreen> {
  String selectedFilter = 'All';

  List<Request> requests = [
    Request(
        id: 'REQ-001-A',
        requester: 'Alice Johnson',
        status: 'Approved',
        equipmentType: 'Laptop (Lenovo ThinkPad)',
        quantity: 1,
        date: '2024-07-20'),
    Request(
        id: 'REQ-002-B',
        requester: 'Alice Johnson',
        status: 'Approved',
        equipmentType: 'Laptop (Lenovo ThinkPad)',
        quantity: 1,
        date: '2024-07-20'),
    Request(
        id: 'REQ-003-C',
        requester: 'Alice Johnson',
        status: 'Rejected',
        equipmentType: 'Laptop (Lenovo ThinkPad)',
        quantity: 1,
        date: '2024-07-20'),
    Request(
        id: 'REQ-004-D',
        requester: 'Alice Johnson',
        status: 'Pending',
        equipmentType: 'Laptop (Lenovo ThinkPad)',
        quantity: 1,
        date: '2024-07-20'),
    Request(
        id: 'REQ-005-E',
        requester: 'Alice Johnson',
        status: 'Approved',
        equipmentType: 'Laptop (Lenovo ThinkPad)',
        quantity: 1,
        date: '2024-07-20'),
  ];

  List<String> filterOptions = ['All', 'Approved', 'Pending', 'Rejected'];

  List<Request> get filteredRequests {
    if (selectedFilter == 'All') {
      return requests;
    } else {
      return requests.where((r) => r.status == selectedFilter).toList();
    }
  }

  int _selectedIndex = 1;

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Handle navigation tap if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Requests'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {
              // User profile tapped
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filters',
                      style: AppTextStyles.heading,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedFilter = 'All';
                        });
                      },
                      child: Text(
                        'Reset filters',
                        style: AppTextStyles.buttonText,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12),
                // Dropdown Filter
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedFilter == 'All' ? null : selectedFilter,
                      hint: Text(
                        'Select a saved filter',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
                      isExpanded: true,
                      items: filterOptions
                          .where((e) => e != 'All')
                          .map((e) => DropdownMenuItem(
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedFilter = value;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 1,
            color: AppColors.divider,
          ),

          // Results count
          if (filteredRequests.isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: AppColors.background,
              child: Text(
                '${filteredRequests.length} request${filteredRequests.length != 1 ? 's' : ''} found',
                style: AppTextStyles.cardMeta,
              ),
            ),

          // List of Requests
          Expanded(
            child: filteredRequests.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: EdgeInsets.only(top: 8, bottom: 16),
                    itemCount: filteredRequests.length,
                    itemBuilder: (context, index) {
                      final req = filteredRequests[index];
                      return RequestCard(request: req);
                    },
                  ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: 'Create'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: 'Requests'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline), label: 'Users'),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'No requests found',
            style: AppTextStyles.heading.copyWith(color: Colors.grey[600]),
          ),
          SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: AppTextStyles.cardMeta,
          ),
        ],
      ),
    );
  }
}
