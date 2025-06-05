import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';

class CustomRadio extends StatelessWidget {
  final bool selected;
  final double? size;

  const CustomRadio({super.key, required this.selected, this.size});

  @override
  Widget build(BuildContext context) {
    final sizeFinal = size ?? 12.sp;

    return Icon(Icons.circle, size: sizeFinal, color: selected ? colorPrimary : colorBorder);
  }
}
