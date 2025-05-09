import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../../main.dart';
import '../../components/common_circle_progress_bar.dart';
import '../../../domain/provider/wallet_provider.dart';
import '../../components/common_app_bar.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.wallet)), body: _buildWalletScreen());
  }

  Widget _buildWalletScreen() {
    return SingleChildScrollView(child: Column(children: [_walletView()]));
  }

  Widget _walletView() {
    final result = ref.watch(walletAmountProvider);

    return Container(
      decoration: BoxDecoration(color: colorPrimary, borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        children: [
          Text(language.walletBalance, style: bodyTextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 10.h),
          SizedBox(
            height: 50.h,
            child:
                result.isLoading
                    ? CommonCircleProgressBar(color: colorBlack)
                    : Text(result.withCurrency, style: bodyTextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp)),
          ),
        ],
      ),
    );
  }
}
