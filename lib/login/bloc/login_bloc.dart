import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/common/bloc/base_bloc.dart';
import 'package:password_manager/common/bloc/base_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, BaseState> {
  LoginBloc() : super(LoginInitial()) {
    on<Login>(login);
    on<LoginWithGoogle>(loginWithGoogle);
    on<VerifyToken>(tokenVerification);
  }

  Future<void> login(
    final Login event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      LoginInProgress(),
    );

    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      print(response);

      emit(LoginSuccess());
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }

  Future<void> loginWithGoogle(
    final LoginWithGoogle event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      LoginInProgress(),
    );

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      emit(const LoginError("has cencelado el logueo con google"));
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      print(authResult);

      emit(LoginSuccess());
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }

  Future<void> tokenVerification(
    final VerifyToken event,
    Emitter<BaseState> emit,
  ) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
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
