part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  const RegisterEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'RegisterEmailChanged { email: $email }';
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  const RegisterPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'RegisterPasswordChanged { password: $password }';
}

class RegisterConfirmPasswordChanged extends RegisterEvent {
  final String confirmPassword;

  const RegisterConfirmPasswordChanged({@required this.confirmPassword});

  @override
  List<Object> get props => [confirmPassword];

  @override
  String toString() => 'RegisterConfirmPasswordChanged { confirmPassword: $confirmPassword }';
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;

  const RegisterSubmitted({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'RegisterSubmitted {email: $email, password: $password}';
  }
}
