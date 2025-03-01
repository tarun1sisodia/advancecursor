import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial());

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    if (event is CompleteOnboarding) {
      // Handle onboarding completion logic here
      yield OnboardingCompleted();
    }
  }
}
