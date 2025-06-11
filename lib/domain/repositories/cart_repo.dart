abstract class CartRepo {
  Future<dynamic> addToCart({required int productVariantId, required int productId, required int quantity});

  Future<dynamic> getCartDetails();

  Future<dynamic> removeProductFromCart({required int productVariantId, required int productId, required int type});
}
