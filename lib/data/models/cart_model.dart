class CartModel {
  int? _quantity;
  String? _message;

  CartModel.fromJson(dynamic json) {
    _quantity = json['quantity'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['quantity'] = _quantity;
    data['message'] = _message;
    return data;
  }

  int get quantity => _quantity ?? 0;

  String get message => _message ?? '';
}

class CartQuantityModel {
  int? _productId;
  int? _quantity;

  CartQuantityModel({int? productId, int? quantity}) {
    _productId = productId;
    _quantity = quantity;
  }

  CartQuantityModel copyWith({int? productId, int? quantity}) {
    return CartQuantityModel(productId: productId ?? this.productId, quantity: quantity ?? this.quantity);
  }

  CartQuantityModel.fromJson(dynamic json) {
    _productId = json['product_id'];
    _quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['product_id'] = _productId;
    data['quantity'] = _quantity;
    return data;
  }

  int get productId => _productId ?? 0;

  int get quantity => _quantity ?? 0;

  set quantity(int value) {
    _quantity = value;
  }
}
