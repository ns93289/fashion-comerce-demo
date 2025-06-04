import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/tools.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../main.dart';
import '../../components/custom_button.dart';

class ItemAddressList extends StatelessWidget {
  final AddressEntity modelAddress;
  final Function()? onEdit;
  final Function()? onDelete;

  const ItemAddressList({super.key, required this.modelAddress, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final AddressEntity(:houseName, :houseNo, :street, :addressLine1, :addressLine2, :city, :state, :addressType) = modelAddress;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: colorBorder), borderRadius: BorderRadius.circular(20.r)),
      margin: EdgeInsetsDirectional.only(top: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Text(getAddressTitle(addressType), style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
          ),
          Divider(color: colorBorder, height: 0, thickness: 1.sp),
          SizedBox(height: 10.h),
          Row(
            children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: 15.w), child: Icon(Icons.location_on)),
              Expanded(
                child: Text(
                  "$houseNo, $houseName, $street, $addressLine1, $addressLine2, $city, $state",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: bodyTextStyle(fontSize: 12.sp),
                ),
              ),
              SizedBox(height: 15.w),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                title: language.delete,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                fontSize: 12.sp,
                height: 25.h,
                borderedButton: true,
                fontWeight: FontWeight.w500,
                margin: EdgeInsetsDirectional.only(end: 10.w),
                onPress: () => onDelete?.call(),
              ),
              CustomButton(
                title: language.edit,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                fontSize: 12.sp,
                height: 25.h,
                fontWeight: FontWeight.w500,
                margin: EdgeInsetsDirectional.only(end: 15.w),
                onPress: () => onEdit?.call(),
              ),
            ],
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
