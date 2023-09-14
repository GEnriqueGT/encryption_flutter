import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/common/bloc/base_bloc.dart';
import 'package:password_manager/common/bloc/base_state.dart';
import 'package:password_manager/repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, BaseState>{
  LoginBloc() : super(LoginInitial()) {
    on<VerifyToken>(tokenVerification);
  }


  Future<void> tokenVerification(
      final VerifyToken event,
      Emitter<BaseState> emit,
      ) async {
    try {
      var token = await UserRepository().getToken();

      if(token.isNotEmpty){
        emit(TokenFound());
      }

    } catch (error) {
      emit(
        LoginError(
          error.toString(),
        ),
      );
    }
  }
}