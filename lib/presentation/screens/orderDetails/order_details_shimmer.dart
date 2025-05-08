import '../../../core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderDetailsShimmer extends StatelessWidget {
  const OrderDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(baseColor: colorShimmerBg, highlightColor: colorShimmerHighlight, enabled: true, child: Column());
  }
}
