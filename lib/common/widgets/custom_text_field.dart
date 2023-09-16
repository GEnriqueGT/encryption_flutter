import 'package:flutter/material.dart';
import 'package:password_manager/resources/colours.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final IconData? icon;

  const CustomTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    this.icon,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _obscureText = true; // Estado del campo de texto de contraseña

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.grey,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: _isFocused ? redPink : Colors.grey,
            ),
          ),
          child: SizedBox(
            height: 50.0,
            child: TextFormField(
              controller: widget.controller,
              obscureText: _obscureText,
              focusNode: _focusNode,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(bottom: 10, left: 10),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: widget.icon != null
                    ? Icon(
                  widget.icon,
                  color: _isFocused ? redPink : Colors.grey,
                )
                    : null,
                suffixIcon: widget.obscureText
                    ? SizedBox(
                  height: 50.0, // Establecer la altura máxima
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 0),
                      padding: EdgeInsets.zero, // Eliminar el relleno
                      backgroundColor:
                      _obscureText ? Colors.grey : redPink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      _obscureText ? 'Mostrar' : 'Ocultar',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
