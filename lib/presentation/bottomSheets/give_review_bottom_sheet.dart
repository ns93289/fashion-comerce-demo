import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/custom_icons.dart';
import '../../core/constants/theme.dart';
import '../../main.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../components/rating_bar.dart';

class GiveReviewBottomSheet extends StatefulWidget {
  final int orderId;
  final String productName;
  final String productImage;
  final String orderNo;

  const GiveReviewBottomSheet({super.key, required this.orderId, required this.productName, required this.productImage, required this.orderNo});

  @override
  State<GiveReviewBottomSheet> createState() => _GiveReviewBottomSheetState();
}

class _GiveReviewBottomSheetState extends State<GiveReviewBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent, body: SafeArea(child: _buildBottomSheet()));
  }

  Widget _buildBottomSheet() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(5.sp),
                margin: EdgeInsetsDirectional.only(bottom: 5.h, end: 10.w),
                decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(5.r)),
                child: Icon(CustomIcons.cancel),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.circular(10.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(language.review, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp)),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: 10.w),
                      decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(20.r)),
                      height: 40.sp,
                      width: 40.sp,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.productName, style: bodyTextStyle(fontSize: 12.sp)),
                          SizedBox(height: 5.h),
                          Text("${language.orderId}: ${widget.orderNo}", style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                _ratingBar(),
                SizedBox(height: 20.h),
                _commentBox(),
                _giveReviewButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingBar() {
    return RatingBar(
      glow: false,
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

  Widget _commentBox() {
    return CustomTextField(
      decoration: InputDecoration(labelText: language.yourComment),
      backgroundColor: colorMainBackground,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      maxLine: 5,
    );
  }

  Widget _giveReviewButton() {
    return CustomButton(title: language.reviewButton, margin: EdgeInsetsDirectional.only(top: 20.h));
  }
}
