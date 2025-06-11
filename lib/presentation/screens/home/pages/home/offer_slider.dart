import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../data/dataSources/remote/api_constant.dart';
import '../../../../../domain/entities/slider_entity.dart';

class OfferSlider extends StatefulWidget {
  final List<SliderEntity> sliderData;

  const OfferSlider({super.key, required this.sliderData});

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
              widget.sliderData.map((e) {
                return AspectRatio(
                  aspectRatio: 3 / 4,
                  child: SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: CachedNetworkImage(
                      imageUrl: "${BaseUrl.url}${e.imageUrl}",
                      width: double.maxFinite,
                      height: double.maxFinite,
                      fit: BoxFit.cover,
                      fadeInDuration: Duration.zero,
                      placeholderFadeInDuration: Duration.zero,
                    ),
                  ),
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
        Container(
          height: 10.sp,
          margin: EdgeInsetsDirectional.only(top: 10.h),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: widget.sliderData.length,
            itemBuilder: (context, index) {
              bool selected = index == _selectedIndex;
              return Container(
                width: selected ? 30.sp : 10.sp,
                height: 10.sp,
                decoration: BoxDecoration(color: selected ? colorPrimary : colorShimmerBg, borderRadius: BorderRadius.circular(5.r)),
                margin: EdgeInsets.symmetric(horizontal: 3.w),
              );
            },
          ),
        ),
      ],
    );
  }
}
