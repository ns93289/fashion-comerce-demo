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
  });

  factory ModelProduct.fromJson(Map<String, dynamic> json) {
    return ModelProduct(
      productId: json['product_id'],
      productName: json['product_name'],
      productImage: json['product_image'],
      categoryName: json['category_name'],
      productPrice: json['product_price'],
      favorite: json['favorite'] == 1 ? true : false,
      productDescription: json['product_description'],
      noOfReview: json['no_of_review'],
      averageRatings: json['average_ratings'],
      isBestSeller: json['is_best_seller'] == 1 ? true : false,
      sellerId: json['seller_id'],
      sellerName: json['seller_name'],
      productCare: json['product_care'],
      productDesign: json['product_design'],
      productCountry: json['product_country'],
      productMaterial: json['product_material'],
      selectedColor: json['selected_color'],
      selectedQuantity: json['selected_quantity'],
      selectedSize: json['selected_size'],
      productSizes: (json['product_sizes'] as List?)?.map((e) => e as num).toList(),
      reviewerList: (json['reviewer_list'] as List?)?.map((e) => e as String).toList(),
      productColors: (json['product_colors'] as List?)?.map((e) => e as String).toList(),
      productQuantities: (json['product_quantities'] as List?)?.map((e) => e as int).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['product_image'] = productImage;
    map['category_name'] = categoryName;
    map['product_price'] = productPrice;
    map['favorite'] = favorite;
    map['product_description'] = productDescription;
    map['no_of_review'] = noOfReview;
    map['average_ratings'] = averageRatings;
    map['is_best_seller'] = isBestSeller;
    map['seller_id'] = sellerId;
    map['seller_name'] = sellerName;
    map['product_care'] = productCare;
    map['product_design'] = productDesign;
    map['product_country'] = productCountry;
    map['product_material'] = productMaterial;
    map['selected_color'] = selectedColor;
    map['selected_quantity'] = selectedQuantity;
    map['selected_size'] = selectedSize;
    map['product_sizes'] = productSizes;
    map['reviewer_list'] = reviewerList;
    map['product_colors'] = productColors;
    map['product_quantities'] = productQuantities;
    return map;
  }
}
