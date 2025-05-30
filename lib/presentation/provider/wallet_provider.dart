import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/wallet_service.dart';
import '../../data/repositories/wallet_repo_impl.dart';
import '../../domain/repositories/wallet_repo.dart';

final transactionTypeProvider = StateProvider<int>((ref) {
  return 0;
});
final changeTransactionTypeProvider = Provider.autoDispose.family<void, int>((ref, type) {
  Future.microtask(() {
    ref.read(transactionTypeProvider.notifier).state = type;
    ref.read(walletTransactionServiceProvider.notifier).callWalletTransactionsApi(transactionType: type);
  });
});
final walletAmountTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final walletRepoProvider = Provider.autoDispose<WalletRepo>((ref) {
  return WalletRepoImpl();
});

final walletServiceProvider = StateNotifierProvider<WalletService, AsyncValue<dynamic>>((ref) {
  return WalletService(ref.watch(walletRepoProvider));
});
final walletTransactionServiceProvider = StateNotifierProvider<WalletService, AsyncValue<dynamic>>((ref) {
  return WalletService(ref.watch(walletRepoProvider));
});
final addAmountWalletServiceProvider = StateNotifierProvider<WalletService, AsyncValue<dynamic>>((ref) {
  return WalletService(ref.watch(walletRepoProvider));
});

final addAmountWalletProvider = Provider.autoDispose<void>((ref) {
  final amount = ref.watch(walletAmountTECProvider).text;
  Future.microtask(() {
    ref.read(addAmountWalletServiceProvider.notifier).callAddMoneyToWalletApi(amount: amount);
  });
});

final walletFormKey = GlobalKey<FormState>();
