import '../../domain/entities/product_entity.dart';

class ModelProduct extends ProductEntity {
  ModelProduct({
    super.productId,
    super.genderType,
    super.productName,
    super.productImage,
    super.categoryName,
    super.sellerName,
    super.productCare,
    super.productDesign,
    super.productCountry,
    super.productMaterial,
    super.selectedColor,
    super.productDescription,
    super.productPrice,
    super.averageRatings,
    super.noOfReview,
    super.favorite,
    super.isBestSeller,
    super.sellerId,
    super.selectedQuantity,
    super.selectedSize,
    super.productDiscount,
    super.discountType,
    super.productStoke,
    super.deliveryCharge,
    super.expressCharge,
    super.productDiscountPrice,
    super.isForMale,
    super.isForFemale,
    super.isForKids,
  });

  factory ModelProduct.fromJson(Map<String, dynamic> json) {
    return ModelProduct(
      productId: json['id'],
      genderType: json['gender_type'],
      productName: json['name'],
      productImage: json['image_url'],
      categoryName: json['sub_category'],
      productPrice: json['final_price'],
      discountType: json['discount_type'],
      productDiscount: json['discount_value'],
      productDiscountPrice: json['price'],
      productStoke: json['stoke'],
      favorite: json['favorite'],
      productDescription: json['description'],
      noOfReview: json['no_of_review'],
      averageRatings: json['average_ratings'],
      isBestSeller: json['is_best_seller'],
      sellerId: json['seller_id'],
      sellerName: json['seller_name'],
      productCare: json['care'],
      productDesign: json['design'],
      productCountry: json['country'],
      productMaterial: json['material'],
      selectedColor: json['color'],
      selectedSize: json['size'],
      isForMale: json['is_for_male'],
      isForFemale: json['is_for_female'],
      isForKids: json['is_for_kids'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = productId;
    map['gender_type'] = genderType;
    map['name'] = productName;
    map['image_url'] = productImage;
    map['sub_category'] = categoryName;
    map['final_price'] = productPrice;
    map['price'] = productDiscountPrice;
    map['discount_type'] = discountType;
    map['discount_value'] = productDiscount;
    map['stoke'] = productStoke;
    map['favorite'] = favorite;
    map['description'] = productDescription;
    map['no_of_review'] = noOfReview;
    map['average_ratings'] = averageRatings;
    map['is_best_seller'] = isBestSeller;
    map['seller_id'] = sellerId;
    map['seller_name'] = sellerName;
    map['care'] = productCare;
    map['design'] = productDesign;
    map['country'] = productCountry;
    map['material'] = productMaterial;
    map['color'] = selectedColor;
    map['selected_quantity'] = selectedQuantity;
    map['size'] = selectedSize;
    map['is_for_male'] = isForMale;
    map['is_for_female'] = isForFemale;
    map['is_for_kids'] = isForKids;
    return map;
  }
}
