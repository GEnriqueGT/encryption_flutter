import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/password-preview/bloc/password_preview_bloc.dart';
import 'package:password_manager/password-preview/widget/password_preview_body.dart';
import 'package:password_manager/resources/colours.dart';

class PasswordPreviewScreen extends StatelessWidget {
  final String passwordId;
  const PasswordPreviewScreen({Key? key, required this.passwordId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => PasswordPreviewBloc(),
      child:  Scaffold(
        backgroundColor: Colors.white70.withOpacity(0.92),
        body:  PasswordPreviewBody(passwordId: passwordId),
        appBar: AppBar(backgroundColor: pink, toolbarHeight: 0,automaticallyImplyLeading: false),
      ),
    );

  }
}
