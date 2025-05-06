class CartModel {
  num? _itemTotal;
  num? _tax;
  num? _discount;
  num? _deliveryCharge;
  num? _total;
  List<int>? _productList;

  CartModel({num? itemTotal, num? tax, num? deliveryCharge, num? total, num? discount, List<int>? productList}) {
    _itemTotal = itemTotal;
    _tax = tax;
    _deliveryCharge = deliveryCharge;
    _total = total;
    _discount = discount;
    _productList = productList;
  }

  num get total => _total ?? 0;

  num get deliveryCharge => _deliveryCharge ?? 0;

  num get tax => _tax ?? 0;

  num get itemTotal => _itemTotal ?? 0;

  num get discount => _discount ?? 0;

  List<int> get productList => _productList ?? [];
}
