import '../../domain/entities/cart_preview_entity.dart';

class CartPreviewModel extends CartPreviewEntity {
  CartPreviewModel({super.subtotal, super.total, super.products});

  factory CartPreviewModel.fromJson(Map<String, dynamic> json) {
    return CartPreviewModel(
      subtotal: json['subtotal'],
      total: json['total'],
      products: (json['products'] as List?)?.map((e) => CartProductModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['subtotal'] = subtotal;
    data['total'] = total;
    data['products'] = products.map((e) => (e as CartProductModel).toJson()).toList();
    return data;
  }
}

class CartProductModel extends CartProductEntity {
  CartProductModel({
    super.cartId,
    super.productId,
    super.quantity,
    super.genderId,
    super.variantId,
    super.discountType,
    super.productName,
    super.subCategory,
    super.size,
    super.color,
    super.imageUrl,
    super.price,
    super.discountValue,
    super.finalPrice,
    super.itemTotal,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      cartId: json['cart_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      genderId: json['gender_id'],
      variantId: json['variant_id'],
      discountType: json['discount_type'],
      productName: json['product_name'],
      subCategory: json['sub_category'],
      size: json['size'],
      color: json['color'],
      imageUrl: json['image_url'],
      price: json['price'],
      discountValue: json['discount_value'],
      finalPrice: json['final_price'],
      itemTotal: json['item_total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cart_id'] = cartId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['gender_id'] = genderId;
    data['variant_id'] = variantId;
    data['discount_type'] = discountType;
    data['product_name'] = productName;
    data['sub_category'] = subCategory;
    data['size'] = size;
    data['color'] = color;
    data['image_url'] = imageUrl;
    data['price'] = price;
    data['discount_value'] = discountValue;
    data['final_price'] = finalPrice;
    data['item_total'] = itemTotal;
    return data;
  }
}
