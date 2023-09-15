import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/common/bloc/base_bloc.dart';
import 'package:password_manager/common/bloc/base_state.dart';
import 'package:password_manager/password-preview/model/password_complete_model.dart';

part 'password_preview_event.dart';
part 'password_preview_state.dart';

class PasswordPreviewBloc extends BaseBloc<PasswordPreviewEvent, BaseState> {
  PasswordPreviewBloc() : super(PasswordPreviewInitial()) {
    on<RequestPassword>(getPassword);
    on<DeletePassword>(deletePassword);
  }

  Future<void> getPassword(
      final RequestPassword event,
      Emitter<BaseState> emit,
      ) async {
    try {
      PasswordComplete passwordInfo;

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentSnapshot documentSnapshot = await firestore
          .collection("password_stored")
          .doc(event.passwordId)
          .get();

      if (documentSnapshot.exists) {

        var data = documentSnapshot.data() as Map<String, dynamic>;

        passwordInfo = PasswordComplete.fromJson(data, event.passwordId);
        emit(PasswordSucces(passwordInfo));
      }
    } catch (error) {
      emit(
        GetPasswordInfoError(
          error.toString(),
        ),
      );
    }
  }

  Future<void> deletePassword(
      final DeletePassword event,
      Emitter<BaseState> emit,
      ) async {
    try {

      await FirebaseFirestore.instance
          .collection("password_stored")
          .doc(event.passwordId)
          .delete();

      emit(DeletePasswordSuccess());
    } catch (error) {
      emit(
        GetPasswordInfoError(
          error.toString(),
        ),
      );
    }
  }
}
