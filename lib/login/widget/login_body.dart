import 'package:flutter/material.dart';
import 'package:password_manager/login/widget/custom_text_field.dart';
import 'package:password_manager/resources/colours.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/resources/constants.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Iniciar Sesión',
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 20.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          SvgPicture.asset(
            '${imagePath}app-logo.svg',
            width: 150,
            height: 150,
          ),
          const Text(
            '!Bienvenido a tu Gestor de Contraseñas¡',
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 15.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          const CustomTextField(
            label: 'Correo Electrónico',
          ),
          const SizedBox(height: 20.0),
          const CustomTextField(
            label: 'Contraseña',
            obscureText: true,
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [redPink, darkPink],
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 100.0),
              child: const Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontFamily: 'DM Sans',
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    '${imagePath}facebook-logo.svg',
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset(
                    '${imagePath}x-logo.svg',
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  '${imagePath}google-logo.svg',
                  width: 32,
                  height: 32,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
