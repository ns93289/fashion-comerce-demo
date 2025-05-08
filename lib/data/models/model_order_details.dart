class ModelOrderDetails {
  ModelOrderDetails({
    int? orderId,
    String? orderNo,
    int? orderStatus,
    String? deliveryAddress,
    num? totalAmount,
    List<OrderedProducts>? orderedProducts,
    String? orderTime,
    String? packedTime,
    String? shippedTime,
    String? deliveryTime,
    String? cancelledBy,
    String? cancelReason,
  }) {
    _orderId = orderId;
    _orderNo = orderNo;
    _orderStatus = orderStatus;
    _deliveryAddress = deliveryAddress;
    _totalAmount = totalAmount;
    _orderedProducts = orderedProducts;
    _orderTime = orderTime;
    _packedTime = packedTime;
    _shippedTime = shippedTime;
    _deliveryTime = deliveryTime;
    _cancelledBy = cancelledBy;
    _cancelReason = cancelReason;
  }

  ModelOrderDetails.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _orderNo = json['order_no'];
    _orderStatus = json['order_status'];
    _deliveryAddress = json['delivery_address'];
    _totalAmount = json['total_amount'];
    _orderTime = json['order_time'];
    _packedTime = json['packed_time'];
    _shippedTime = json['shipped_time'];
    _deliveryTime = json['delivery_time'];
    _cancelledBy = json['cancelled_by'];
    _cancelReason = json['cancel_reason'];
    if (json['ordered_products'] != null) {
      _orderedProducts = [];
      json['ordered_products'].forEach((v) {
        _orderedProducts?.add(OrderedProducts.fromJson(v));
      });
    }
  }

  int? _orderId;
  int? _orderStatus;
  String? _orderNo;
  String? _deliveryAddress;
  String? _orderTime;
  String? _packedTime;
  String? _shippedTime;
  String? _deliveryTime;
  String? _cancelledBy;
  String? _cancelReason;
  num? _totalAmount;
  List<OrderedProducts>? _orderedProducts;

  int get orderId => _orderId ?? 0;

  int get orderStatus => _orderStatus ?? 0;

  String get orderNo => _orderNo ?? "";

  String get deliveryAddress => _deliveryAddress ?? "";

  String get deliveryTime => _deliveryTime ?? "";

  String get shippedTime => _shippedTime ?? "";

  String get packedTime => _packedTime ?? "";

  String get orderTime => _orderTime ?? "";

  String get cancelledBy => _cancelledBy ?? "";

  String get cancelReason => _cancelReason ?? "";

  num get totalAmount => _totalAmount ?? 0;

  List<OrderedProducts> get orderedProducts => _orderedProducts ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['order_no'] = _orderNo;
    map['order_status'] = _orderStatus;
    map['delivery_address'] = _deliveryAddress;
    map['total_amount'] = _totalAmount;
    if (_orderedProducts != null) {
      map['ordered_products'] = _orderedProducts?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OrderedProducts {
  OrderedProducts({
    int? productId,
    String? productName,
    num? productPrice,
    String? productImage,
    num? productSize,
    String? productColor,
    int? productQuantity,
    int? sellerId,
    String? sellerName,
  }) {
    _productId = productId;
    _productName = productName;
    _productPrice = productPrice;
    _productImage = productImage;
    _productSize = productSize;
    _productColor = productColor;
    _productQuantity = productQuantity;
    _sellerId = sellerId;
    _sellerName = sellerName;
  }

  OrderedProducts.fromJson(dynamic json) {
    _productId = json['product_id'];
    _productName = json['product_name'];
    _productPrice = json['product_price'];
    _productImage = json['product_image'];
    _productSize = json['product_size'];
    _productColor = json['product_color'];
    _productQuantity = json['product_quantity'];
    _sellerId = json['seller_id'];
    _sellerName = json['seller_name'];
  }

  int? _productId;
  String? _productName;
  num? _productPrice;
  String? _productImage;
  num? _productSize;
  String? _productColor;
  int? _productQuantity;
  int? _sellerId;
  String? _sellerName;

  int get productId => _productId ?? 0;

  int get productQuantity => _productQuantity ?? 0;

  int get sellerId => _sellerId ?? 0;

  String get productName => _productName ?? "";

  String get productImage => _productImage ?? "";

  String get productColor => _productColor ?? "";

  String get sellerName => _sellerName ?? "";

  num get productPrice => _productPrice ?? 0;

  num get productSize => _productSize ?? 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['product_price'] = _productPrice;
    map['product_image'] = _productImage;
    map['product_size'] = _productSize;
    map['product_color'] = _productColor;
    map['product_quantity'] = _productQuantity;
    map['seller_id'] = _sellerId;
    map['seller_name'] = _sellerName;
    return map;
  }
}
