part of 'onboarding_bloc.dart';


@immutable
sealed class OnboardingEvent {}

class OnboardingStarted extends OnboardingEvent {}

class OnboardingPageChanged extends OnboardingEvent {
  final int pageIndex;
  OnboardingPageChanged({required this.pageIndex});
}

class OnboardingCompleted extends OnboardingEvent {}

class OnboardingSkipped extends OnboardingEvent {}
