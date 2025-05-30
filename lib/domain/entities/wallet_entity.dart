class WalletEntity {
  num? _walletBalance;

  WalletEntity({num? walletBalance}) {
    _walletBalance = walletBalance;
  }

  num get walletBalance => _walletBalance ?? 0;
}

class WalletTransactionEntity {
  int? _transactionId;
  num? _amount;
  String? _transactionType;
  String? _transactionDate;
  String? _title;
  String? _description;

  WalletTransactionEntity({int? transactionId, num? amount, String? transactionType, String? transactionDate, String? title, String? description}) {
    _transactionId = transactionId;
    _amount = amount;
    _transactionType = transactionType;
    _transactionDate = transactionDate;
    _title = title;
    _description = description;
  }

  int get transactionId => _transactionId ?? 0;

  num get amount => _amount ?? 0;

  String get transactionType => _transactionType ?? "";

  String get transactionDate => _transactionDate ?? "";

  String get title => _title ?? "";

  String get description => _description ?? "";
}
