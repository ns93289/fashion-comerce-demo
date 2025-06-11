abstract class ProductDetailsRepo {
  Future<dynamic> getProductDetails({required int id, required String size, required String color});
}
