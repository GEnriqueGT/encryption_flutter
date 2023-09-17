part of 'password_create_bloc.dart';

abstract class PasswordCreateState extends BaseState {
  const PasswordCreateState();

  @override
  List<Object> get props => [];
}

class PasswordCreateInitial extends PasswordCreateState {}

class CreatePasswordInProgress extends PasswordCreateState {}

class CreatePasswordSuccess extends PasswordCreateState {}

class PasswordCreateError extends PasswordCreateState {
  final String message;

  const PasswordCreateError(
      this.message);
}

class CategoriesSuccess extends PasswordCreateState {
  final List<Categories> categories ;

  const CategoriesSuccess(
       this.categories);
}

