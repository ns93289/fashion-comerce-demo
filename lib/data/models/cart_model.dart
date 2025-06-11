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
