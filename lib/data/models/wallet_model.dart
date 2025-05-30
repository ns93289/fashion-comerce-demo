import '../../domain/entities/wallet_entity.dart';

class WalletModel extends WalletEntity {
  WalletModel({super.walletBalance});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(walletBalance: json['balance']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = walletBalance;
    return data;
  }
}

class WalletTransactionModel extends WalletTransactionEntity {
  WalletTransactionModel({super.transactionId, super.amount, super.transactionType, super.transactionDate, super.title, super.description});

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      transactionId: json['id'],
      amount: json['amount'],
      transactionType: json['type'],
      transactionDate: json['created_at'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = transactionId;
    data['amount'] = amount;
    data['type'] = transactionType;
    data['created_at'] = transactionDate;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
