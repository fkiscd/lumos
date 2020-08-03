import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import '../../firebase/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import '../../validators.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(RegisterState.initial());



  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
      Stream<RegisterEvent> events,
      TransitionFunction<RegisterEvent, RegisterState> transitionFn) {
    final nonDebounceStream = events.where((event) {
      return (event is! RegisterEmailChanged &&
          event is! RegisterPasswordChanged &&
          event is! RegisterConfirmPasswordChanged
      );
    });

    final debounceStream = events.where((event) {
      return (event is RegisterEmailChanged ||
          event is RegisterPasswordChanged ||
          event is RegisterConfirmPasswordChanged
      );
    }).debounceTime(Duration(milliseconds: 300));

    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangedToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangedToState(event.password);
    } else if (event is RegisterConfirmPasswordChanged) {
      yield* _mapRegisterConfirmPasswordChangedToState(event.confirmPassword);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event.email, event.password);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapRegisterPasswordChangedToState(
      String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapRegisterConfirmPasswordChangedToState(
      String confirmPassword) async* {
    yield state.update(
      isConfirmPasswordValid: true,
    );
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(String email,
      String password) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
          email: email,
          password: password
      );
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}