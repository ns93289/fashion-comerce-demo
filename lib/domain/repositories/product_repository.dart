abstract class ProductRepository {
  Future<dynamic> getProductList({int page = 1, bool isForMale = false, bool isForFemale = false, bool isForKids = false, int categoryId = 0, int brandId = 0});

  Future<dynamic> getNewProductList({
    int page = 1,
    bool isForMale = false,
    bool isForFemale = false,
    bool isForKids = false,
    int categoryId = 0,
    int brandId = 0,
  });

  Future<dynamic> getPopularProductList({
    int page = 1,
    bool isForMale = false,
    bool isForFemale = false,
    bool isForKids = false,
    int categoryId = 0,
    int brandId = 0,
  });

  Future<dynamic> getFavoriteProductList();

  Future<dynamic> favoriteProduct({required int productId, required int favorite});
}
