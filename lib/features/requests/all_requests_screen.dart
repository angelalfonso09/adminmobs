import 'package:admin/shared/components/request_card.dart';
import 'package:flutter/material.dart';
import '../../shared/components/app_theme.dart';
import 'models/request.dart';
import '../../shared/components/request_card.dart';

class AllRequestsScreen extends StatefulWidget {
  const AllRequestsScreen({super.key});

  @override
  AllRequestsScreenState createState() => AllRequestsScreenState();
}

class AllRequestsScreenState extends State<AllRequestsScreen> {
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
        title: const Text('All Requests'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filters',
                      style: AppTextStyles.heading,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedFilter = 'All';
                        });
                      },
                      child: const Text(
                        'Reset filters',
                        style: AppTextStyles.buttonText,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                // Dropdown Filter
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    itemCount: filteredRequests.length,
                    itemBuilder: (context, index) {
                      final req = filteredRequests[index];
                      return GestureDetector(
                        onTap: () {
                          if (req.status.toLowerCase() == 'pending') {
                            TextEditingController _adminCommentController = TextEditingController();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: SingleChildScrollView(
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.blue, width: 2),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          // Header
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 32,
                                                backgroundColor: Colors.blue.shade100,
                                                child: Icon(Icons.person, size: 40, color: Colors.blue.shade700),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Alice Johnson', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                                    Text('alice.j@entrypass.com', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                                                  ],
                                                ),
                                              ),
                                              Text('User', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                                            ],
                                          ),
                                          const SizedBox(height: 18),
                                          // Request Info
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Request ID', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                                                    Text('EP-2024-001', style: TextStyle(fontWeight: FontWeight.w500)),
                                                    SizedBox(height: 8),
                                                    Text('Submission Date', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                                                    Text('2024-07-20'),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Status', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                                                    Text('Pending', style: TextStyle(fontWeight: FontWeight.w500)),
                                                    SizedBox(height: 8),
                                                    Text('Required By:', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                                                    Text('2024-07-27'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 18),
                                          // Equipment and Schedule
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Equipment Details', style: TextStyle(fontWeight: FontWeight.bold)),
                                                    Text('Laptop (Lenovo ThinkPad)', style: TextStyle(color: Colors.grey[800])),
                                                    SizedBox(height: 12),
                                                    Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
                                                    Text('1'),
                                                    SizedBox(height: 12),
                                                    Text('Destination', style: TextStyle(fontWeight: FontWeight.bold)),
                                                    Text('Comlab 502'),
                                                    SizedBox(height: 12),
                                                    Text('Purpose', style: TextStyle(fontWeight: FontWeight.bold)),
                                                    Text(''),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Entry Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
                                                    Text('October 26, 2023'),
                                                    Text('09:00 AM - 05:00 PM'),
                                                    Text('ComLab 501'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 18),
                                          Divider(),
                                          // Previous Admin Notes
                                          Text('Previous Admin Notes', style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text('Initial review complete. Awaiting additional details on material usage. Contacted requester for clarification.', style: TextStyle(color: Colors.grey[800])),
                                          const SizedBox(height: 18),
                                          // Admin Comments
                                          Text('Admin Comments (Optional)', style: TextStyle(fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 6),
                                          TextField(
                                            controller: _adminCommentController,
                                            maxLines: 3,
                                            decoration: InputDecoration(
                                              hintText: 'Add your comments here...',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 24),
                                          // Approve/Reject Buttons
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton.icon(
                                                  onPressed: () {
                                                    // Approve logic here
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: Icon(Icons.check, color: Colors.white),
                                                  label: Text('Approve'),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Color(0xFF517690),
                                                    padding: EdgeInsets.symmetric(vertical: 16),
                                                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton.icon(
                                                  onPressed: () {
                                                    // Reject logic here
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: Icon(Icons.close, color: Colors.white),
                                                  label: Text('Reject'),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    padding: EdgeInsets.symmetric(vertical: 16),
                                                    textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Request Details'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('ID: ${req.id}'),
                                      Text('Requester: ${req.requester}'),
                                      Text('Status: ${req.status}'),
                                      Text('Equipment Type: ${req.equipmentType}'),
                                      Text('Quantity: ${req.quantity}'),
                                      Text('Date: ${req.date}'),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: RequestCard(request: req),
                      );
                    },
                  ),
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
              break;
            case 1:
              // Already on All Requests
              break;
            case 2:
              Navigator.pushNamed(context, '/search');
              break;
            case 3:
              Navigator.pushNamed(context, '/users');
              break;
            case 4:
              Navigator.pushNamed(context, '/entry-logs');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
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
          const SizedBox(height: 16),
          Text(
            'No requests found',
            style: AppTextStyles.heading.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try adjusting your filters',
            style: AppTextStyles.cardMeta,
          ),
        ],
      ),
    );
  }
}
