import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../domain/entities/slider_entity.dart';
import '../../../../../main.dart';
import '../../../../components/common_network_image.dart';
import '../../../productDetails/product_details_screen.dart';

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
                return GestureDetector(
                  onTap: () {
                    if (e.type == 1) {
                      //Products...
                      // navigationService.navigateTo(ProductDetailsScreen(productId: e.entityId,));
                    } else if (e.type == 2) {
                      //Categories...
                      // navigationService.navigateTo(screen);
                    } else if (e.type == 3) {
                      //Brands...
                      // navigationService.navigateTo(screen);
                    }
                  },
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: SizedBox(height: double.maxFinite, width: double.maxFinite, child: CommonNetworkImage(image: e.imageUrl)),
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
