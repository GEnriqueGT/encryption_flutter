import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/password-create/bloc/password_create_bloc.dart';
import 'package:password_manager/password-create/widget/password_create_body.dart';

class PasswordCreateScreen extends StatelessWidget {
  const PasswordCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordCreateBloc(),
      child: Scaffold(
        backgroundColor: Colors.white70.withOpacity(0.92),
        body: const PasswordCreateBody(),
      ),
    );
  }
}
