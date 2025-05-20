import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final walletAmountProvider = FutureProvider.autoDispose<num>((ref) async {
  final amount = ref.watch(_walletPRovider);
  await Future.delayed(Duration(seconds: 2));
  return amount;
});

final _walletPRovider = StateProvider<num>((ref) => 0);

final walletAmountTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final walletFormKey = GlobalKey<FormState>();
