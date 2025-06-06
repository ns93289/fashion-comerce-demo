import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/theme.dart';
import '../../components/empty_record_view.dart';
import '../../../core/constants/extensions.dart';
import '../../../domain/entities/wallet_entity.dart';
import '../../components/custom_button.dart';
import '../../../core/utils/decimal_text_input_formatter.dart';
import '../../components/custom_text_field.dart';
import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../main.dart';
import '../../components/common_circle_progress_bar.dart';
import '../../provider/wallet_provider.dart';
import '../../components/common_app_bar.dart';
import 'item_transaction.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(walletServiceProvider.notifier).callWalletBalanceApi();
      ref.read(walletTransactionServiceProvider.notifier).callWalletTransactionsApi(transactionType: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.wallet)), body: _buildWalletScreen());
  }

  Widget _buildWalletScreen() {
    return SingleChildScrollView(child: Column(children: [_walletView(), _amountTextField(), _addAmountButton(), _transactionList()]));
  }

  Widget _walletView() {
    final result = ref.watch(walletServiceProvider);

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), border: Border.all(width: 1.sp, color: colorBorder)),
      margin: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
      padding: EdgeInsetsDirectional.only(bottom: 15.h),
      width: 1.sw,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(top: 20.h, bottom: 15.h),
            child: Text(language.totalBalance, style: bodyTextStyle(fontWeight: FontWeight.w600, color: colorTextLight)),
          ),
          result.isLoading
              ? CommonCircleProgressBar(color: colorBlack, size: 25.sp, stroke: 2.sp)
              : Text(
                (result.asData?.value as WalletEntity?)?.walletBalance.withCurrency ?? "0",
                style: bodyTextStyle(fontWeight: FontWeight.w600, fontSize: 36.sp, color: colorPrimary),
              ),
        ],
      ),
    );
  }

  Widget _amountTextField() {
    final walletAmountTect = ref.watch(walletAmountTECProvider);

    return Form(
      key: walletFormKey,
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 15.h, start: 20.w, end: 20.w),
        child: CustomTextField(
          controller: walletAmountTect,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: language.amount),
          inputFormatters: [DecimalTextInputFormatter(maxDigits: 8, decimalRange: 2)],
        ),
      ),
    );
  }

  Widget _addAmountButton() {
    final walletAmountTect = ref.watch(walletAmountTECProvider);
    final result = ref.watch(addAmountWalletServiceProvider);
    ref.listen(addAmountWalletServiceProvider, (previous, next) {
      if (next.value != null) {
        Future.microtask(() {
          walletAmountTect.clear();
          ref.read(walletServiceProvider.notifier).callWalletBalanceApi();
        });
      }
    });

    return CustomButton(
      title: language.addMoney,
      width: 1.sw,
      margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 15.h),
      isLoading: result.isLoading,
      onPress: () {
        if (walletAmountTect.text.isNotEmpty) {
          if (walletAmountTect.text == "0") {
            openSimpleSnackBar(language.enterNonZeroAmount);
            return;
          }
          FocusManager.instance.primaryFocus?.unfocus();
          ref.read(addAmountWalletProvider);
        } else {
          openSimpleSnackBar(language.enterWalletAmount);
        }
      },
    );
  }

  Widget _transactionList() {
    /*final result = ref.watch(walletTransactionServiceProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, top: 20.h),
          child: Text(language.transactions, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        ),
        result.when(
          data: (data) {
            if (data == null) {
              return CommonCircleProgressBar();
            }
            final List<WalletTransactionEntity> transactionList = data as List<WalletTransactionEntity>;
            return ListView.builder(
              itemCount: transactionList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
              itemBuilder: (context, index) {
                final transaction = transactionList[index];
                return ItemTransaction(transaction: transaction);
              },
            );
          },
          error: (error, stackTrace) => Padding(padding: EdgeInsetsDirectional.only(top: 20.h), child: EmptyRecordView(message: error.toString())),
          loading: () => CommonCircleProgressBar(),
        ),
      ],
    );*/
    final List<WalletTransactionEntity> transactionList = [
      WalletTransactionEntity(title: "Credited for order complete", transactionDate: "25 May 2025, 11:20 pm", amount: "10.00", transactionType: 1),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
          child: Row(
            children: [
              Expanded(child: Text(language.transactions, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp))),
              Text(language.viewAll, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: colorPrimary)),
            ],
          ),
        ),
        ListView.builder(
          itemCount: transactionList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 20.h),
          itemBuilder: (context, index) {
            final transaction = transactionList[index];
            return ItemTransaction(transaction: transaction);
          },
        ),
      ],
    );
  }
}
