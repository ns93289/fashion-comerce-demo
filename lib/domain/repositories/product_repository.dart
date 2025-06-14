abstract class ProductRepository {
  Future<dynamic> getProductList({int page = 1, bool isForMale = false, bool isForFemale = false, bool isForKids = false});

  Future<dynamic> getNewProductList({int page = 1, bool isForMale = false, bool isForFemale = false, bool isForKids = false});

  Future<dynamic> getPopularProductList({int page = 1, bool isForMale = false, bool isForFemale = false, bool isForKids = false});

  Future<dynamic> getFavoriteProductList({int page = 1, bool isForMale = false, bool isForFemale = false, bool isForKids = false});

  Future<dynamic> favoriteProduct({required int productId, required int favorite});
}
