part of 'login_bloc.dart';

abstract class LoginState extends BaseState {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class TokenFound extends LoginState {}

class LoginError extends LoginState {
  final String message;

  const LoginError(
      this.message);
}

class LoginSuccess extends LoginState {}
