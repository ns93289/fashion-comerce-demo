class OrderHistoryItem {
  int? _orderId;
  int? _orderQuantity;
  String? _address;
  String? _productName;
  num? _orderAmount;
  String? _orderStatusMsg;

  OrderHistoryItem({int? orderId, int? orderQuantity, String? address, String? productName, num? orderAmount, String? orderStatusMsg}) {
    _orderId = orderId;
    _orderQuantity = orderQuantity;
    _address = address;
    _productName = productName;
    _orderAmount = orderAmount;
    _orderStatusMsg = orderStatusMsg;
  }

  int get orderId => _orderId ?? 0;

  int get orderQuantity => _orderQuantity ?? 0;

  num get orderAmount => _orderAmount ?? 0;

  String get address => _address ?? "";

  String get orderStatusMsg => _orderStatusMsg ?? "";

  String get productName => _productName ?? "";
}
