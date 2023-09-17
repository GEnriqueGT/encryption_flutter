import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/common/bloc/base_bloc.dart';
import 'package:password_manager/common/bloc/base_state.dart';
import 'package:password_manager/password-preview/model/categories_model.dart';
import 'package:password_manager/password-preview/model/password_complete_model.dart';
import 'package:password_manager/resources/encrypt_decrypt.dart';

part 'password_preview_event.dart';
part 'password_preview_state.dart';

class PasswordPreviewBloc extends BaseBloc<PasswordPreviewEvent, BaseState> {
  PasswordPreviewBloc() : super(PasswordPreviewInitial()) {
    on<RequestPassword>(getPassword);
    on<DeletePassword>(deletePassword);
    on<EditPassword>(editPassword);
  }

  Future<void> getPassword(
    final RequestPassword event,
    Emitter<BaseState> emit,
  ) async {
    try {
      PasswordComplete passwordInfo;
      List<Categories> categories = [];

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentSnapshot documentSnapshot = await firestore
          .collection("password_stored")
          .doc(event.passwordId)
          .get();

      if (documentSnapshot.exists) {
        var data = documentSnapshot.data() as Map<String, dynamic>;

        passwordInfo = PasswordComplete.fromJson(data, event.passwordId);

        QuerySnapshot categoriesSnapshot =
            await firestore.collection("categories").get();

        if (categoriesSnapshot.docs.isNotEmpty) {
          categories = categoriesSnapshot.docs
              .map((doc) =>
                  Categories.fromJson(doc.data() as Map<String, dynamic>))
              .toList();

          passwordInfo.password =
              decryptText(passwordInfo.password, "ASDFGHJKLASDFGHJ");

          emit(PasswordSuccess(passwordInfo, categories));
        }
      }
    } catch (error) {
      print(error);
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

  Future<void> editPassword(
    final EditPassword event,
    Emitter<BaseState> emit,
  ) async {
    try {
      final PasswordComplete createPasswordModel = event.passwordModel;

      String userId = FirebaseAuth.instance.currentUser!.uid;

      if (createPasswordModel.password.isNotEmpty ||
          createPasswordModel.username.isNotEmpty ||
          createPasswordModel.site.isNotEmpty) {
        DocumentReference<Map<String, dynamic>> passwordToEditReference =
            FirebaseFirestore.instance
                .collection('password_stored')
                .doc(event.passwordModel.id);

        await passwordToEditReference
            .update(event.passwordModel.toJson(userId));
        emit(PasswordEditedSuccess());
      } else {
        emit(const Error("Debe llenar todos los campos"));
      }
    } catch (error) {
      emit(
        Error(
          error.toString(),
        ),
      );
    }
  }
}
