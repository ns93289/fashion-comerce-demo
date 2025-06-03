import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/tools.dart';
import '../../../domain/entities/address_entity.dart';

class ItemAddressList extends StatelessWidget {
  final AddressEntity modelAddress;
  final Function()? onEdit;
  final Function()? onDelete;

  const ItemAddressList({super.key, required this.modelAddress, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final AddressEntity(:houseName, :houseNo, :street, :addressLine1, :addressLine2, :city, :state, :addressType) = modelAddress;
    return Container(
      color: colorWhite,
      padding: EdgeInsetsDirectional.symmetric(vertical: 5.h),
      child: Row(
        children: [
          Padding(padding: EdgeInsetsDirectional.only(end: 10.w), child: Icon(getAddressIcon(addressType))),
          Expanded(
            child: Text(
              "$houseNo, $houseName, $street, $addressLine1, $addressLine2, $city, $state",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: bodyTextStyle(fontSize: 14.sp),
            ),
          ),
          GestureDetector(
            onTap: () => onDelete?.call(),
            child: Padding(padding: EdgeInsetsDirectional.only(start: 5.w), child: Icon(Icons.delete_outline, color: colorTextLight)),
          ),
          GestureDetector(
            onTap: () => onEdit?.call(),
            child: Padding(padding: EdgeInsetsDirectional.only(start: 5.w), child: Icon(Icons.edit_outlined, color: colorTextLight)),
          ),
        ],
      ),
    );
  }
}
