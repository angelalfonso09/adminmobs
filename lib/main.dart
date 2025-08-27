import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/requests/all_requests_screen.dart';
import 'features/search/search_filter_screen.dart';
import 'features/entry_logs/entry_logs_screen.dart';
import 'features/users/manage_users_screen.dart';
import 'admin/screens/admin_dashboard_screen.dart';

void main() => runApp(const AdminApp());

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
        textTheme: GoogleFonts.montserratTextTheme(),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AdminDashboardScreen(),
        '/requests': (context) => const AllRequestsScreen(),
        '/search': (context) => const SearchFilterScreen(),
        '/users': (context) => const ManageUsersScreen(),
        '/entry-logs': (context) => const EntryLogsScreen(),
      },
    );
  }
}
