import '../../domain/entities/product_entity.dart';

class ModelProductFilter {
  int? _id;
  String? _categoryName;
  String? _categoryIcon;

  ModelProductFilter({int? id, String? categoryName, String? categoryIcon}) {
    _id = id;
    _categoryName = categoryName;
    _categoryIcon = categoryIcon;
  }

  int get id => _id ?? 0;

  String get categoryName => _categoryName ?? "";

  String get categoryIcon => _categoryIcon ?? "";
}

class ModelProductItem {
  int? _id;
  String? _name;
  String? _image;
  String? _category;
  num? _price;
  bool? _favorite;

  ModelProductItem({int? id, String? name, String? image, String? category, num? price, bool? favorite}) {
    _id = id;
    _name = name;
    _image = image;
    _category = category;
    _price = price;
    _favorite = favorite;
  }

  bool get favorite => _favorite ?? false;

  num get price => _price ?? 0;

  String get category => _category ?? "";

  String get image => _image ?? "";

  String get name => _name ?? "";

  int get id => _id ?? 0;

  set favorite(bool value) {
    _favorite = value;
  }
}

class ModelProduct extends ProductEntity {
  ModelProduct({
    super.productId,
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
    super.productSizes,
    super.reviewerList,
    super.productColors,
    super.productQuantities,
    super.favorite,
    super.isBestSeller,
    super.sellerId,
    super.selectedQuantity,
    super.selectedSize,
    super.productDiscount,
    super.discountType,
    super.productStoke,
  });

  factory ModelProduct.fromJson(Map<String, dynamic> json) {
    return ModelProduct(
      productId: json['id'],
      productName: json['name'],
      productImage: json['image_url'],
      categoryName: json['sub_category'],
      productPrice: json['price'],
      discountType: json['discount_type'],
      productDiscount: json['discount_value'],
      productStoke: json['stoke'],
      favorite: json['favorite'] == 1 ? true : false,
      productDescription: json['description'],
      noOfReview: json['no_of_review'],
      averageRatings: json['average_ratings'],
      isBestSeller: json['is_best_seller'] == 1 ? true : false,
      sellerId: json['seller_id'],
      sellerName: json['seller_name'],
      productCare: json['care'],
      productDesign: json['design'],
      productCountry: json['country'],
      productMaterial: json['material'],
      selectedColor: json['selected_color'],
      selectedQuantity: json['selected_quantity'],
      selectedSize: json['selected_size'],
      productSizes: (json['sizes'] as List?)?.map((e) => e as num).toList(),
      reviewerList: (json['reviewer_list'] as List?)?.map((e) => e as String).toList(),
      productColors: (json['colors'] as List?)?.map((e) => e as String).toList(),
      productQuantities: (json['quantities'] as List?)?.map((e) => e as int).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = productId;
    map['name'] = productName;
    map['image_url'] = productImage;
    map['sub_category'] = categoryName;
    map['price'] = productPrice;
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
    map['selected_color'] = selectedColor;
    map['selected_quantity'] = selectedQuantity;
    map['selected_size'] = selectedSize;
    map['sizes'] = productSizes;
    map['reviewer_list'] = reviewerList;
    map['colors'] = productColors;
    map['quantities'] = productQuantities;
    return map;
  }
}
