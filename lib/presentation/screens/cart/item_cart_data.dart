import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../data/dataSources/local/hive_helper.dart';
import '../../../main.dart';
import '../../../data/models/model_product.dart';

class ItemCartData extends StatelessWidget {
  final ModelProduct item;

  const ItemCartData({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final ModelProduct(:productName, :productId, :productPrice, :selectedSize, :selectedQuantity) = item;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: colorProductEnd,
          width: 90.w,
          margin: EdgeInsetsDirectional.only(end: 10.w),
          child: AspectRatio(aspectRatio: 1, child: Image.asset("assets/images/shoes4.png")),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(productName, maxLines: 1, overflow: TextOverflow.ellipsis, style: bodyTextStyle(fontWeight: FontWeight.w500)),
              Text("${language.size}: ${selectedSize.toString()}", style: bodyTextStyle(fontSize: 14.sp)),
              Text("${language.quantity}: ${selectedQuantity.toString()}", style: bodyTextStyle(fontSize: 14.sp)),
              Row(
                children: [
                  Expanded(
                    child: Text("${language.totalPrice}: ${productPrice.withCurrency}", style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
                  ),
                  GestureDetector(onTap: () => removeItemFromCartBox(productId), child: Icon(Icons.delete_outline, size: 20.sp, color: colorTextLight)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
