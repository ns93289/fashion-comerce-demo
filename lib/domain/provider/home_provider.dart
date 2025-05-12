import 'package:fashion_comerce_demo/core/utils/tools.dart';
import 'package:fashion_comerce_demo/main.dart';
import 'package:fashion_comerce_demo/presentation/screens/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/model_drawer.dart';
import '../../data/models/model_product.dart';

final List<ModelProduct> globalProductList = [
  ModelProduct(
    id: 1,
    name: "Classic Slip-On",
    category: "Casual",
    price: 77.65,
    averageRatings: 4.3,
    noOfReview: 6,
    description: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    sizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Soft Leather",
    productDesign: "Home",
    image: "assets/images/classic_slip_on.png",
    productColors: ["Checkerboard", "Black"],
    productQuantities: [1, 2, 3, 4, 5],
  ),
  ModelProduct(
    id: 2,
    name: "GrandPro Tennis Sneaker",
    category: "Sneakers",
    price: 50,
    averageRatings: 4.0,
    noOfReview: 6,
    description: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    sizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Leather",
    productDesign: "Sports",
    image: "assets/images/grandpro_tennis_sneaker.png",
    productColors: ["White", "Tan", "Navy"],
    productQuantities: [1, 2, 3, 4, 5],
  ),
  ModelProduct(
    id: 3,
    name: "Women's Arizona Sandals",
    category: "Sandals",
    price: 66.35,
    averageRatings: 4.5,
    noOfReview: 6,
    description: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    sizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Rubber",
    productDesign: "Sandals",
    image: "assets/images/women_arizona_sandals.png",
    productColors: ["White", "Black", "Brown"],
    productQuantities: [1, 2, 3, 4, 5],
  ),
  ModelProduct(
    id: 4,
    name: "Air Max 90",
    category: "Sneakers",
    price: 44.30,
    averageRatings: 4.2,
    noOfReview: 6,
    description: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    sizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Leather",
    productDesign: "Sports",
    image: "assets/images/air_max_90.png",
    productColors: ["White", "Black", "Red"],
    productQuantities: [1, 2, 3, 4, 5],
  ),
  ModelProduct(
    id: 5,
    name: "Zoom Freak 4",
    category: "Basketball",
    price: 55.50,
    averageRatings: 4.2,
    noOfReview: 6,
    description: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    sizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Leather",
    productDesign: "Sports",
    image: "assets/images/zoom_freak_4.png",
    productColors: ["Multicolor", "Black"],
    productQuantities: [1, 2, 3, 4, 5],
  ),
  ModelProduct(
    id: 6,
    name: "Gel Kayano 29",
    category: "Running",
    price: 35,
    averageRatings: 4.2,
    noOfReview: 6,
    description: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    sizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Leather",
    productDesign: "Sports",
    image: "assets/images/gel_kayano_29.png",
    productColors: ["Blue", "Black", "Green"],
    productQuantities: [1, 2, 3, 4, 5],
  ),
];

final List<ModelDrawer> drawerList = [
  ModelDrawer(screen: Container(), title: language.myProfile, icon: Icons.person_outline),
  ModelDrawer(screen: WalletScreen(), title: language.wallet, icon: Icons.wallet_outlined),
  ModelDrawer(screen: Container(), title: language.preferences, icon: Icons.settings_outlined),
  ModelDrawer(screen: Container(), title: language.helpAndSupport, icon: Icons.help_outline),
  ModelDrawer(screen: Container(), title: language.logout, icon: Icons.logout_outlined),
];

final homeScaffoldKey = GlobalKey<ScaffoldState>();

final categoryListProvider = Provider<List<ModelProductFilter>>((ref) {
  List<ModelProductFilter> filters = [
    ModelProductFilter(id: 1, categoryIcon: "assets/images/air_max_90.png", categoryName: "Sneakers"),
    ModelProductFilter(id: 2, categoryIcon: "assets/images/zoom_freak_4.png", categoryName: "Basketball"),
    ModelProductFilter(id: 3, categoryIcon: "assets/images/gel_kayano_29.png", categoryName: "Running"),
    ModelProductFilter(id: 4, categoryIcon: "assets/images/classic_slip_on.png", categoryName: "Office"),
    ModelProductFilter(id: 5, categoryIcon: "assets/images/grandpro_tennis_sneaker.png", categoryName: "Casual"),
  ];
  return filters;
});

final newProductProvider = FutureProvider.autoDispose<List<ModelProduct>>((ref) {
  return [globalProductList[1], globalProductList[2], globalProductList[3], globalProductList[4]];
});

final allProductProvider = FutureProvider.autoDispose<List<ModelProduct>>((ref) {
  return globalProductList;
});

final popularProductProvider = FutureProvider.autoDispose<List<ModelProduct>>((ref) {
  return [globalProductList[5], globalProductList[3], globalProductList[2], globalProductList[1]];
});

final openDrawerItemProvider = Provider.family<int, ({ModelDrawer drawerItem, BuildContext context})>((ref, args) {
  homeScaffoldKey.currentState?.closeDrawer();
  if (args.drawerItem.screen is! Container) {
    openScreen(args.context, args.drawerItem.screen);
  }
  return 0;
});
