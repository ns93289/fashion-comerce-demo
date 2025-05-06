import 'package:flutter/material.dart';

import '../../core/utils/tools.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final FormFieldValidator? validator;
  final Function(String? value)? onChanged;
  final InputDecoration? decoration;

  const CustomTextField({super.key, this.controller, this.keyboardType, this.textInputAction, this.style, this.validator, this.onChanged, this.decoration});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      style: widget.style ?? bodyTextStyle(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: widget.decoration,
    );
  }
}
