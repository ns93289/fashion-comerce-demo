import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/extensions.dart';
import '../../../../../core/constants/colors.dart';

class OfferSlider extends StatefulWidget {
  const OfferSlider({super.key});

  @override
  State<OfferSlider> createState() => _OfferSliderState();
}

class _OfferSliderState extends State<OfferSlider> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items:
              [1, 2, 3].map((e) {
                return AspectRatio(
                  aspectRatio: 3 / 4,
                  child: SizedBox(height: double.maxFinite, width: double.maxFinite, child: Image.asset("assets/images/slider_image.png", fit: BoxFit.cover)),
                );
              }).toList(),
          options: CarouselOptions(
            aspectRatio: 3 / 4,
            viewportFraction: 1,
            autoPlay: false,
            onPageChanged: (index, reason) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(top: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                [1, 2, 3].mapIndexed((index, element) {
                  bool selected = index == _selectedIndex;
                  return Container(
                    width: selected ? 30.sp : 10.sp,
                    height: 10.sp,
                    decoration: BoxDecoration(color: selected ? colorPrimary : colorShimmerBg, borderRadius: BorderRadius.circular(5.r)),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
