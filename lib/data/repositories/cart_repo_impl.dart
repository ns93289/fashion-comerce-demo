import '../../domain/entities/cart_preview_entity.dart';
import '../../domain/repositories/cart_repo.dart';
import '../dataSources/local/hive_constants.dart';
import '../dataSources/local/hive_helper.dart';
import '../dataSources/remote/api_base_helper.dart';
import '../dataSources/remote/api_constant.dart';
import '../dataSources/remote/api_reponse.dart';
import '../models/base_model.dart';
import '../models/cart_model.dart';
import '../models/cart_preview_model.dart';

class CartRepoImpl extends CartRepo {
  final ApiBaseHelper _apiHelper = ApiBaseHelper();

  @override
  Future<ApiResponse<CartModel>> addToCart({required int productVariantId, required int productId, required int quantity}) async {
    final response = await _apiHelper.post(
      api: EndPoint.addToCart,
      body: {
        ApiParams.productId: productId,
        ApiParams.productVariantId: productVariantId,
        ApiParams.quantity: quantity,
        ApiParams.userId: getIntDataFromUserBox(key: hiveUserId),
      },
    );

    return ResponseWrapper.fromJson<CartModel>(response, CartModel.fromJson);
  }

  @override
  Future<ApiResponse<CartPreviewEntity>> getCartDetails() async {
    final response = await _apiHelper.get(api: "${EndPoint.getCart}/${getIntDataFromUserBox(key: hiveUserId)}");

    return ResponseWrapper.fromJson<CartPreviewEntity>(response, CartPreviewModel.fromJson);
  }

  @override
  Future<ApiResponse<BaseModel?>> removeProductFromCart({required int productVariantId, required int productId, required int type}) async {
    final response = await _apiHelper.delete(
      api: EndPoint.removeCartProduct,
      body: {
        ApiParams.productId: productId,
        ApiParams.productVariantId: productVariantId,
        ApiParams.type: type,
        ApiParams.userId: getIntDataFromUserBox(key: hiveUserId),
      },
    );

    return ResponseWrapper.fromJson<BaseModel>(response, BaseModel.fromJson);
  }
}
