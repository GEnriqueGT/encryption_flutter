part of 'password_preview_bloc.dart';

abstract class PasswordPreviewEvent extends Equatable {
  const PasswordPreviewEvent();
}


class RequestPassword extends PasswordPreviewEvent{
  final String passwordId;
  const RequestPassword(this.passwordId);

  @override
  List<Object> get props => [passwordId];

}