class ProductEntity {
  int? _productId;
  int? _sellerId;
  int? _selectedQuantity;
  int? _discountType;
  int? _productStoke;
  int? _genderType;
  String? _productName;
  String? _productImage;
  String? _categoryName;
  String? _productDescription;
  String? _productCare;
  String? _productDesign;
  String? _productCountry;
  String? _productMaterial;
  String? _sellerName;
  String? _selectedColor;
  String? _selectedSize;
  num? _productPrice;
  num? _noOfReview;
  num? _averageRatings;
  num? _productDiscount;
  num? _productDiscountPrice;
  num? _deliveryCharge;
  num? _expressCharge;
  bool? _favorite;
  bool? _isBestSeller;
  bool? _isForMale;
  bool? _isForFemale;
  bool? _isForKids;

  ProductEntity({
    int? productId,
    int? sellerId,
    int? selectedQuantity,
    int? discountType,
    int? productStoke,
    int? genderType,
    String? productName,
    String? productImage,
    String? categoryName,
    String? sellerName,
    String? productCare,
    String? productDesign,
    String? productCountry,
    String? productMaterial,
    String? selectedColor,
    String? productDescription,
    String? selectedSize,
    num? productPrice,
    num? noOfReview,
    num? averageRatings,
    num? productDiscount,
    num? deliveryCharge,
    num? expressCharge,
    num? productDiscountPrice,
    bool? favorite,
    bool? isBestSeller,
    bool? isForMale,
    bool? isForFemale,
    bool? isForKids,
  }) {
    _productId = productId;
    _sellerId = sellerId;
    _selectedQuantity = selectedQuantity;
    _discountType = discountType;
    _productStoke = productStoke;
    _genderType = genderType;
    _productName = productName;
    _productImage = productImage;
    _categoryName = categoryName;
    _productPrice = productPrice;
    _favorite = favorite;
    _productDescription = productDescription;
    _noOfReview = noOfReview;
    _averageRatings = averageRatings;
    _selectedSize = selectedSize;
    _productDiscount = productDiscount;
    _deliveryCharge = deliveryCharge;
    _expressCharge = expressCharge;
    _productDiscountPrice = productDiscountPrice;
    _isBestSeller = isBestSeller;
    _sellerName = sellerName;
    _productCare = productCare;
    _productDesign = productDesign;
    _productCountry = productCountry;
    _productMaterial = productMaterial;
    _selectedColor = selectedColor;
    _isForMale = isForMale;
    _isForFemale = isForFemale;
    _isForKids = isForKids;
  }

  ProductEntity copyWith({bool? favorite}) {
    return ProductEntity(
      productId: _productId,
      favorite: favorite,
      sellerId: _sellerId,
      selectedQuantity: _selectedQuantity,
      discountType: _discountType,
      productStoke: _productStoke,
      genderType: _genderType,
      productName: _productName,
      productImage: _productImage,
      categoryName: _categoryName,
      productDescription: _productDescription,
      productCare: _productCare,
      productDesign: _productDesign,
      productCountry: _productCountry,
      productMaterial: _productMaterial,
      sellerName: _sellerName,
      productPrice: _productPrice,
      noOfReview: _noOfReview,
      averageRatings: _averageRatings,
      productDiscount: _productDiscount,
      deliveryCharge: _deliveryCharge,
      expressCharge: _expressCharge,
      productDiscountPrice: _productDiscountPrice,
      isBestSeller: _isBestSeller,
      selectedColor: _selectedColor,
      selectedSize: _selectedSize,
      isForMale: _isForMale,
      isForFemale: _isForFemale,
      isForKids: _isForKids,
    );
  }

  int get productId => _productId ?? 0;

  int get sellerId => _sellerId ?? 0;

  int get selectedQuantity => _selectedQuantity ?? 0;

  int get discountType => _discountType ?? 0;

  int get productStoke => _productStoke ?? 0;

  int get genderType => _genderType ?? 0;

  String get productName => _productName ?? "";

  String get productImage => _productImage ?? "";

  String get categoryName => _categoryName ?? "";

  String get productDescription => _productDescription ?? "";

  String get sellerName => _sellerName ?? "";

  String get productDesign => _productDesign ?? "";

  String get productCare => _productCare ?? "";

  String get productMaterial => _productMaterial ?? "";

  String get productCountry => _productCountry ?? "";

  String get selectedColor => _selectedColor ?? "";

  String get selectedSize => _selectedSize ?? "";

  num get productPrice => _productPrice ?? 0;

  num get averageRatings => _averageRatings ?? 0;

  num get noOfReview => _noOfReview ?? 0;

  num get productDiscount => _productDiscount ?? 0;

  num get deliveryCharge => _deliveryCharge ?? 0;

  num get expressCharge => _expressCharge ?? 0;

  num get productDiscountPrice => _productDiscountPrice ?? 0;

  bool get favorite => _favorite ?? false;

  bool get isBestSeller => _isBestSeller ?? false;

  bool get isForMale => _isForMale ?? false;

  bool get isForFemale => _isForFemale ?? false;

  bool get isForKids => _isForKids ?? false;

  set favorite(bool value) {
    _favorite = value;
  }
}

enum ProductTypeEnum {
  newArrival,
  popular,
  all,
  newArrivalSubCategoryWise,
  popularSubCategoryWise,
  allSubCategoryWise,
  newArrivalBrandWise,
  popularBrandWise,
  allBrandWise,
}

class ProductParams {
  int categoryId = 0;
  int brandId = 0;
  final bool isForMale;
  final bool isForFemale;
  final bool isForKids;
  final ProductTypeEnum productTypeEnum;

  ProductParams({
    this.categoryId = 0,
    this.brandId = 0,
    this.isForMale = false,
    this.isForFemale = false,
    this.isForKids = false,
    this.productTypeEnum = ProductTypeEnum.all,
  });
}
