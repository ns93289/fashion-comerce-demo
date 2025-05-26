import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/text_field_validators.dart';
import '../../../core/utils/tools.dart';
import '../../../data/dataSources/local/hive_helper.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_text_field.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/model_address.dart';
import '../../provider/address_provider.dart';
import '../../components/custom_button.dart';

class AddAddressScreen extends StatefulWidget {
  final ModelAddress? modelAddress;

  const AddAddressScreen({super.key, this.modelAddress});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    String addressLine1 = widget.modelAddress?.addressLine1 ?? "";

    return Scaffold(
      appBar: CommonAppBar(title: Text(addressLine1.isNotEmpty ? language.editAddress : language.addAddress)),
      body: SafeArea(child: _buildAddressScreen()),
    );
  }

  Widget _buildAddressScreen() {
    final ModelAddress(:houseNanme, :houseNo, :street, :addressLine1, :addressLine2, :city, :state, :addressType, :pinCode) =
        widget.modelAddress ?? ModelAddress();

    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w, bottom: 80.h),
          child: Form(
            key: addressFormKey,
            child: Column(
              children: [
                _addressTypeView(),
                _houseNameField(houseNanme),
                _houseNoField(houseNo),
                _streetField(street),
                _addressLine1Field(addressLine1),
                _addressLine2Field(addressLine2),
                _cityField(city),
                _stateField(state),
                _pinCodeField(pinCode.toString()),
              ],
            ),
          ),
        ),
        Align(alignment: Alignment.bottomCenter, child: _addOrUpdateButton()),
      ],
    );
  }

  Widget _addressTypeView() {
    return Consumer(
      builder: (context, ref, _) {
        final addressType = ref.watch(addressTypeProvider);

        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ref.read(addressTypeProvider.notifier).state = AddressTypes.home;
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colorWhite,
                    border: Border.all(color: addressType == AddressTypes.home ? colorPrimary : colorTextLight),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  height: 60.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(getAddressIcon(AddressTypes.home), color: addressType == AddressTypes.home ? colorPrimary : colorTextLight),
                      SizedBox(height: 5.h),
                      Text(getAddressTitle(AddressTypes.home), style: bodyStyle(color: addressType == AddressTypes.home ? colorPrimary : colorTextLight)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ref.read(addressTypeProvider.notifier).state = AddressTypes.work;
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colorWhite,
                    border: Border.all(color: addressType == AddressTypes.work ? colorPrimary : colorTextLight),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  height: 60.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(getAddressIcon(AddressTypes.work), color: addressType == AddressTypes.work ? colorPrimary : colorTextLight),
                      SizedBox(height: 5.h),
                      Text(getAddressTitle(AddressTypes.work), style: bodyStyle(color: addressType == AddressTypes.work ? colorPrimary : colorTextLight)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  ref.read(addressTypeProvider.notifier).state = AddressTypes.other;
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: colorWhite,
                    border: Border.all(color: addressType == AddressTypes.other ? colorPrimary : colorTextLight),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  height: 60.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(getAddressIcon(AddressTypes.other), color: addressType == AddressTypes.other ? colorPrimary : colorTextLight),
                      SizedBox(height: 5.h),
                      Text(getAddressTitle(AddressTypes.other), style: bodyStyle(color: addressType == AddressTypes.other ? colorPrimary : colorTextLight)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _houseNameField(String houseName) {
    return Consumer(
      builder: (context, ref, _) {
        final houseNameTEC = ref.watch(houseNameTECProvider);
        houseNameTEC.text = houseName;

        return Padding(
          padding: EdgeInsetsDirectional.only(bottom: 20.h, top: 20.h),
          child: CustomTextField(
            controller: houseNameTEC,
            decoration: InputDecoration(labelText: "${language.houseOrPlace}*"),
            validator: (value) {
              return TextFieldValidator.emptyValidator(value, message: language.enterHouseOrPlace);
            },
          ),
        );
      },
    );
  }

  Widget _houseNoField(String houseNo) {
    return Consumer(
      builder: (context, ref, _) {
        final houseNoTEC = ref.watch(houseNoTECProvider);
        houseNoTEC.text = houseNo;
        return Padding(
          padding: EdgeInsetsDirectional.only(bottom: 20.h),
          child: CustomTextField(controller: houseNoTEC, decoration: InputDecoration(labelText: language.houseNo), textInputAction: TextInputAction.next),
        );
      },
    );
  }

  Widget _streetField(String street) {
    return Consumer(
      builder: (context, ref, _) {
        final streetTEC = ref.watch(streetTECProvider);
        streetTEC.text = street;

        return Padding(
          padding: EdgeInsetsDirectional.only(bottom: 20.h),
          child: CustomTextField(controller: streetTEC, decoration: InputDecoration(labelText: language.street), textInputAction: TextInputAction.next),
        );
      },
    );
  }

  Widget _addressLine1Field(String addressLine1) {
    return Consumer(
      builder: (context, ref, _) {
        final addressLine1TEC = ref.watch(addressLine1TECProvider);
        addressLine1TEC.text = addressLine1;

        return Padding(
          padding: EdgeInsetsDirectional.only(bottom: 20.h),
          child: CustomTextField(
            controller: addressLine1TEC,
            decoration: InputDecoration(labelText: "${language.addressLine1}*"),
            textInputAction: TextInputAction.next,
            validator: (value) {
              return TextFieldValidator.emptyValidator(value, message: language.enterAddress);
            },
          ),
        );
      },
    );
  }

  Widget _addressLine2Field(String addressLine2) {
    return Consumer(
      builder: (context, ref, _) {
        final addressLine2TEC = ref.watch(addressLine2TECProvider);
        addressLine2TEC.text = addressLine2;
        return Padding(
          padding: EdgeInsetsDirectional.only(bottom: 20.h),
          child: CustomTextField(
            controller: addressLine2TEC,
            decoration: InputDecoration(labelText: language.addressLine2),
            textInputAction: TextInputAction.next,
          ),
        );
      },
    );
  }

  Widget _cityField(String city) {
    return Consumer(
      builder: (context, ref, _) {
        final cityTEC = ref.watch(cityTECProvider);
        cityTEC.text = city;
        return Padding(
          padding: EdgeInsetsDirectional.only(bottom: 20.h),
          child: CustomTextField(
            controller: cityTEC,
            decoration: InputDecoration(labelText: "${language.city}*"),
            validator: (value) {
              return TextFieldValidator.emptyValidator(value, message: language.enterCity);
            },
            textInputAction: TextInputAction.next,
          ),
        );
      },
    );
  }

  Widget _stateField(String state) {
    return Consumer(
      builder: (context, ref, _) {
        final stateTEC = ref.watch(stateTECProvider);
        stateTEC.text = state;
        return Padding(
          padding: EdgeInsetsDirectional.only(bottom: 20.h),
          child: CustomTextField(
            controller: stateTEC,
            decoration: InputDecoration(labelText: "${language.state}*"),
            validator: (value) {
              return TextFieldValidator.emptyValidator(value, message: language.enterState);
            },
            textInputAction: TextInputAction.next,
          ),
        );
      },
    );
  }

  Widget _pinCodeField(String pinCode) {
    return Consumer(
      builder: (context, ref, _) {
        final pinCodeTEC = ref.watch(pinCodeTECProvider);
        pinCodeTEC.text = pinCode;
        return Padding(
          padding: EdgeInsetsDirectional.only(bottom: 20.h),
          child: CustomTextField(
            controller: pinCodeTEC,
            decoration: InputDecoration(labelText: language.pinCode),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        );
      },
    );
  }

  Widget _addOrUpdateButton() {
    return Consumer(
      builder: (context, ref, _) {
        return CustomButton(
          title: widget.modelAddress == null ? language.add : language.update,
          margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, bottom: 20.h),
          onPress: () {
            if (addressFormKey.currentState?.validate() ?? false) {
              final houseName = ref.read(houseNameTECProvider).text;
              final houseNo = ref.read(houseNoTECProvider).text;
              final street = ref.read(streetTECProvider).text;
              final addressLine1 = ref.read(addressLine1TECProvider).text;
              final addressLine2 = ref.read(addressLine2TECProvider).text;
              final city = ref.read(cityTECProvider).text;
              final state = ref.read(stateTECProvider).text;
              final pinCode = ref.read(pinCodeTECProvider).text;
              final addressType = ref.read(addressTypeProvider);
              ModelAddress modelAddress = ModelAddress(
                addressId: widget.modelAddress?.addressId,
                addressType: addressType,
                houseName: houseName,
                houseNo: houseNo,
                street: street,
                addressLine1: addressLine1,
                addressLine2: addressLine2,
                city: city,
                state: state,
                pinCode: int.parse(pinCode),
              );
              putDataInAddressBox(data: modelAddress);
              Navigator.pop(context, true);
            }
          },
        );
      },
    );
  }
}
