part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingInProgress extends OnboardingState {
  final int currentPage;
  final bool isLastPage;
  
  OnboardingInProgress({
    required this.currentPage,
    required this.isLastPage,
  });
}

class OnboardingComplete extends OnboardingState {}
