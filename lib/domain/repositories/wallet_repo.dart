abstract class WalletRepo {
  Future<dynamic> getWalletBalance();

  Future<dynamic> getWalletTransactions({required int transactionType});

  Future<dynamic> addMoneyToWallet({required dynamic amount});
}
