class OrderHistoryEntity {
  int? _orderId;
  String? _productImage;
  String? _productName;
  String? _orderedTime;
  String? _orderNo;

  OrderHistoryEntity({int? orderId, String? productImage, String? productName, String? orderedTime, String? orderNo}) {
    _orderId = orderId;
    _productImage = productImage;
    _productName = productName;
    _orderedTime = orderedTime;
    _orderNo = orderNo;
  }

  int get orderId => _orderId ?? 0;

  String get productImage => _productImage ?? '';

  String get productName => _productName ?? '';

  String get orderedTime => _orderedTime ?? '';

  String get orderNo => _orderNo ?? '';
}
