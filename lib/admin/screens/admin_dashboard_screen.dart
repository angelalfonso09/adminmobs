
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/theme/admin_theme.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard', style: GoogleFonts.montserrat()),
        backgroundColor: AdminColors.adminPrimary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: AdminColors.adminPrimary,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.admin_panel_settings, size: 40, color: AdminColors.adminPrimary),
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome back, Admin!', style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 8),
                    Text('Manage your system efficiently', style: GoogleFonts.montserrat(fontSize: 16, color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dashboard Overview', style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Column(
                              children: [
                                const Icon(Icons.description, size: 40, color: AdminColors.adminPrimary),
                                const SizedBox(height: 16),
                                Text('8', style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.bold, color: AdminColors.adminPrimary)),
                                const SizedBox(height: 8),
                                Text('Total Requests', style: GoogleFonts.montserrat(fontSize: 16, color: Colors.grey[700])),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Column(
                              children: [
                                const Icon(Icons.people, size: 40, color: Colors.green),
                                const SizedBox(height: 16),
                                Text('5', style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green)),
                                const SizedBox(height: 8),
                                Text('Active Users', style: GoogleFonts.montserrat(fontSize: 16, color: Colors.grey[700])),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Column(
                              children: [
                                const Icon(Icons.pending_actions, size: 40, color: Colors.orange),
                                const SizedBox(height: 16),
                                Text('3', style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orange)),
                                const SizedBox(height: 8),
                                Text('Pending Reviews', style: GoogleFonts.montserrat(fontSize: 16, color: Colors.grey[700])),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Column(
                              children: [
                                const Icon(Icons.check_circle, size: 40, color: Colors.green),
                                const SizedBox(height: 16),
                                Text('5', style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green)),
                                const SizedBox(height: 8),
                                Text('Approved Today', style: GoogleFonts.montserrat(fontSize: 16, color: Colors.grey[700])),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Quick Actions', style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/requests'),
                      icon: const Icon(Icons.description),
                      label: Text('Review Requests', style: GoogleFonts.montserrat()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AdminColors.adminPrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Recent Request Status', style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Approved Requests', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green)),
                          const SizedBox(height: 8),
                          Text('• John Doe - Access Request', style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey[700])),
                          Text('• Maria Garcia - Equipment Request', style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey[700])),
                          Text('• David Smith - Meeting Room Booking', style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey[700])),
                          const SizedBox(height: 16),
                          Text('Rejected Requests', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red)),
                          const SizedBox(height: 8),
                          Text('• Sarah Johnson - Overtime Request', style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey[700])),
                          Text('• Mike Wilson - Budget Increase', style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey[700])),
                          const SizedBox(height: 16),
                          Text('Pending Requests', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.orange)),
                          const SizedBox(height: 8),
                          Text('• Lisa Brown - Vacation Request (URGENT)', style: GoogleFonts.montserrat(fontSize: 14, color: Colors.orange, fontWeight: FontWeight.w600)),
                          Text('• Tom Anderson - Training Request', style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey[700])),
                          Text('• Emma Davis - Remote Work Request', style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey[700])),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (int index) {
          switch (index) {
            case 0:
              // Already on Dashboard
              break;
            case 1:
              Navigator.pushNamed(context, '/requests');
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
        backgroundColor: Colors.white,
        selectedItemColor: AdminColors.adminPrimary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.montserrat(fontSize: 12),
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
}
