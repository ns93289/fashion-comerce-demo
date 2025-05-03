import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/tools.dart';
import '../../../../models/model_product.dart';
import '../../../../provider/home_provider.dart';
import 'item_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [_offerSlider(), _productFilters(), _newProducts()]));
  }

  Widget _offerSlider() {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 20.h),
      child: CarouselSlider(
        items: [
          AspectRatio(
            aspectRatio: 2,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: colorPrimary),
              margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
              height: double.maxFinite,
              width: double.maxFinite,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset("assets/images/slide1.jpg"),
            ),
          ),
          AspectRatio(
            aspectRatio: 2,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: colorPrimary),
              margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
              height: double.maxFinite,
              width: double.maxFinite,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset("assets/images/slide2.jpg"),
            ),
          ),
          AspectRatio(
            aspectRatio: 2,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: colorPrimary),
              margin: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
              height: double.maxFinite,
              width: double.maxFinite,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset("assets/images/slide3.jpg"),
            ),
          ),
        ],
        options: CarouselOptions(aspectRatio: 2, viewportFraction: 1, autoPlay: false, autoPlayAnimationDuration: Duration(seconds: 3)),
      ),
    );
  }

  Widget _productFilters() {
    return Consumer(
      builder: (context, ref, child) {
        final List<ModelProductFilter> filters = ref.watch(productFiltersProvider);
        final selectedId = ref.watch(selectedProductFilterProvider);

        return Container(
          margin: EdgeInsetsDirectional.only(top: 20.h),
          height: 30.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            padding: EdgeInsetsDirectional.symmetric(horizontal: 15.w),
            itemBuilder: (context, index) {
              ModelProductFilter item = filters[index];

              return GestureDetector(
                onTap: () {
                  ref.read(selectedProductFilterProvider.notifier).state = item.id;
                },
                child: Container(
                  decoration: BoxDecoration(color: selectedId == item.id ? colorPrimary : colorWhite, borderRadius: BorderRadius.circular(20.r)),
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                  margin: EdgeInsetsDirectional.symmetric(horizontal: 5.w),
                  child: Row(
                    children: [
                      Container(
                        height: 30.sp,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset("assets/images/shoes2.webp"),
                      ),
                      Padding(padding: EdgeInsetsDirectional.only(start: 10.w), child: Text(item.categoryName, style: bodyTextStyle(fontSize: 12.sp))),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _newProducts() {
    return Consumer(
      builder: (context, ref, child) {
        final List<ModelProduct> productList = ref.watch(newProductProvider);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
              child: Row(
                children: [
                  Expanded(child: Text("New Men's", style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))),
                  Text("See all", style: bodyTextStyle(fontSize: 14.sp)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(top: 10.h),
              height: 205.h,
              child: ListView.builder(
                itemCount: productList.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                itemBuilder: (context, index) {
                  return ItemProduct(item: productList[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
