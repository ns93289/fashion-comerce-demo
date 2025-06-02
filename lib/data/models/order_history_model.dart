class OrderHistoryItem {
  int? _orderId;
  int? _orderQuantity;
  String? _deliveryAddress;
  String? _productName;
  String? _orderStatusMsg;
  String? _orderedTime;
  String? _orderNo;
  num? _orderAmount;
  List<int>? _productIdList;

  OrderHistoryItem({
    int? orderId,
    int? orderQuantity,
    String? deliveryAddress,
    String? productName,
    String? orderedTime,
    num? orderAmount,
    String? orderStatusMsg,
    List<int>? productIdList,
    String? orderNo,
  }) {
    _orderId = orderId;
    _orderQuantity = orderQuantity;
    _deliveryAddress = deliveryAddress;
    _productName = productName;
    _orderAmount = orderAmount;
    _orderStatusMsg = orderStatusMsg;
    _productIdList = productIdList;
    _orderedTime = orderedTime;
    _orderNo = orderNo;
  }

  OrderHistoryItem.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _productName = json['product_name'];
    _orderQuantity = json['order_quantity'];
    _deliveryAddress = json['delivery_address'];
    _orderAmount = json['order_amount'];
    _orderStatusMsg = json['order_status_msg'];
    _orderedTime = json['ordered_time'];
    _orderNo = json['order_no'];
    if (json['product_id_list'] != null) {
      _productIdList = [];
      json['product_id_list'].forEach((v) {
        _productIdList?.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['product_name'] = _productName;
    map['order_quantity'] = _orderQuantity;
    map['delivery_address'] = _deliveryAddress;
    map['order_amount'] = _orderAmount;
    map['order_status_msg'] = _orderStatusMsg;
    map['ordered_time'] = _orderedTime;
    map['order_no'] = _orderNo;
    if (_productIdList != null) {
      map['product_id_list'] = _productIdList?.map((v) => v).toList();
    }
    return map;
  }

  int get orderId => _orderId ?? 0;

  int get orderQuantity => _orderQuantity ?? 0;

  num get orderAmount => _orderAmount ?? 0;

  String get address => _deliveryAddress ?? "";

  String get orderStatusMsg => _orderStatusMsg ?? "";

  String get productName => _productName ?? "";

  String get deliveryAddress => _deliveryAddress ?? "";

  String get orderedTime => _orderedTime ?? "";

  String get orderNo => _orderNo ?? "14564564564";

  List<int> get productIdList => _productIdList ?? [];
}
