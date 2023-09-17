import 'package:flutter/material.dart';
import 'package:password_manager/password-preview/model/categories_model.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final int? value;
  final List<Categories> items;
  final ValueChanged<int?> onChanged;
  final bool isEditable;

  CustomDropdown(
      {Key? key,
      required this.label,
      required this.items,
      required this.value,
      required this.onChanged,
      this.isEditable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Colors.grey.withOpacity(0.4),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
            color: Colors.white,
          ),
          child: SizedBox(
            height: 50.0,
            child: DropdownButton<int>(
              value: value,
              onChanged: isEditable ? onChanged : null,
              items: items.map((category) {
                return DropdownMenuItem<int>(
                  value: category.id,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(category.name),
                  ),
                );
              }).toList(),
              underline: Container(
                height: 0,
              ),
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
