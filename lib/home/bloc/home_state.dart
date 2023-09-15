part of 'home_bloc.dart';

abstract class HomeState extends BaseState {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LogOutInProgress extends HomeState {}

class LogOutError extends HomeState {
  final String message;

  const LogOutError(
      this.message);
}

class PasswordsSucces extends HomeState {
  final List<Password> passwordsSaved;

  const PasswordsSucces(
      this.passwordsSaved);
}


class LogOutSuccess extends HomeState {}