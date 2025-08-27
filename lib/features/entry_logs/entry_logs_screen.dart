import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/models/entry_log.dart';
import '../../shared/components/entry_log_card.dart';
import '../../shared/components/entry_log_filter_buttons.dart';

class EntryLogsScreen extends StatefulWidget {
  const EntryLogsScreen({super.key});

  @override
  EntryLogsScreenState createState() => EntryLogsScreenState();
}

class EntryLogsScreenState extends State<EntryLogsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String selectedFilter = 'This Week';
  List<EntryLog> filteredLogs = [];
  int _currentIndex = 4; // Entry Logs tab

  @override
  void initState() {
    super.initState();
    _updateFilteredLogs();
  }

  void _updateFilteredLogs() {
    List<EntryLog> logs = EntryLogData.getLogsByDateFilter(selectedFilter);
    
    if (_searchController.text.isNotEmpty) {
      logs = logs.where((log) => 
        log.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        log.role.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        log.location.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        log.status.toLowerCase().contains(_searchController.text.toLowerCase())
      ).toList();
    }

    setState(() {
      filteredLogs = logs;
    });
  }

  void _onFilterSelected(String filter) {
    setState(() {
      selectedFilter = filter;
    });
    _updateFilteredLogs();
  }

  void _onSearchChanged(String query) {
    _updateFilteredLogs();
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
        // Navigate to Users screen
        Navigator.pushNamed(context, '/users');
        break;
      case 4:
        // Already on Entry Logs screen
        break;
    }
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature coming soon!'),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF517690),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entry Logs', style: GoogleFonts.montserrat()),
        backgroundColor: const Color(0xFF517690),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              _showComingSoon('Profile');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(16),
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
                  borderSide: const BorderSide(color: Color(0xFF517690)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                hintText: 'Search entry logs...',
                hintStyle: TextStyle(color: Colors.grey[500], fontFamily: 'Montserrat'),
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

          // Filter buttons
          EntryLogFilterButtons(
            selectedFilter: selectedFilter,
            onFilterSelected: _onFilterSelected,
          ),

          // Results info
          if (filteredLogs.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey.shade50,
              child: Row(
                children: [
                  Icon(Icons.list, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    'Showing ${filteredLogs.length} entry log${filteredLogs.length != 1 ? 's' : ''} • $selectedFilter',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

          // Entry logs list
          Expanded(
            child: filteredLogs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _searchController.text.isNotEmpty 
                            ? Icons.search_off 
                            : Icons.history_toggle_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchController.text.isNotEmpty 
                            ? 'No logs found' 
                            : 'No entry logs available',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _searchController.text.isNotEmpty
                            ? 'Try a different search term or adjust your filters'
                            : 'No entry logs found for $selectedFilter',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                            fontFamily: 'Montserrat',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: filteredLogs.length,
                    itemBuilder: (context, index) {
                      return EntryLogCard(log: filteredLogs[index]);
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
