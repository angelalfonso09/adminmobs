class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String status;
  final bool isFemale;
  final String department;
  final String joinDate;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.isFemale,
    required this.department,
    required this.joinDate,
  });
}

class UserData {
  static final List<User> _allUsers = [
    User(
      id: 'USR-001',
      name: 'Alice Johnson',
      email: 'alice.j@admin.com',
      role: 'Admin',
      status: 'Active',
      isFemale: true,
      department: 'IT Administration',
      joinDate: '2023-01-15',
    ),
    User(
      id: 'USR-002',
      name: 'Robert Smith',
      email: 'rob.s@admin.com',
      role: 'Admin',
      status: 'Active',
      isFemale: false,
      department: 'System Management',
      joinDate: '2022-11-20',
    ),
    User(
      id: 'USR-003',
      name: 'Sophia Lee',
      email: 'sophia.l@admin.com',
      role: 'User',
      status: 'Active',
      isFemale: true,
      department: 'Equipment Management',
      joinDate: '2024-02-10',
    ),
    User(
      id: 'USR-004',
      name: 'Michael Chen',
      email: 'mike.c@admin.com',
      role: 'Admin',
      status: 'Active',
      isFemale: false,
      department: 'Security',
      joinDate: '2023-06-05',
    ),
    User(
      id: 'USR-005',
      name: 'Emily Davis',
      email: 'emily.d@admin.com',
      role: 'User',
      status: 'Inactive',
      isFemale: true,
      department: 'Lab Management',
      joinDate: '2023-09-12',
    ),
    User(
      id: 'USR-006',
      name: 'David Martinez',
      email: 'david.m@admin.com',
      role: 'User',
      status: 'Active',
      isFemale: false,
      department: 'Facilities',
      joinDate: '2024-01-08',
    ),
  ];

  static List<User> getAllUsers() {
    return List.from(_allUsers);
  }

  static List<User> getUsersByRole(String role) {
    if (role == 'All') return _allUsers;
    return _allUsers.where((user) => user.role == role).toList();
  }

  static List<User> getUsersByStatus(String status) {
    if (status == 'All') return _allUsers;
    return _allUsers.where((user) => user.status == status).toList();
  }

  static List<User> searchUsers(String query) {
    if (query.isEmpty) return _allUsers;
    
    return _allUsers.where((user) => 
      user.name.toLowerCase().contains(query.toLowerCase()) ||
      user.email.toLowerCase().contains(query.toLowerCase()) ||
      user.role.toLowerCase().contains(query.toLowerCase()) ||
      user.department.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  static User? getUserById(String id) {
    try {
      return _allUsers.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  static void updateUserStatus(String userId, String newStatus) {
    // Find and update the user status
    for (int i = 0; i < _allUsers.length; i++) {
      if (_allUsers[i].id == userId) {
        _allUsers[i] = User(
          id: _allUsers[i].id,
          name: _allUsers[i].name,
          email: _allUsers[i].email,
          role: _allUsers[i].role,
          status: newStatus,
          isFemale: _allUsers[i].isFemale,
          department: _allUsers[i].department,
          joinDate: _allUsers[i].joinDate,
        );
        break;
      }
    }
  }

  static List<User> getActiveUsers() {
    return _allUsers.where((user) => user.status == 'Active').toList();
  }

  static List<User> getInactiveUsers() {
    return _allUsers.where((user) => user.status == 'Inactive').toList();
  }

  static int getActiveUsersCount() {
    return _allUsers.where((user) => user.status == 'Active').length;
  }

  static int getInactiveUsersCount() {
    return _allUsers.where((user) => user.status == 'Inactive').length;
  }
}
