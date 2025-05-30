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
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 10.w),
          child: Icon(transactionType == 1 ? Icons.add : Icons.remove, color: transactionType == 1 ? colorGreen : colorRed),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: bodyTextStyle(fontWeight: FontWeight.w500)),
              Text(transactionDate, style: bodyTextStyle(color: colorTextLight, fontSize: 14.sp)),
            ],
          ),
        ),
        Text(amount.withCurrency, style: bodyTextStyle()),
      ],
    );
  }
}
