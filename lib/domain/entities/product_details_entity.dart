class ProductDetailsEntity {
  int? _id;
  int? _reviewCount;
  int? _stock;
  int? _productVariantId;
  int? _discountType;
  int? _quantity;
  String? _name;
  String? _description;
  String? _care;
  String? _design;
  String? _country;
  String? _material;
  String? _subCategory;
  num? _deliveryCharge;
  num? _expressCharge;
  num? _price;
  num? _averageReview;
  num? _discountValue;
  num? _discountPrice;
  bool? _isFavourite;
  List<String>? _uniqueColors;
  List<String>? _uniqueSizes;
  List<String>? _images;
  List<ReviewListEntity>? _reviewList;

  ProductDetailsEntity({
    int? id,
    int? reviewCount,
    int? stock,
    int? productVariantId,
    int? quantity,
    String? name,
    String? description,
    String? care,
    String? design,
    String? country,
    String? material,
    String? subCategory,
    num? deliveryCharge,
    num? expressCharge,
    int? discountType,
    num? price,
    num? averageReview,
    num? discountValue,
    num? discountPrice,
    bool? isFavourite,
    List<String>? uniqueColors,
    List<String>? uniqueSizes,
    List<String>? images,
    List<ReviewListEntity>? reviewList,
  }) {
    _id = id;
    _reviewCount = reviewCount;
    _stock = stock;
    _productVariantId = productVariantId;
    _quantity = quantity;
    _name = name;
    _description = description;
    _care = care;
    _design = design;
    _country = country;
    _material = material;
    _subCategory = subCategory;
    _deliveryCharge = deliveryCharge;
    _expressCharge = expressCharge;
    _discountType = discountType;
    _price = price;
    _averageReview = averageReview;
    _discountValue = discountValue;
    _discountPrice = discountPrice;
    _isFavourite = isFavourite;
    _uniqueColors = uniqueColors;
    _uniqueSizes = uniqueSizes;
    _images = images;
    _reviewList = reviewList;
  }

  int get id => _id ?? 0;

  int get reviewCount => _reviewCount ?? 0;

  int get stock => _stock ?? 0;

  int get productVariantId => _productVariantId ?? 0;

  int get quantity => _quantity ?? 0;

  String get name => _name ?? '';

  String get description => _description ?? '';

  String get care => _care ?? '';

  String get design => _design ?? '';

  String get country => _country ?? '';

  String get material => _material ?? '';

  String get subCategory => _subCategory ?? '';

  num get deliveryCharge => _deliveryCharge ?? 0;

  num get expressCharge => _expressCharge ?? 0;

  int get discountType => _discountType ?? 0;

  num get price => _price ?? 0;

  num get averageReview => _averageReview ?? 0;

  num get discountValue => _discountValue ?? 0;

  num get discountPrice => _discountPrice ?? 0;

  bool get isFavourite => _isFavourite ?? false;

  List<String> get uniqueColors => _uniqueColors ?? [];

  List<String> get uniqueSizes => _uniqueSizes ?? [];

  List<String> get images => _images ?? [];

  List<ReviewListEntity> get reviewList => _reviewList ?? [];
}

class ReviewListEntity {
  int? _id;
  int? _productId;
  int? _userId;
  num? _rating;
  String? _comment;
  String? _name;
  String? _profilePictureUrl;

  ReviewListEntity({int? id, int? productId, int? userId, num? rating, String? comment, String? name, String? profilePictureUrl}) {
    _id = id;
    _productId = productId;
    _userId = userId;
    _rating = rating;
    _comment = comment;
    _name = name;
    _profilePictureUrl = profilePictureUrl;
  }

  int get id => _id ?? 0;

  int get productId => _productId ?? 0;

  int get userId => _userId ?? 0;

  num get rating => _rating ?? 0;

  String get comment => _comment ?? '';

  String get name => _name ?? '';

  String get profilePictureUrl => _profilePictureUrl ?? '';
}
