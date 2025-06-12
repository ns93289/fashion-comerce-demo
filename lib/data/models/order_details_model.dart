import '../../domain/entities/cart_preview_entity.dart';
import '../../domain/entities/order_details_entity.dart';
import 'cart_preview_model.dart';
import 'model_address.dart';

class OrderDetailsModel extends OrderDetailsEntity {
  OrderDetailsModel({
    super.orderId,
    super.paymentStatus,
    super.paymentMethod,
    super.orderStatus,
    super.orderDate,
    super.subTotal,
    super.totalAmount,
    super.deliveryCharge,
    super.address,
    super.products,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      orderId: json['order_id'],
      paymentStatus: json['payment_status'],
      paymentMethod: json['payment_method'],
      orderStatus: json['order_status'],
      orderDate: json['order_date'],
      subTotal: json['subtotal'],
      totalAmount: json['total_amount'],
      deliveryCharge: json['delivery_charge'],
      address: json['address'] != null ? ModelAddress.fromJson(json['address']) : null,
      products: json['product'] != null ? List<CartProductEntity>.from(json['product'].map((x) => CartProductModel.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'order_id': orderId,
    'payment_status': paymentStatus,
    'payment_method': paymentMethod,
    'order_status': orderStatus,
    'order_date': orderDate,
    'subtotal': subTotal,
    'total_amount': totalAmount,
    'delivery_charge': deliveryCharge,
    'address': (address as ModelAddress).toJson(),
    'product': List<dynamic>.from(products.map((x) => (x as CartProductModel).toJson())),
  };
}
