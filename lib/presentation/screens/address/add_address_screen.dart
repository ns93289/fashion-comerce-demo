import 'package:fashion_comerce_demo/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/text_field_validators.dart';
import '../../../core/utils/tools.dart';
import '../../../domain/entities/address_entity.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_text_field.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/model_address.dart';
import '../../provider/address_provider.dart';
import '../../components/custom_button.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressEntity? modelAddress;

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
    final AddressEntity(:houseName, :houseNo, :street, :addressLine1, :addressLine2, :city, :state, :addressType, :pinCode) =
        widget.modelAddress ?? ModelAddress();

    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsetsDirectional.only(top: 10.h, start: 20.w, end: 20.w),
          child: Form(
            key: addressFormKey,
            child: Column(
              children: [
                _houseNameField(houseName),
                _houseNoField(houseNo),
                _streetField(street),
                _landmarkField(addressLine1),
                _cityField(city),
                _stateField(state),
                _pinCodeField(pinCode.toString()),
                _addressTypeView(),
                _receiverDetails(),
                _addOrUpdateButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _houseNameField(String houseName) {
    return Consumer(
      builder: (context, ref, _) {
        final houseNameTEC = ref.watch(houseNameTECProvider);
        houseNameTEC.text = houseName;

        return Padding(
          padding: EdgeInsetsDirectional.only(bottom: 20.h),
          child: CustomTextField(
            controller: houseNameTEC,
            decoration: InputDecoration(labelText: language.houseOrPlace),
            textInputAction: TextInputAction.next,
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
          child: CustomTextField(
            controller: streetTEC,
            decoration: InputDecoration(labelText: language.street),
            textInputAction: TextInputAction.next,
            validator: (value) {
              return TextFieldValidator.emptyValidator(value, message: language.enterStreet);
            },
          ),
        );
      },
    );
  }

  Widget _landmarkField(String addressLine1) {
    return Consumer(
      builder: (context, ref, _) {
        final addressLine1TEC = ref.watch(landmarkTECProvider);
        addressLine1TEC.text = addressLine1;

        return Padding(
          padding: EdgeInsetsDirectional.only(bottom: 20.h),
          child: CustomTextField(
            controller: addressLine1TEC,
            decoration: InputDecoration(labelText: language.landmarkArea),
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
            decoration: InputDecoration(labelText: language.city),
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
            decoration: InputDecoration(labelText: language.state),
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
            validator: (value) {
              return TextFieldValidator.emptyValidator(value, message: language.enterPinCode);
            },
          ),
        );
      },
    );
  }

  Widget _addressTypeView() {
    return Consumer(
      builder: (context, ref, _) {
        final addressType = ref.watch(addressTypeSelectProvider);
        final List<AddressTypeEntity> addressTypes = ref.watch(addressTypesProvider);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(language.saveAs, style: bodyTextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: colorTextLight)),
            SizedBox(height: 20.h),
            SizedBox(
              width: 1.sw,
              child: Wrap(
                spacing: 10.w,
                runSpacing: 15.h,
                children:
                    addressTypes.map((e) {
                      return GestureDetector(
                        onTap: () {
                          ref.read(addressTypeSelectProvider.notifier).state = e.addressType;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: addressType == e.addressType ? colorPrimary.withAlpha(10) : colorWhite,
                            border: Border.all(color: addressType == e.addressType ? colorPrimary : colorTextLight),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                          child: Text(
                            getAddressTitle(e.addressType),
                            style: bodyTextStyle(color: addressType == e.addressType ? colorPrimary : colorText, fontSize: 14.sp, fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _receiverDetails() {
    return Consumer(
      builder: (context, ref, child) {
        final receiverNameTEC = ref.watch(receiverNameTECProvider);
        final receiverNumberTEC = ref.watch(receiverNumberTECProvider);
        final addressType = ref.watch(addressTypeSelectProvider);

        return addressType == AddressTypes.family
            ? Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 20.h),
                  child: CustomTextField(
                    controller: receiverNameTEC,
                    decoration: InputDecoration(labelText: language.receiverName),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      return TextFieldValidator.emptyValidator(value, message: language.enterReceiverName);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 20.h),
                  child: CustomTextField(
                    controller: receiverNumberTEC,
                    decoration: InputDecoration(labelText: language.receiverMobileNumber, suffixIcon: Icon(Icons.contact_page_outlined, color: colorTextLight)),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      return TextFieldValidator.emptyValidator(value, message: language.enterReceiverMobileNumber);
                    },
                  ),
                ),
              ],
            )
            : SizedBox();
      },
    );
  }

  Widget _addOrUpdateButton() {
    return Consumer(
      builder: (context, ref, _) {
        final apiResponse = ref.watch(addressServiceProvider);
        ref.listen(addressServiceProvider, (previous, next) {
          if (next.value != null) {
            Navigator.pop(context, true);
          }
        });

        return CustomButton(
          title: widget.modelAddress == null ? language.add : language.update,
          margin: EdgeInsetsDirectional.only(bottom: 20.h, top: 20.h),
          isLoading: apiResponse.isLoading,
          width: 1.sw,
          onPress: () {
            if (addressFormKey.currentState?.validate() ?? false) {
              FocusManager.instance.primaryFocus?.unfocus();
              if (widget.modelAddress == null) {
                ref.read(addAddressProvider);
              } else {
                ref.read(editAddressProvider(widget.modelAddress!.addressId));
              }
            }
          },
        );
      },
    );
  }
}
