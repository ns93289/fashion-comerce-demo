abstract class ProductDetailsRepo {
  Future<dynamic> getProductDetails({required int id, String? size, String? color});
}
