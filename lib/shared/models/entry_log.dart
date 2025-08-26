class EntryLog {
  final String name;
  final String role;
  final String time;
  final String location;
  final String status;
  final String date;
  final String id;

  EntryLog({
    required this.name,
    required this.role,
    required this.time,
    required this.location,
    required this.status,
    required this.date,
    required this.id,
  });
}

class EntryLogData {
  static final List<EntryLog> _allLogs = [
    EntryLog(
      id: 'LOG-001',
      name: 'Alex Johnson',
      role: 'Student',
      time: '10:30 AM',
      location: 'ComLab 508',
      status: 'Approved',
      date: '2024-08-22',
    ),
    EntryLog(
      id: 'LOG-002',
      name: 'Maria Santos',
      role: 'Faculty',
      time: '09:15 AM',
      location: 'ComLab 502',
      status: 'Approved',
      date: '2024-08-22',
    ),
    EntryLog(
      id: 'LOG-003',
      name: 'James Rodriguez',
      role: 'Student',
      time: '11:45 AM',
      location: 'ComLab 508',
      status: 'Pending',
      date: '2024-08-22',
    ),
    EntryLog(
      id: 'LOG-004',
      name: 'Sarah Kim',
      role: 'Visitor',
      time: '02:20 PM',
      location: 'Office 301',
      status: 'Approved',
      date: '2024-08-21',
    ),
    EntryLog(
      id: 'LOG-005',
      name: 'Robert Brown',
      role: 'Student',
      time: '03:10 PM',
      location: 'ComLab 501',
      status: 'Rejected',
      date: '2024-08-21',
    ),
    EntryLog(
      id: 'LOG-006',
      name: 'Michael Chen',
      role: 'Security Officer',
      time: '08:00 AM',
      location: 'Main Entrance',
      status: 'Approved',
      date: '2024-08-20',
    ),
    EntryLog(
      id: 'LOG-007',
      name: 'Emily Davis',
      role: 'Student',
      time: '01:30 PM',
      location: 'ComLab 508',
      status: 'Approved',
      date: '2024-08-20',
    ),
    EntryLog(
      id: 'LOG-008',
      name: 'David Martinez',
      role: 'Faculty',
      time: '04:15 PM',
      location: 'Conference Room A',
      status: 'Approved',
      date: '2024-08-19',
    ),
  ];

  static List<EntryLog> getAllLogs() {
    return List.from(_allLogs);
  }

  static List<EntryLog> getLogsByDateFilter(String filter) {
    DateTime now = DateTime.now();
    DateTime startDate;

    switch (filter) {
      case 'Today':
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case 'This Week':
        startDate = now.subtract(Duration(days: 7));
        break;
      case 'This Month':
        startDate = DateTime(now.year, now.month, 1);
        break;
      default:
        return _allLogs;
    }

    return _allLogs.where((log) {
      DateTime logDate = DateTime.parse(log.date);
      return logDate.isAfter(startDate) || logDate.isAtSameMomentAs(startDate);
    }).toList();
  }

  static List<EntryLog> searchLogs(String query) {
    if (query.isEmpty) return _allLogs;
    
    return _allLogs.where((log) => 
      log.name.toLowerCase().contains(query.toLowerCase()) ||
      log.role.toLowerCase().contains(query.toLowerCase()) ||
      log.location.toLowerCase().contains(query.toLowerCase()) ||
      log.status.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}
