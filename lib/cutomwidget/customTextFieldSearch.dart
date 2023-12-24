import 'package:flutter/material.dart';

class CustomTextFieldSearch extends StatelessWidget {
  const CustomTextFieldSearch({
    super.key,
    required TextEditingController controllerCaseNumber,
    required this.labelText,
  }) : _controllerCaseNumber = controllerCaseNumber;

  final TextEditingController _controllerCaseNumber;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: TextField(
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
        ));
  }
}
