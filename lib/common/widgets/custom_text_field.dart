import 'package:flutter/material.dart';
import 'package:password_manager/resources/colours.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final IconData? icon;
  final bool editable;

  const CustomTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    this.icon,
    this.editable = true,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
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
              readOnly: !widget.editable,
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
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 0),
                          padding: EdgeInsets.zero,
                          backgroundColor: _obscureText ? Colors.grey : redPink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          _obscureText ? 'Mostrar' : 'Ocultar',
                          style: const TextStyle(fontSize: 14.0),
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
