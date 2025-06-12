import '../../domain/entities/order_history_entity.dart';

class OrderHistoryModel extends OrderHistoryEntity {
  OrderHistoryModel({super.orderId, super.productImage, super.productName, super.orderedTime, super.orderNo});

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      orderId: json['order_id'],
      productImage: json['image'],
      productName: json['product_name'],
      orderedTime: json['order_date'],
      orderNo: json['order_no'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['image'] = productImage;
    data['product_name'] = productName;
    data['order_date'] = orderedTime;
    data['order_no'] = orderNo;
    return data;
  }
}
