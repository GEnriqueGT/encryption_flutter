part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class VerifyToken extends LoginEvent{
  const VerifyToken();

  @override
  List<Object> get props => [];

}
