import '../../domain/entities/product_details_entity.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  ProductDetailsModel({
    super.id,
    super.reviewCount,
    super.stock,
    super.productVariantId,
    super.quantity,
    super.name,
    super.description,
    super.care,
    super.design,
    super.country,
    super.material,
    super.subCategory,
    super.deliveryCharge,
    super.expressCharge,
    super.discountType,
    super.discountPrice,
    super.price,
    super.averageReview,
    super.discountValue,
    super.isFavourite,
    super.uniqueColors,
    super.uniqueSizes,
    super.images,
    super.reviewList,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      reviewCount: json['review_count'],
      stock: json['stock'],
      productVariantId: json['product_variant_id'],
      quantity: json['quantity'],
      name: json['name'],
      description: json['description'],
      care: json['care'],
      design: json['design'],
      country: json['country'],
      material: json['material'],
      subCategory: json['sub_category'],
      deliveryCharge: json['delivery_charge'],
      expressCharge: json['express_charge'],
      discountType: json['discount_type'],
      price: json['final_price'],
      discountPrice: json['price'],
      averageReview: json['average_review'],
      discountValue: json['discount_value'],
      isFavourite: json['is_favourite'],
      uniqueColors: json['unique_colors'] != null ? List<String>.from(json['unique_colors']) : [],
      uniqueSizes: json['unique_sizes'] != null ? List<String>.from(json['unique_sizes']) : [],
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      reviewList: json['review_list'] != null ? List<ReviewListEntity>.from(json['review_list'].map((x) => ReviewListModel.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['review_count'] = reviewCount;
    data['stock'] = stock;
    data['product_variant_id'] = productVariantId;
    data['quantity'] = quantity;
    data['name'] = name;
    data['description'] = description;
    data['care'] = care;
    data['design'] = design;
    data['country'] = country;
    data['material'] = material;
    data['sub_category'] = subCategory;
    data['delivery_charge'] = deliveryCharge;
    data['express_charge'] = expressCharge;
    data['discount_type'] = discountType;
    data['final_price'] = price;
    data['price'] = discountPrice;
    data['average_review'] = averageReview;
    data['discount_value'] = discountValue;
    data['is_favourite'] = isFavourite;
    data['unique_colors'] = uniqueColors;
    data['unique_sizes'] = uniqueSizes;
    data['images'] = images;
    data['review_list'] = reviewList;
    return data;
  }
}

class ReviewListModel extends ReviewListEntity {
  ReviewListModel({super.id, super.productId, super.userId, super.rating, super.comment, super.name, super.profilePictureUrl});

  factory ReviewListModel.fromJson(Map<String, dynamic> json) {
    return ReviewListModel(
      id: json['id'],
      productId: json['product_id'],
      userId: json['user_id'],
      rating: json['rating'],
      comment: json['comment'],
      name: json['name'],
      profilePictureUrl: json['profile_picture_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['user_id'] = userId;
    data['rating'] = rating;
    data['comment'] = comment;
    data['name'] = name;
    data['profile_picture_url'] = profilePictureUrl;
    return data;
  }
}
