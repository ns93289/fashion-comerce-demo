import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../domain/entities/wallet_entity.dart';
import '../domain/repositories/wallet_repo.dart';
import '../main.dart';

class WalletService extends StateNotifier<AsyncValue<dynamic>> {
  final WalletRepo walletRepo;

  WalletService(this.walletRepo) : super(const AsyncValue.data(null));

  Future<void> callWalletBalanceApi() async {
    state = const AsyncValue.loading();
    try {
      final response = await walletRepo.getWalletBalance();
      if (response is ApiSuccess) {
        state = AsyncValue.data(response.data);
      } else {
        state = AsyncValue.error(response.error, StackTrace.empty);
      }
    } catch (e, st) {
      logD("getWalletBalance>>>", e.toString());
      state = AsyncValue.error(e.toString(), st);
    }
  }

  Future<void> callWalletTransactionsApi({required int transactionType}) async {
    state = const AsyncValue.loading();
    try {
      final response = await walletRepo.getWalletTransactions(transactionType: transactionType);
      if (response is ApiSuccess) {
        List<WalletTransactionEntity> transactionList = response.data as List<WalletTransactionEntity>;
        transactionList.isEmpty ? state = AsyncValue.error(language.emptyTransactionMsg, StackTrace.empty) : state = AsyncValue.data(transactionList);
      } else {
        state = AsyncValue.error(response.error, StackTrace.empty);
      }
    } catch (e, st) {
      logD("getWalletTransactions>>>", e.toString());
      state = AsyncValue.error(e.toString(), st);
    }
  }

  Future<void> callAddMoneyToWalletApi({required dynamic amount}) async {
    state = const AsyncValue.loading();
    try {
      final response = await walletRepo.addMoneyToWallet(amount: amount);
      if (response is ApiSuccess) {
        state = AsyncValue.data(response.data);
      } else {
        state = AsyncValue.error(response.error, StackTrace.empty);
      }
    } catch (e, st) {
      logD("addMoneyToWallet>>>", e.toString());
      state = AsyncValue.error(e.toString(), st);
    }
  }
}
