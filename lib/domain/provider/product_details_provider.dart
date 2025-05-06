import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/model_product.dart';

final productDetailsProvider = Provider<ModelProduct>((ref) {
  return ModelProduct(
    id: 1,
    name: "Air Max Pre-Day",
    category: "Lifestyle",
    price: 77.65,
    averageRatings: 4.2,
    noOfReview: 6,
    description: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    sizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Seller Name",
    productCare: "Only apply dry cleaning",
    productCountry: "India",
    productMaterial: "Rubber Cloth",
    productDesign: "Sports",
    productQuantities: [1, 2, 3, 4, 5],
  );
});

final productSizeProvider = StateProvider<num>((ref) => 0);

final productQuantityProvider = StateProvider<int>((ref) => 1);
