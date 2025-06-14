import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/extensions.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../domain/entities/wallet_entity.dart';

class ItemTransaction extends StatelessWidget {
  final WalletTransactionEntity transaction;

  const ItemTransaction({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final WalletTransactionEntity(:amount, :title, :transactionDate, :transactionType) = transaction;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(end: 15.w),
          width: 30.sp,
          height: 30.sp,
          decoration: BoxDecoration(color: transactionType == 1 ? colorGreen : colorRed, shape: BoxShape.circle),
          child: Icon(transactionType == 1 ? Icons.add : Icons.remove, color: colorWhite),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(end: 20.w, bottom: 10.h),
                child: Text("Credited by you", style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
              ),
              Text(transactionDate, style: bodyTextStyle(color: colorTextLight, fontSize: 14.sp)),
              SizedBox(height: 10.h),
              Text(amount.withCurrency, style: bodyTextStyle(color: transactionType == 1 ? colorGreen : colorRed)),
            ],
          ),
        ),
      ],
    );
  }
}
