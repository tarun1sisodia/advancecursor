import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_attendance/blocs/onboarding/bloc/onboarding_bloc.dart';
import '../../../app/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<OnboardingBloc>().add(OnboardingStarted());
  }

  void _nextPage() {
    if (_pageController.page! < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.read<OnboardingBloc>().add(OnboardingCompleted());
    }
  }

  void _skip() {
    context.read<OnboardingBloc>().add(OnboardingSkipped());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingComplete) {
          Navigator.pushReplacementNamed(context, Routes.login);
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                    onPageChanged: (index) {
                      context.read<OnboardingBloc>().add(
                            OnboardingPageChanged(pageIndex: index),
                          );
                    },
                    itemCount: _pages.length,
                    itemBuilder: (context, index) => _buildPage(_pages[index]),
                  ),
                ),
                if (state is OnboardingInProgress) ...[
                  _buildPageIndicator(state.currentPage),
                  _buildNavigationButton(state.isLastPage),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
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

  Widget _buildPage(OnboardingPage page) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.network(
          _animations[_pages.indexOf(page)],
          height: 200,
          width: 200,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              page.icon,
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
                page.title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                page.description,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicator(int currentPage) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _pages.length,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPage == index
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton(bool isLastPage) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        width: 100,
        child: ElevatedButton(
          onPressed: _nextPage,
          child: Text(
            isLastPage ? 'Get Started' : 'Next',
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
