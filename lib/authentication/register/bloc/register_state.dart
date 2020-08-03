part of 'register_bloc.dart';

@immutable
class RegisterState {
  final bool isEmailValid, isPasswordValid, isConfirmPasswordValid, isSubmitting, isSuccess, isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid && isConfirmPasswordValid;

  RegisterState({@required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isConfirmPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure});

  factory RegisterState.initial() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isConfirmPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false);
  }

  factory RegisterState.loading() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isConfirmPasswordValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false);
  }

  factory RegisterState.success() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isConfirmPasswordValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false);
  }

  factory RegisterState.failure() {
    return RegisterState(
        isEmailValid: true,
        isPasswordValid: true,
        isConfirmPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: true);
  }

  RegisterState update({bool isEmailValid, bool isPasswordValid, bool isConfirmPasswordValid}) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isConfirmPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isConfirmPasswordValid: $isConfirmPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}