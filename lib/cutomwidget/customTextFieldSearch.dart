import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldSearch extends StatelessWidget {
  const CustomTextFieldSearch({
    super.key,
    required TextEditingController controllerCaseNumber,
    required this.labelText,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
  }) : _controllerCaseNumber = controllerCaseNumber;

  final TextEditingController _controllerCaseNumber;
  final String labelText;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: TextField(
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          controller: _controllerCaseNumber,
          decoration: InputDecoration(
            labelText: labelText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
          ),
          onChanged: onChanged,
        ));
  }
}
