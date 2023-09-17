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

class DeletePassword extends PasswordPreviewEvent{
  final String passwordId;
  const DeletePassword(this.passwordId);

  @override
  List<Object> get props => [passwordId];

}


class EditPassword extends PasswordPreviewEvent{
  final PasswordComplete passwordModel;
  const EditPassword(this.passwordModel);

  @override
  List<Object> get props => [passwordModel];

}
