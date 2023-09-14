import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/common/bloc/base_bloc.dart';
import 'package:password_manager/common/bloc/base_state.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, BaseState> {
  HomeBloc() : super(HomeInitial()) {
    on<LogOut>(logOut);
  }

  Future<void> logOut(
      final LogOut event,
      Emitter<BaseState> emit,
      ) async {
    try {
      FirebaseAuth.instance.signOut();
      emit(LogOutSuccess());
    } catch (error) {
      emit(
        LogOutError(
          error.toString(),
        ),
      );
    }
  }
}
