import 'package:fashion_comerce_demo/data/dataSources/local/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../data/models/model_address.dart';
import '../../components/common_circle_progress_bar.dart';
import '../../../domain/entities/address_entity.dart';
import '../../components/empty_record_view.dart';
import '../../provider/address_provider.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_button.dart';
import '../../provider/navigation_provider.dart';
import 'add_address_screen.dart';
import 'item_address_list.dart';

class MyAddressScreen extends ConsumerStatefulWidget {
  final bool selectable;

  const MyAddressScreen({super.key, this.selectable = false});

  @override
  ConsumerState<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends ConsumerState<MyAddressScreen> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(getAddressServiceProvider.notifier).callGetAddressApi();
    });
    super.initState();
  }

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
        final apiResponse = ref.watch(getAddressServiceProvider);

        return apiResponse.when(
          data: (data) {
            if (data == null) {
              return EmptyRecordView(message: language.emptyAddressMsg);
            }
            final List<AddressEntity> addressList = data as List<AddressEntity>;
            if (addressList.length == 1) {
              putDataInAddressBox(addressList.first as ModelAddress);
            }

            return ValueListenableBuilder(
              valueListenable: addressBox.listenable(),
              builder: (context, _, _) {
                final AddressEntity? selectedAddress = getAddressFromAddressBox();

                return ListView.builder(
                  itemCount: addressList.length,
                  shrinkWrap: true,
                  padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
                  itemBuilder: (context, index) {
                    final modelAddress = addressList[index];
                    return GestureDetector(
                      onTap: () {
                        putDataInAddressBox(modelAddress as ModelAddress);
                        if (widget.selectable) {
                          ref.read(navigationServiceProvider).goBack();
                        }
                      },
                      child: ItemAddressList(
                        modelAddress: modelAddress,
                        selected: selectedAddress?.addressId == modelAddress.addressId,
                        onEdit: () {
                          ref
                              .read(navigationServiceProvider)
                              .navigateToWithResult(
                                AddAddressScreen(modelAddress: modelAddress),
                                overrides: [addressTypeSelectProvider.overrideWith((ref) => (modelAddress.addressType))],
                              )
                              ?.then((value) {
                                if (value ?? false) {
                                  checkAndChangeAddressBox(modelAddress as ModelAddress);
                                  ref.read(getAddressServiceProvider.notifier).callGetAddressApi();
                                }
                              });
                        },
                        onDelete: () {
                          ref.read(deleteAddressProvider((context: context, addressId: modelAddress.addressId)));
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
          error: (error, stackTrace) => EmptyRecordView(message: error.toString()),
          loading: () => CommonCircleProgressBar(),
        );
      },
    );
  }

  Widget _addButton() {
    return Consumer(
      builder: (context, ref, child) {
        return CustomButton(
          title: language.addAddress,
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, bottom: 30.h),
          width: 1.sw,
          onPress: () {
            ref.read(navigationServiceProvider).navigateToWithResult(AddAddressScreen())?.then((value) {
              if (value ?? false) {
                ref.read(getAddressServiceProvider.notifier).callGetAddressApi();
              }
            });
          },
        );
      },
    );
  }
}
