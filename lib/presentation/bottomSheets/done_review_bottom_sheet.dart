import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/theme.dart';
import '../../main.dart';
import '../components/custom_button.dart';
import '../components/rating_bar.dart';

class DoneReviewBottomSheet extends StatefulWidget {
  final num ratings;

  const DoneReviewBottomSheet({super.key, required this.ratings});

  @override
  State<DoneReviewBottomSheet> createState() => _DoneReviewBottomSheetState();
}

class _DoneReviewBottomSheetState extends State<DoneReviewBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent, body: SafeArea(child: _buildBottomSheet()));
  }

  Widget _buildBottomSheet() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            width: 1.sw,
            decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(20.r)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 30.h),
                Text("${language.done}!", style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp)),
                SizedBox(height: 5.h),
                Text(language.reviewSuccessMsg, style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
                SizedBox(height: 15.h),
                _ratingBar(),
                SizedBox(height: 10.h),
                _giveReviewButton(),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: colorWhite,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(blurRadius: 8, offset: Offset(0, 3), color: colorShadow)],
            ),
            padding: EdgeInsets.all(15.sp),
            margin: EdgeInsetsDirectional.only(bottom: 225.h),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(color: colorPrimary.withAlpha(10), shape: BoxShape.circle),
                padding: EdgeInsets.all(15.sp),
                child: Container(
                  padding: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(color: colorPrimary, shape: BoxShape.circle),
                  child: Icon(Icons.check_sharp, size: 10.sp),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _ratingBar() {
    return RatingBar(
      glow: false,
      ignoreGestures: true,
      initialRating: widget.ratings.toDouble(),
      onRatingUpdate: (double value) {},
      allowHalfRating: true,
      itemSize: 50.sp,
      ratingWidget: RatingWidget(
        full: Icon(Icons.star, color: Colors.amber),
        half: Icon(Icons.star_half, color: Colors.amber),
        empty: Icon(Icons.star_outline, color: Colors.amber),
      ),
    );
  }

  Widget _giveReviewButton() {
    return CustomButton(title: language.okay, width: 1.sw, margin: EdgeInsetsDirectional.only(top: 20.h), onPress: () => Navigator.pop(context));
  }
}
