import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/components/search_bar.dart';
import '../../shared/components/status_dropdown.dart';
import '../../shared/components/search_results.dart';
import '../../shared/models/request_data.dart';

class SearchFilterScreen extends StatefulWidget {
  const SearchFilterScreen({super.key});

  @override
  SearchFilterScreenState createState() => SearchFilterScreenState();
}

class SearchFilterScreenState extends State<SearchFilterScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'All';
  int _currentIndex = 2; // Start with "Search" tab selected
  
  List<Request> _searchResults = [];

  final List<String> _statuses = [
    'All',
    'Approved',
    'Pending',
    'Rejected',
  ];

  @override
  void initState() {
    super.initState();
    // Start with empty results - only show results when user searches
  }

  void _performSearch() {
    // Only search if there's a search query or a specific status filter
    if (_searchController.text.trim().isEmpty && _selectedStatus == 'All') {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    List<Request> results = RequestData.searchRequests(
      requestId: _searchController.text.trim(),
      status: _selectedStatus == 'All' ? null : _selectedStatus,
    );

    setState(() {
      _searchResults = results;
    });
  }

  void _onSearchChanged(String searchText) {
    // Perform search automatically
    _performSearch();
  }

  void _onSearchCleared() {
    _performSearch();
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _selectedStatus = 'All';
    });
    _performSearch();
    
    // Show reset confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Filters reset! Showing all ${_searchResults.length} requests'),
        backgroundColor: const Color(0xFF517690),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search & Filter', style: GoogleFonts.montserrat()),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFilters,
            tooltip: 'Reset Filters',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade50,
            child: SearchTextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              onClear: _onSearchCleared,
            ),
          ),
          
          // Filters section (always visible)
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  StatusDropdown(
                    statuses: _statuses,
                    selectedStatus: _selectedStatus,
                    onChanged: (value) {
                      setState(() => _selectedStatus = value!);
                      _performSearch();
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _resetFilters,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset Filters', style: TextStyle(fontFamily: 'Montserrat')),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Color(0xFF517690)),
                        foregroundColor: const Color(0xFF517690),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Divider
          Divider(height: 1, color: Colors.grey.shade300),
          
          // Results info
          if (_searchController.text.trim().isNotEmpty || _selectedStatus != 'All')
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey.shade50,
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    'Found ${_searchResults.length} result${_searchResults.length != 1 ? 's' : ''} • Filters applied automatically',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          
          // Search results
          Expanded(
            child: SearchResults(
              requests: _searchResults,
              searchQuery: _searchController.text,
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
        selectedItemColor: const Color(0xFF517690),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Montserrat'),
        unselectedLabelStyle: const TextStyle(fontSize: 12, fontFamily: 'Montserrat'),
        items: const [
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
        // Navigate to All Requests screen
        Navigator.pushNamedAndRemoveUntil(context, '/requests', (route) => false);
        break;
      case 2:
        // Already on Search screen
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
