import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/extensions.dart';
import '../../../components/common_network_image.dart';

class ProductImagesView extends StatefulWidget {
  final List<String> imageList;

  const ProductImagesView({super.key, required this.imageList});

  @override
  State<ProductImagesView> createState() => _ProductImagesViewState();
}

class _ProductImagesViewState extends State<ProductImagesView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.imageList.map((e) => AspectRatio(aspectRatio: 1, child: CommonNetworkImage(image: e))).toList(),
          options: CarouselOptions(
            aspectRatio: 1,
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
                widget.imageList.mapIndexed((index, element) {
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
