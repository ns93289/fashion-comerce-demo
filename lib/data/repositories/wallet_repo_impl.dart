import '../../domain/entities/wallet_entity.dart';
import '../../domain/repositories/wallet_repo.dart';
import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../models/wallet_model.dart';

class WalletRepoImpl extends WalletRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse> addMoneyToWallet({required amount}) async {
    final response = await _apiHelper.post(
      api: EndPoint.addMoneyToWallet,
      body: {ApiParams.amount: amount, ApiParams.userId: getIntDataFromUserBox(key: hiveUserId)},
    );

    return ResponseWrapper.fromJson<WalletEntity>(response, WalletModel.fromJson);
  }

  @override
  Future<ApiResponse<WalletEntity>> getWalletBalance() async {
    final response = await _apiHelper.post(api: EndPoint.getWalletBalance, body: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId)});

    return ResponseWrapper.fromJson<WalletEntity>(response, WalletModel.fromJson);
  }

  @override
  Future<ApiResponse<List<WalletTransactionEntity>>> getWalletTransactions({required int transactionType}) async {
    final response = await _apiHelper.post(
      api: EndPoint.getWalletTransactions,
      body: {ApiParams.userId: getIntDataFromUserBox(key: hiveUserId), ApiParams.type: transactionType},
    );

    return ResponseWrapper.fromJsonList<WalletTransactionEntity>(response, WalletTransactionModel.fromJson);
  }
}
