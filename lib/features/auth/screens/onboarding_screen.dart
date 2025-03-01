import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/routes.dart';
import '../../../blocs/onboarding_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Define Lottie animation URLs for each page
  final List<String> _animations = [
    'https://assets5.lottiefiles.com/packages/lf20_jcikwtux.json', // Education animation
    'https://assets5.lottiefiles.com/packages/lf20_scan.json', // QR Scanner animation
    'https://assets5.lottiefiles.com/packages/lf20_progress.json', // Progress animation
    'https://assets5.lottiefiles.com/packages/lf20_notification.json', // Notification animation
  ];

  final List<OnboardingPage> _pages = [
    const OnboardingPage(
      icon: Icons.school,
      title: 'Welcome to Smart Campus',
      description:
          'Your digital companion for a smarter and more connected campus experience',
    ),
    const OnboardingPage(
      icon: Icons.qr_code_scanner,
      title: 'Easy Attendance',
      description:
          'Mark your attendance seamlessly using location and WiFi verification',
    ),
    const OnboardingPage(
      icon: Icons.analytics,
      title: 'Track Progress',
      description:
          'Monitor your attendance records and academic progress in real-time',
    ),
    const OnboardingPage(
      icon: Icons.notifications_active,
      title: 'Stay Updated',
      description:
          'Get instant notifications about classes, attendance, and campus events',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _completeOnboarding() async {
    print("Onboarding completed, navigating to login."); // Debugging statement
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding(); // Call to complete onboarding
    }
  }

  void _skip() {
    print("Skipping onboarding."); // Debugging statement
    _completeOnboarding(); // Call to complete onboarding
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skip,
                  child: const Text('Skip'),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.network(
                        _animations[index],
                        height: 200,
                        width: 200,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            _pages[index].icon,
                            size: 100,
                            color: Theme.of(context).colorScheme.primary,
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Text(
                              _pages[index].title,
                              style: Theme.of(context).textTheme.headlineMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _pages[index].description,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        _pages.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _nextPage,
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink(); // We're not using this directly anymore
  }
}
