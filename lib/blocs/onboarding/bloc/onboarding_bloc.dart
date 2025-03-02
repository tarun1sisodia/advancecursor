import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final int totalPages = 4;
  
  OnboardingBloc() : super(OnboardingInitial()) {
    on<OnboardingStarted>(_handleOnboardingStarted);
    on<OnboardingPageChanged>(_handlePageChanged);
    on<OnboardingCompleted>(_handleOnboardingCompleted);
    on<OnboardingSkipped>(_handleOnboardingSkipped);
  }

  Future<void> _handleOnboardingStarted(
    OnboardingStarted event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingInProgress(currentPage: 0, isLastPage: false));
  }

  Future<void> _handlePageChanged(
    OnboardingPageChanged event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingInProgress(
      currentPage: event.pageIndex,
      isLastPage: event.pageIndex == totalPages - 1,
    ));
  }

  Future<void> _handleOnboardingCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    emit(OnboardingComplete());
  }

  Future<void> _handleOnboardingSkipped(
    OnboardingSkipped event,
    Emitter<OnboardingState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    emit(OnboardingComplete());
  }
}
