part of 'password_create_bloc.dart';

abstract class PasswordCreateEvent extends Equatable {
  const PasswordCreateEvent();
}


class CreatePassword extends PasswordCreateEvent{
  final PasswordComplete passwordModel;
  const CreatePassword(this.passwordModel);

  @override
  List<Object> get props => [passwordModel];

}


class GetCategorias extends PasswordCreateEvent{
  const GetCategorias();

  @override
  List<Object> get props => [];

}