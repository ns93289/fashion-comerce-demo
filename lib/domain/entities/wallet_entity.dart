class WalletEntity {
  num? _walletBalance;

  WalletEntity({num? walletBalance}) {
    _walletBalance = walletBalance;
  }

  num get walletBalance => _walletBalance ?? 0;
}

class WalletTransactionEntity {
  int? _transactionId;
  String? _amount;
  int? _transactionType;
  String? _transactionDate;
  String? _title;
  String? _description;

  WalletTransactionEntity({int? transactionId, String? amount, int? transactionType, String? transactionDate, String? title, String? description}) {
    _transactionId = transactionId;
    _amount = amount;
    _transactionType = transactionType;
    _transactionDate = transactionDate;
    _title = title;
    _description = description;
  }

  int get transactionId => _transactionId ?? 0;

  String get amount => _amount ?? "";

  int get transactionType => _transactionType ?? 0;

  String get transactionDate => _transactionDate ?? "";

  String get title => _title ?? "";

  String get description => _description ?? "";
}
