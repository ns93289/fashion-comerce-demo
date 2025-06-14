import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/close_button.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/theme.dart';
import '../../core/utils/time_utils.dart';
import '../../main.dart';

class ProductStatusBottomSheet extends StatefulWidget {
  final String orderNo;
  final String orderTime;

  const ProductStatusBottomSheet({super.key, required this.orderNo, required this.orderTime});

  @override
  State<ProductStatusBottomSheet> createState() => _ProductStatusBottomSheetState();
}

class _ProductStatusBottomSheetState extends State<ProductStatusBottomSheet> {
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
          Align(alignment: AlignmentDirectional.bottomEnd, child: CommonCloseButton()),
          Container(
            decoration: BoxDecoration(color: colorWhite, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r))),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(language.shippedWith, style: bodyTextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp)),
                SizedBox(height: 10.h),
                Text("${language.orderNumber}: ${widget.orderNo}", style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
                SizedBox(height: 15.h),
                Text(TimeUtils.getFormatedDate(widget.orderTime), style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
                SizedBox(height: 20.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("3:15 pm", style: bodyTextStyle(fontSize: 12.sp)),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      height: 40.h,
                      child: VerticalDivider(width: 0, thickness: 1.sp, color: colorDivider),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Package has left an Amazon facility", style: bodyTextStyle(fontSize: 14.sp)),
                          SizedBox(height: 5.h),
                          Text("BHIWANDI, MAHARASHTRA IN", style: bodyTextStyle(fontSize: 12.sp, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
