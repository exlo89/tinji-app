part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class RegisterButtonPressed extends LoginEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  const RegisterButtonPressed({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.passwordConfirmation,
  });

  @override
  List<Object> get props => [name, email, password, passwordConfirmation];
}

class LogoutButtonPressed extends LoginEvent {}
