import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/common/bloc/base_bloc.dart';
import 'package:password_manager/common/bloc/base_state.dart';
import 'package:password_manager/password-preview/model/password_complete_model.dart';

part 'password_create_event.dart';
part 'password_create_state.dart';

class PasswordCreateBloc extends BaseBloc<PasswordCreateEvent, BaseState> {
  PasswordCreateBloc() : super(PasswordCreateInitial()) {
    on<CreatePassword>(createPassword);
  }

  Future<void> createPassword(
    final CreatePassword event,
    Emitter<BaseState> emit,
  ) async {
    try {

      final PasswordComplete createPasswordModel = event.passwordModel;

      if (createPasswordModel.password.isNotEmpty ||
          createPasswordModel.username.isNotEmpty ||
          createPasswordModel.site.isNotEmpty) {
        String userId = FirebaseAuth.instance.currentUser!.uid;

        CollectionReference passwordStoredReference =
            FirebaseFirestore.instance.collection('password_stored');

        await passwordStoredReference.add(createPasswordModel.toJson(userId));
        emit(CreatePasswordSuccess());
      } else {
        emit(const PasswordCreateError("Debe llenar todos los campos"));
      }
    } catch (error) {
      emit(
        PasswordCreateError(
          error.toString(),
        ),
      );
    }
  }
}
