import 'user.dart';

class UserData {
  static final List<User> _users = [
    User(
      id: 'USR-001',
      name: 'Alice Johnson',
      email: 'alice.j@admin.com',
      role: 'Admin',
      status: 'Active',
      isFemale: true,
      department: 'Management',
      joinDate: '2023-01-15',
    ),
    User(
      id: 'USR-002',
      name: 'Robert Smith',
      email: 'robert.s@admin.com',
      role: 'Admin',
      status: 'Active',
      isFemale: false,
      department: 'IT',
      joinDate: '2023-02-20',
    ),
    User(
      id: 'USR-003',
      name: 'Sophia Lee',
      email: 'sophia.l@company.com',
      role: 'User',
      status: 'Active',
      isFemale: true,
      department: 'HR',
      joinDate: '2023-03-10',
    ),
    User(
      id: 'USR-004',
      name: 'Michael Chen',
      email: 'michael.c@company.com',
      role: 'Admin',
      status: 'Active',
      isFemale: false,
      department: 'Operations',
      joinDate: '2023-04-05',
    ),
  ];

  // Get all users
  static List<User> getAllUsers() {
    return List.from(_users);
  }

  // Get active users count
  static int getActiveUsersCount() {
    return _users.where((user) => user.status == 'Active').length;
  }

  // Get inactive users count
  static int getInactiveUsersCount() {
    return _users.where((user) => user.status == 'Inactive').length;
  }

  // Update user status
  static void updateUserStatus(String userId, String newStatus) {
    final userIndex = _users.indexWhere((user) => user.id == userId);
    if (userIndex != -1) {
      final user = _users[userIndex];
      _users[userIndex] = User(
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        status: newStatus,
        isFemale: user.isFemale,
        department: user.department,
        joinDate: user.joinDate,
      );
    }
  }

  // Search users
  static List<User> searchUsers(String query) {
    query = query.toLowerCase();
    return _users.where((user) =>
      user.name.toLowerCase().contains(query) ||
      user.email.toLowerCase().contains(query) ||
      user.department.toLowerCase().contains(query) ||
      user.role.toLowerCase().contains(query)
    ).toList();
  }
}
