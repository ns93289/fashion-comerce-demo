class ProductEntity {
  int? _productId;
  int? _sellerId;
  int? _selectedQuantity;
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
  num? _productPrice;
  num? _noOfReview;
  num? _averageRatings;
  num? _selectedSize;
  List<num>? _productSizes;
  List<String>? _reviewerList;
  List<String>? _productColors;
  List<int>? _productQuantities;
  bool? _favorite;
  bool? _isBestSeller;

  ProductEntity({
    int? productId,
    int? sellerId,
    int? selectedQuantity,
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
    num? productPrice,
    num? noOfReview,
    num? averageRatings,
    num? selectedSize,
    List<num>? productSizes,
    List<String>? reviewerList,
    List<String>? productColors,
    List<int>? productQuantities,
    bool? favorite,
    bool? isBestSeller,
  }) {
    _productId = productId;
    _sellerId = sellerId;
    _selectedQuantity = selectedQuantity;
    _productName = productName;
    _productImage = productImage;
    _categoryName = categoryName;
    _productPrice = productPrice;
    _favorite = favorite;
    _productDescription = productDescription;
    _productSizes = productSizes;
    _noOfReview = noOfReview;
    _averageRatings = averageRatings;
    _selectedSize = selectedSize;
    _reviewerList = reviewerList;
    _isBestSeller = isBestSeller;
    _sellerName = sellerName;
    _productCare = productCare;
    _productDesign = productDesign;
    _productCountry = productCountry;
    _productMaterial = productMaterial;
    _productColors = productColors;
    _productQuantities = productQuantities;
    _selectedColor = selectedColor;
  }

  int get productId => _productId ?? 0;

  int get sellerId => _sellerId ?? 0;

  int get selectedQuantity => _selectedQuantity ?? 0;

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

  num get productPrice => _productPrice ?? 0;

  num get averageRatings => _averageRatings ?? 0;

  num get noOfReview => _noOfReview ?? 0;

  num get selectedSize => _selectedSize ?? 0;

  List<num> get productSizes => _productSizes ?? [];

  List<String> get reviewerList => _reviewerList ?? [];

  List<String> get productColors => _productColors ?? [];

  List<int> get productQuantities => _productQuantities ?? [];

  bool get favorite => _favorite ?? false;

  bool get isBestSeller => _isBestSeller ?? false;

  set selectedSize(num value) {
    _selectedSize = value;
  }

  set selectedQuantity(int value) {
    _selectedQuantity = value;
  }

  set favorite(bool value) {
    _favorite = value;
  }

  set selectedColor(String value) {
    _selectedColor = value;
  }
}
