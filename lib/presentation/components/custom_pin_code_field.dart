import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../../core/utils/tools.dart';

class CustomPinCodeField extends StatefulWidget {
  final TextStyle? style;

  const CustomPinCodeField({super.key, this.style});

  @override
  CustomPinCodeFieldState createState() => CustomPinCodeFieldState();
}

class CustomPinCodeFieldState extends State<CustomPinCodeField> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    } else {
      _focusNodes[index].unfocus();
    }
  }

  ///To get the Pin from this widget access the [getPin] method using GlobalKey of [CustomPinCodeFieldState].
  String getPin() {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    final normalBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), borderSide: BorderSide(color: colorTextLight, width: 1.sp));
    final focusBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(5.r), borderSide: BorderSide(color: colorPrimary, width: 1.sp));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 35.sp,
          height: 35.sp,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: widget.style ?? bodyTextStyle(fontWeight: FontWeight.bold),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              counterText: "",
              // hides the character counter
              isDense: true,
              border: normalBorder,
              disabledBorder: normalBorder,
              enabledBorder: normalBorder,
              focusedBorder: focusBorder,
            ),
            onChanged: (value) => _onChanged(value, index),
          ),
        );
      }),
    );
  }
}
