part of 'password_preview_bloc.dart';

abstract class PasswordPreviewState extends BaseState {
  const PasswordPreviewState();

  @override
  List<Object> get props => [];
}

class PasswordPreviewInitial extends PasswordPreviewState {}

class GetPasswordInProgress extends PasswordPreviewState {}

class DeletePasswordSuccess extends PasswordPreviewState {}

class GetPasswordInfoError extends PasswordPreviewState {
  final String message;

  const GetPasswordInfoError(
      this.message);
}

class PasswordSucces extends PasswordPreviewState {
  final PasswordComplete passwordInfo;

  const PasswordSucces(
      this.passwordInfo);
}

