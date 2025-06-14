import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/home_service.dart';
import '../../core/constants/app_constants.dart';
import '../../application/brands_service.dart';
import '../../application/product_service.dart';
import '../../application/slider_service.dart';
import '../../data/repositories/brands_repo_impl.dart';
import '../../data/repositories/home_repo_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/slider_repo_impl.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/brands_entity.dart';
import '../../data/models/model_product.dart';
import '../../domain/entities/slider_entity.dart';
import '../../domain/repositories/brands_repo.dart';
import '../../domain/repositories/home_repo.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/slider_repo.dart';

class DataNotifier extends AsyncNotifier<List<ProductEntity>> {
  @override
  Future<List<ProductEntity>> build() async {
    return await fetchDataFromApi();
  }

  Future<void> refreshData() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => fetchDataFromApi());
  }
}

Future<List<ModelProduct>> fetchDataFromApi() async {
  List<ModelProduct> productList = globalProductList;
  return productList;
}

const String temDesc =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
final List<String> colorList = ["#EBEBEB", "#2A2A2A", "#0C29B9", "#FF3333", "#0CA8B9", "#E4A719", "#9D3CB9"];
final List<ModelProduct> globalProductList = [
  ModelProduct(
    productId: 1,
    productName: "Bru",
    categoryName: "Basketball",
    productPrice: 40.10,
    averageRatings: 4.1,
    noOfReview: 6,
    genderType: GenderTypes.male,
    productDescription: temDesc,
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Soft Leather",
    productDesign: "Home",
    productImage: "assets/images/bru.png",
  ),
  ModelProduct(
    productId: 2,
    productName: "Classic Slip-On",
    categoryName: "Casual",
    productPrice: 77.65,
    averageRatings: 4.3,
    noOfReview: 6,
    genderType: GenderTypes.female,
    productDescription: temDesc,
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Soft Leather",
    productDesign: "Home",
    productImage: "assets/images/classic_slip_on.png",
  ),
  ModelProduct(
    productId: 3,
    productName: "GrandPro Tennis Sneaker",
    categoryName: "Sneakers",
    productPrice: 50,
    averageRatings: 4.0,
    noOfReview: 6,
    genderType: GenderTypes.female,
    productDescription: temDesc,
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Leather",
    productDesign: "Sports",
    productImage: "assets/images/grandpro_tennis_sneaker.png",
  ),
  ModelProduct(
    productId: 4,
    productName: "Women's Arizona Sandals",
    categoryName: "Sandals",
    productPrice: 66.35,
    averageRatings: 4.5,
    noOfReview: 6,
    genderType: GenderTypes.female,
    productDescription: temDesc,
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Rubber",
    productDesign: "Sandals",
    productImage: "assets/images/women_arizona_sandals.png",
  ),
  ModelProduct(
    productId: 5,
    productName: "Air Max 90",
    categoryName: "Sneakers",
    productPrice: 44.30,
    averageRatings: 4.2,
    noOfReview: 6,
    productDescription: temDesc,
    sellerId: 1,
    genderType: GenderTypes.male,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Leather",
    productDesign: "Sports",
    productImage: "assets/images/air_max_90.png",
  ),
  ModelProduct(
    productId: 6,
    productName: "Zoom Freak 4",
    categoryName: "Basketball",
    productPrice: 55.50,
    averageRatings: 4.2,
    noOfReview: 6,
    genderType: GenderTypes.male,
    productDescription: temDesc,
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Leather",
    productDesign: "Sports",
    productImage: "assets/images/zoom_freak_4.png",
  ),
  ModelProduct(
    productId: 7,
    productName: "Gel Kayano 29",
    categoryName: "Running",
    productPrice: 35,
    averageRatings: 4.2,
    noOfReview: 6,
    genderType: GenderTypes.male,
    productDescription: temDesc,
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Leather",
    productDesign: "Sports",
    productImage: "assets/images/gel_kayano_29.png",
  ),
];

final homeRepoProvider = Provider.autoDispose<HomeRepo>((ref) {
  return HomeRepoImpl();
});

final homeCategoryServiceProvider = StateNotifierProvider<HomeService, AsyncValue<dynamic>>((ref) {
  final service = HomeService(ref.watch(homeRepoProvider));
  service.callHomeCategories();
  return service;
});

final sliderRepoProvider = Provider.autoDispose<SliderRepo>((ref) {
  return SliderRepoImpl();
});
final sliderServiceProvider = StateNotifierProvider<SliderService, AsyncValue<List<SliderEntity>>?>((ref) {
  final service = SliderService(ref.watch(sliderRepoProvider));
  service.callSliderApi();
  return service;
});

final brandsRepoProvider = Provider.autoDispose<BrandsRepo>((ref) {
  return BrandsRepoImpl();
});
final brandsServiceProvider = StateNotifierProvider<BrandsService, AsyncValue<List<BrandsEntity>>?>((ref) {
  final service = BrandsService(ref.watch(brandsRepoProvider));
  service.callBrandsApi();
  return service;
});

final productRepoProvider = Provider.autoDispose<ProductRepository>((ref) {
  return ProductRepositoryImpl();
});

final newProductServiceProvider = StateNotifierProvider<ProductService, AsyncValue<List<ProductEntity>>?>((ref) {
  final service = ProductService(ref.watch(productRepoProvider));
  service.callNewArrivalProductsApi();
  return service;
});
final popularProductServiceProvider = StateNotifierProvider<ProductService, AsyncValue<List<ProductEntity>>?>((ref) {
  final service = ProductService(ref.watch(productRepoProvider));
  service.callPopularProductsApi();
  return service;
});
final allProductServiceProvider = StateNotifierProvider<ProductService, AsyncValue<List<ProductEntity>>?>((ref) {
  final service = ProductService(ref.watch(productRepoProvider));
  service.callProductsApi();
  return service;
});

final newProductProvider = FutureProvider.autoDispose<List<ProductEntity>>((ref) {
  return [globalProductList[1], globalProductList[2], globalProductList[3], globalProductList[4]];
});

final allProductProvider = AsyncNotifierProvider<DataNotifier, List<ProductEntity>>(DataNotifier.new);

final popularProductProvider = FutureProvider.autoDispose<List<ProductEntity>>((ref) {
  return [globalProductList[5], globalProductList[3], globalProductList[2], globalProductList[1]];
});

final productBrandsProvider = FutureProvider.autoDispose<List<BrandsEntity>>((ref) {
  return [
    BrandsEntity(id: 0, name: "Nike", image: "assets/images/nike.png"),
    BrandsEntity(id: 0, name: "Nike", image: "assets/images/nike.png"),
    BrandsEntity(id: 0, name: "Nike", image: "assets/images/nike.png"),
    BrandsEntity(id: 0, name: "Nike", image: "assets/images/nike.png"),
    BrandsEntity(id: 0, name: "Nike", image: "assets/images/nike.png"),
    BrandsEntity(id: 0, name: "Nike", image: "assets/images/nike.png"),
  ];
});
