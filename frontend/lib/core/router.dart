import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/exam/presentation/home_screen.dart';
import '../features/exam/presentation/exam_details_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/profile/saved_exams_screen.dart';
import '../features/exam/domain/exam_model.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'details',
              builder: (context, state) {
                final exam = state.extra as Exam;
                return ExamDetailsScreen(exam: exam);
              },
            ),
          ],
        ),
        GoRoute(
          path: '/saved',
          builder: (context, state) => const SavedExamsScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/profile')) return 2;
    if (location.startsWith('/saved')) return 1;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/');
        break;
      case 1:
        GoRouter.of(context).go('/saved');
        break;
      case 2:
        GoRouter.of(context).go('/profile');
        break;
    }
  }
}
