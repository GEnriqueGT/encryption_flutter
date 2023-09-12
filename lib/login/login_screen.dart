import 'package:flutter/material.dart';
import 'package:password_manager/login/widget/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: LoginBody(),
    );
  }
}
