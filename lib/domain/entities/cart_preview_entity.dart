class CartPreviewEntity {
  num? _subtotal;
  num? _total;
  List<CartProductEntity>? _products;

  CartPreviewEntity({num? subtotal, num? total, List<CartProductEntity>? products}) {
    _subtotal = subtotal;
    _total = total;
    _products = products;
  }

  num get total => _total ?? 0;

  num get subtotal => _subtotal ?? 0;

  List<CartProductEntity> get products => _products ?? [];
}

class CartProductEntity {
  int? _cartId;
  int? _productId;
  int? _quantity;
  int? _genderId;
  int? _variantId;
  int? _discountType;
  String? _productName;
  String? _subCategory;
  String? _size;
  String? _color;
  String? _imageUrl;
  num? _price;
  num? _discountValue;
  num? _finalPrice;
  num? _itemTotal;

  CartProductEntity({
    int? cartId,
    int? productId,
    int? quantity,
    int? genderId,
    int? variantId,
    int? discountType,
    String? productName,
    String? subCategory,
    String? size,
    String? color,
    String? imageUrl,
    num? price,
    num? discountValue,
    num? finalPrice,
    num? itemTotal,
  }) {
    _cartId = cartId;
    _productId = productId;
    _quantity = quantity;
    _genderId = genderId;
    _variantId = variantId;
    _discountType = discountType;
    _productName = productName;
    _subCategory = subCategory;
    _size = size;
    _color = color;
    _imageUrl = imageUrl;
    _price = price;
    _discountValue = discountValue;
    _finalPrice = finalPrice;
    _itemTotal = itemTotal;
  }

  int get cartId => _cartId ?? 0;

  int get productId => _productId ?? 0;

  int get quantity => _quantity ?? 0;

  int get genderId => _genderId ?? 0;

  int get variantId => _variantId ?? 0;

  int get discountType => _discountType ?? 0;

  String get productName => _productName ?? "";

  String get subCategory => _subCategory ?? "";

  String get size => _size ?? "";

  String get color => _color ?? "";

  String get imageUrl => _imageUrl ?? "";

  num get price => _price ?? 0;

  num get discountValue => _discountValue ?? 0;

  num get finalPrice => _finalPrice ?? 0;

  num get itemTotal => _itemTotal ?? 0;
}
