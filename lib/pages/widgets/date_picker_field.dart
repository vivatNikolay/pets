import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const DatePickerField(
      {required this.controller, required this.hintText, Key? key})
      : super(key: key);

  @override
  State<DatePickerField> createState() =>
      _DatePickerFieldState(controller, hintText);
}

class _DatePickerFieldState extends State<DatePickerField> {
  final DateFormat formatDate = DateFormat('dd.MM.yyyy');

  DateTime? selectedDate;
  final TextEditingController controller;
  final String hintText;

  _DatePickerFieldState(this.controller, this.hintText);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      onTap: () => _selectDate(context),
    );
  }

  _selectDate(BuildContext context) {
    Future<DateTime?> newSelectedDate = showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(1995),
        lastDate: DateTime.now());
    newSelectedDate.then((value) {
      setState(() {
        if (value != null) {
          selectedDate = value;
          controller.text = formatDate.format(selectedDate!);
        }
      });
    });
  }
}
