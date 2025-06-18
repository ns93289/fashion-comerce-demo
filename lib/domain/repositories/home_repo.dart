abstract class HomeRepo {
  Future<dynamic> getHomeCategories();

  Future<dynamic> searchAll({required String query});
}
