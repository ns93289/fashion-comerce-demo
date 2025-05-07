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

class ModelProduct {
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

  ModelProduct({
    int? id,
    int? sellerId,
    String? name,
    String? image,
    String? category,
    String? sellerName,
    String? productCare,
    String? productDesign,
    String? productCountry,
    String? productMaterial,
    num? price,
    bool? favorite,
    bool? isBestSeller,
    String? description,
    List<num>? sizes,
    List<String>? reviewerList,
    List<String>? productColors,
    List<int>? productQuantities,
    num? noOfReview,
    num? averageRatings,
  }) {
    _productId = id;
    _productName = name;
    _productImage = image;
    _categoryName = category;
    _productPrice = price;
    _favorite = favorite;
    _productDescription = description;
    _productSizes = sizes;
    _noOfReview = noOfReview;
    _averageRatings = averageRatings;
    _reviewerList = reviewerList;
    _isBestSeller = isBestSeller;
    _sellerId = sellerId;
    _sellerName = sellerName;
    _productCare = productCare;
    _productDesign = productDesign;
    _productCountry = productCountry;
    _productMaterial = productMaterial;
    _productColors = productColors;
    _productQuantities = productQuantities;
  }

  bool get favorite => _favorite ?? false;

  bool get isBestSeller => _isBestSeller ?? false;

  String get categoryName => _categoryName ?? "";

  String get productImage => _productImage ?? "";

  String get productName => _productName ?? "";

  String get productDescription => _productDescription ?? "";

  String get sellerName => _sellerName ?? "";

  String get productDesign => _productDesign ?? "";

  String get productCare => _productCare ?? "";

  String get productMaterial => _productMaterial ?? "";

  String get productCountry => _productCountry ?? "";

  int get productId => _productId ?? 0;

  int get sellerId => _sellerId ?? 0;

  int get selectedQuantity => _selectedQuantity ?? 0;

  num get productPrice => _productPrice ?? 0;

  num get averageRatings => _averageRatings ?? 0;

  num get noOfReview => _noOfReview ?? 0;

  num get selectedSize => _selectedSize ?? 0;

  List<num> get productSizes => _productSizes ?? [];

  List<String> get reviewerList => _reviewerList ?? [];

  List<String> get productColors => _productColors ?? [];

  List<int> get productQuantities => _productQuantities ?? [];

  set selectedSize(num value) {
    _selectedSize = value;
  }

  set selectedQuantity(int value) {
    _selectedQuantity = value;
  }

  ModelProduct.fromJson(dynamic json) {
    _productId = json['product_id'];
    _productName = json['product_name'];
    _productPrice = json['product_price'];
    _productDescription = json['product_description'];
    _selectedSize = json['selected_size'];
    _selectedQuantity = json['selected_quantity'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['product_price'] = _productPrice;
    map['product_description'] = _productDescription;
    map['selected_size'] = _selectedSize;
    map['selected_quantity'] = _selectedQuantity;
    return map;
  }
}
