abstract class CategoriesRepo {
  Future<dynamic> getCategories({required int genderId});

  Future<dynamic> getSubCategories({required int categoryId, bool isForMale = false, bool isForFemale = false, bool isForKids = false});
}
