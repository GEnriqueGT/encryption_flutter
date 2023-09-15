import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/common/bloc/base_bloc.dart';
import 'package:password_manager/common/bloc/base_state.dart';
import 'package:password_manager/home/model/password_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, BaseState> {
  HomeBloc() : super(HomeInitial()) {
    on<LogOut>(logOut);
    on<GetPasswordsSaved>(getPasswordsSaved);
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

  Future<void> getPasswordsSaved(
    final GetPasswordsSaved event,
    Emitter<BaseState> emit,
  ) async {
    try {
      List<Password> passwordsInFirestore = [];

      String userId = FirebaseAuth.instance.currentUser!.uid;

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot querySnapshot = await firestore
          .collection("password_stored")
          .where("uid", isEqualTo: userId)
          .get();

      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        passwordsInFirestore.add(Password.fromJson(
          data,
          doc.id,
        ));
      }

      emit(PasswordsSucces(passwordsInFirestore));
    } catch (error) {
      emit(
        LogOutError(
          error.toString(),
        ),
      );
    }
  }
}
