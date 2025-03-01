// This file is a copy of the existing student_dashboard_screen.dart

import 'package:flutter/material.dart';
import '../../settings/settings_drawer.dart'; // Correct relative path to SettingsDrawer

// Mock definitions for Course and Session classes
class Course {
  final String id;
  final String courseName;
  final String courseCode;
  final String department;
  final int yearOfStudy;
  final int semester;
  final DateTime createdAt;
  final DateTime updatedAt;

  Course({
    required this.id,
    required this.courseName,
    required this.courseCode,
    required this.department,
    required this.yearOfStudy,
    required this.semester,
    required this.createdAt,
    required this.updatedAt,
  });
}

class Session {
  final String id;
  final String courseId;
  final DateTime startTime;
  final DateTime endTime;
  final bool isActive;
  final bool isCompleted;

  Session({
    required this.id,
    required this.courseId,
    required this.startTime,
    required this.endTime,
    required this.isActive,
    required this.isCompleted,
  });
}

// Mock Routes class for navigation
class Routes {
  static void navigateTo(BuildContext context, String route) {
    // Implement navigation logic here
    Navigator.pushNamed(context, route);
  }

  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String markAttendance = '/mark-attendance';
  static const String login = '/login';

  static const String studentDashboard = '/student-dashboard';
}

class AppTheme {
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle bodyLarge = TextStyle(fontSize: 16);
  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}

class StudentDashboardScreen extends StatelessWidget {
  const StudentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    List<Session> activeSessions = [
      Session(
        id: '1',
        courseId: 'course1',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        isActive: true,
        isCompleted: false,
      ),
      Session(
        id: '2',
        courseId: 'course2',
        startTime: DateTime.now().add(const Duration(hours: 1)),
        endTime: DateTime.now().add(const Duration(hours: 2)),
        isActive: true,
        isCompleted: false,
      ),
    ];

    List<Course> courses = [
      Course(
        id: 'course1',
        courseName: 'Mathematics',
        courseCode: 'MATH101',
        department: 'Mathematics',
        yearOfStudy: 1,
        semester: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Course(
        id: 'course2',
        courseName: 'Physics',
        courseCode: 'PHYS101',
        department: 'Physics',
        yearOfStudy: 1,
        semester: 1,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
      ),
      drawer: const SettingsDrawer(), // Use the new SettingsDrawer
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh logic can be added here if needed
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(activeSessions.length),
              const SizedBox(height: 24),
              _buildAttendanceStats(),
              const SizedBox(height: 24),
              _buildActiveSessions(activeSessions, courses, context),
              const SizedBox(height: 24),
              _buildRecentHistory(activeSessions, courses),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(int activeSessionCount) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back, Student!',
              style: AppTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'You have $activeSessionCount active sessions',
              style: AppTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceStats() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Attendance Overview', style: AppTheme.titleLarge),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Overall', '85%', Icons.analytics),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'This Month',
                    '90%',
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Total Sessions', '20', Icons.history),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard('Present', '18', Icons.check_circle),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: Colors.blue),
          const SizedBox(height: 8),
          Text(value, style: AppTheme.headlineMedium),
          const SizedBox(height: 4),
          Text(label, style: AppTheme.bodyLarge, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildActiveSessions(
    List<Session> activeSessions,
    List<Course> courses,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Active Sessions', style: AppTheme.titleLarge),
        const SizedBox(height: 16),
        if (activeSessions.isEmpty)
          const Center(child: Text('No active sessions'))
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activeSessions.length,
            itemBuilder: (context, index) {
              final session = activeSessions[index];
              final course = courses.firstWhere(
                (c) => c.id == session.courseId,
                orElse: () => Course(
                  id: 'unknown',
                  courseName: 'Unknown Course',
                  courseCode: 'N/A',
                  department: 'N/A',
                  yearOfStudy: 0,
                  semester: 0,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              );
              return _buildSessionCard(context, session, course);
            },
          ),
      ],
    );
  }

  Widget _buildRecentHistory(
    List<Session> activeSessions,
    List<Course> courses,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recent History', style: AppTheme.titleLarge),
        const SizedBox(height: 16),
        if (activeSessions.isEmpty)
          const Center(child: Text('No recent history'))
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activeSessions.length,
            itemBuilder: (context, index) {
              final session = activeSessions[index];
              final course = courses.firstWhere(
                (c) => c.id == session.courseId,
                orElse: () => Course(
                  id: 'unknown',
                  courseName: 'Unknown Course',
                  courseCode: 'N/A',
                  department: 'N/A',
                  yearOfStudy: 0,
                  semester: 0,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              );
              return _buildSessionCard(context, session, course);
            },
          ),
      ],
    );
  }

  Widget _buildSessionCard(
    BuildContext context,
    Session session,
    Course course,
  ) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            course.courseCode.substring(0, 2),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(course.courseName, style: AppTheme.bodyLarge),
        subtitle: Text(
          '${session.startTime.hour}:${session.startTime.minute.toString().padLeft(2, '0')} - ${session.endTime.hour}:${session.endTime.minute.toString().padLeft(2, '0')}',
          style: AppTheme.bodyLarge,
        ),
        trailing: session.isActive
            ? ElevatedButton(
                onPressed: () =>
                    Routes.navigateTo(context, Routes.markAttendance),
                child: const Text('Mark'),
              )
            : Text(
                session.isCompleted ? 'Present' : 'Absent',
                style: TextStyle(
                  color: session.isCompleted ? Colors.green : Colors.red,
                ),
              ),
      ),
    );
  }
}
