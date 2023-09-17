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

class Loading extends HomeState {}

class ResetSearch extends HomeState {}

class PasswordsSuccess extends HomeState {
  final List<Password> passwordsSaved;

  const PasswordsSuccess(
      this.passwordsSaved);
}

class PasswordsSearchSuccess extends HomeState {
  final List<Password> passwordsSaved;

  const PasswordsSearchSuccess(
      this.passwordsSaved);
}


class LogOutSuccess extends HomeState {}