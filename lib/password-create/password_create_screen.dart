import 'package:flutter/material.dart';
import 'package:password_manager/password-create/widget/password-create-body.dart';

class PasswordCreateScreen extends StatelessWidget {
  const PasswordCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: PasswordCreateBody(),
    );
  }
}
