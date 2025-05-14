import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../data/dataSources/local/hive_helper.dart';
import '../../components/empty_record_view.dart';
import '../../../core/utils/tools.dart';
import '../../../domain/provider/address_provider.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_button.dart';
import 'add_address_screen.dart';
import 'item_address_list.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.myAddress)), body: SafeArea(child: _buildAddressScreen()));
  }

  Widget _buildAddressScreen() {
    return Stack(children: [_addressListView(), Align(alignment: Alignment.bottomCenter, child: _addButton())]);
  }

  Widget _addressListView() {
    return Consumer(
      builder: (context, ref, child) {
        final addressList = ref.watch(addressListProvider);

        return addressList.isNotEmpty
            ? ListView.separated(
              itemCount: addressList.length,
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
              itemBuilder: (context, index) {
                final modelAddress = addressList[index];
                return ItemAddressList(
                  modelAddress: modelAddress,
                  onEdit: () {
                    openScreenWithResult(
                      context,
                      AddAddressScreen(modelAddress: modelAddress),
                      overrides: [addressTypeProvider.overrideWith((ref) => (modelAddress.addressType))],
                    ).then((value) {
                      if (value ?? false) {
                        ref.read(addressListProvider.notifier).state = getAddressDataFromAddressBox();
                      }
                    });
                  },
                  onDelete: () {
                    ref.read(deleteAddressProvider((context: context, addressId: modelAddress.addressId)));
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(padding: EdgeInsetsDirectional.symmetric(vertical: 10.h), child: Divider(color: colorDivider));
              },
            )
            : EmptyRecordView(message: language.emptyAddressMsg);
      },
    );
  }

  Widget _addButton() {
    return Consumer(
      builder: (context, ref, child) {
        return CustomButton(
          title: language.add,
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, bottom: 20.h),
          onPress: () {
            openScreenWithResult(context, AddAddressScreen()).then((value) {
              if (value ?? false) {
                ref.read(addressListProvider.notifier).state = getAddressDataFromAddressBox();
              }
            });
          },
        );
      },
    );
  }
}
