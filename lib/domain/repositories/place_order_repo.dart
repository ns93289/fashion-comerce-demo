abstract class PlaceOrderRepo {
  Future<dynamic> placeOrder({required int paymentType, required int addressId});
}
