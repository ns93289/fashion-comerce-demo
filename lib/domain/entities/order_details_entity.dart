import 'address_entity.dart';
import 'cart_preview_entity.dart';

class OrderDetailsEntity {
  int? _orderId;
  int? _paymentStatus;
  int? _paymentMethod;
  int? _orderStatus;
  String? _orderDate;
  num? _subTotal;
  num? _totalAmount;
  num? _deliveryCharge;
  AddressEntity? _address;
  List<CartProductEntity>? _products;

  OrderDetailsEntity({
    int? orderId,
    int? paymentStatus,
    int? paymentMethod,
    int? orderStatus,
    String? orderDate,
    num? subTotal,
    num? totalAmount,
    num? deliveryCharge,
    AddressEntity? address,
    List<CartProductEntity>? products,
  }) {
    _orderId = orderId;
    _paymentStatus = paymentStatus;
    _paymentMethod = paymentMethod;
    _orderStatus = orderStatus;
    _orderDate = orderDate;
    _subTotal = subTotal;
    _totalAmount = totalAmount;
    _deliveryCharge = deliveryCharge;
    _address = address;
    _products = products;
  }

  int get orderId => _orderId ?? 0;

  int get paymentStatus => _paymentStatus ?? 0;

  int get paymentMethod => _paymentMethod ?? 0;

  int get orderStatus => _orderStatus ?? 0;

  String get orderDate => _orderDate ?? "";

  num get subTotal => _subTotal ?? 0;

  num get totalAmount => _totalAmount ?? 0;

  num get deliveryCharge => _deliveryCharge ?? 0;

  AddressEntity get address => _address ?? AddressEntity();

  List<CartProductEntity> get products => _products ?? [];
}
