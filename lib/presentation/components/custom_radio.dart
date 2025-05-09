import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';

class CustomRadio extends StatelessWidget {
  final bool selected;
  final double? size;

  const CustomRadio({super.key, required this.selected, this.size});

  @override
  Widget build(BuildContext context) {
    final sizeFinal = size ?? 20.sp;

    return selected
        ? Container(
          decoration: BoxDecoration(border: Border.all(color: colorGreen), shape: BoxShape.circle),
          height: sizeFinal,
          width: sizeFinal,
          child: Icon(Icons.circle, size: sizeFinal / 1.25, color: colorGreen),
        )
        : Icon(Icons.circle_outlined, size: sizeFinal, color: colorTextLight);
  }
}
