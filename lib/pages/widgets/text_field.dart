import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  late ValueNotifier<bool> validation;

  MyTextField({
    Key? key,
    this.controller,
    required this.hintText,
    required this.validation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: validation.value ? null : 'Это поле не может быть пустым',
        ),
    );
  }
}
