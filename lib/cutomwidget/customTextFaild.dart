import 'package:flutter/material.dart';

class CustomSignUpTextFaild extends StatelessWidget {
  const CustomSignUpTextFaild({
    super.key,
    required this.controller,
    required this.nameLabel,
    required this.validator,
    required this.onSaved,
  });

  final TextEditingController controller;
  final String nameLabel;
  final String? Function(String? p1)? validator;
  final void Function(String? p1)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: nameLabel,
        border: OutlineInputBorder(),
        fillColor: Colors.white38,
        filled: true,
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
