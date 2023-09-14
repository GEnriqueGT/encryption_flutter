import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/common/widgets/custom_text_field.dart';
import 'package:password_manager/resources/colours.dart';
import 'package:password_manager/resources/constants.dart';

class PasswordCreateBody extends StatefulWidget {
  const PasswordCreateBody({Key? key}) : super(key: key);

  @override
  State<PasswordCreateBody> createState() => _PasswordCreateBodyState();
}

class _PasswordCreateBodyState extends State<PasswordCreateBody> {
  final TextEditingController urlController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final List<String> categories = ['Categoría 1', 'Categoría 2', 'Categoría 3'];
  String selectedCategory = 'Categoría 1';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 150.0,
          color: pink.withOpacity(0.4),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Crear Contraseña',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  SvgPicture.asset(
                    '${imagePath}password-logo.svg',
                    width: 40,
                    height: 40,
                    color: darkPink,
                  ),
                ],
              ),
            ],
          ),
        ),

        DropdownButton<String>(
          value: selectedCategory,
          onChanged: (newValue) {
            setState(() {
              selectedCategory = newValue!;
            });
          },
          items: categories.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:  CustomTextField(label: 'Dirección del Sitio', controller: urlController),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:  CustomTextField(label: 'Nombre de Usuario', controller: userController),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:  CustomTextField(label: 'Contraseña', obscureText: true, controller: passwordController,),
        ),
      ],
    );
  }
}
