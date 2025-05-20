import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/tools.dart';
import '../../data/dataSources/local/hive_helper.dart';
import '../../main.dart';
import '../../presentation/dialogs/common_dialog.dart';
import '../../presentation/screens/address/my_address_screen.dart';
import '../../presentation/screens/helpAndSupprt/help_and_support_screen.dart';
import '../../presentation/screens/preferences/preferences_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/wallet/wallet_screen.dart';
import '../../data/models/model_drawer.dart';
import '../../data/models/model_product.dart';
import '../../presentation/screens/myProfile/my_profile_screen.dart';

class DataNotifier extends AsyncNotifier<List<ModelProduct>> {
  @override
  Future<List<ModelProduct>> build() async {
    return await fetchDataFromApi();
  }

  Future<void> refreshData() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => fetchDataFromApi());
  }
}

final dataProvider = AsyncNotifierProvider<DataNotifier, List<ModelProduct>>(DataNotifier.new);

Future<List<ModelProduct>> fetchDataFromApi() async {
  List<ModelProduct> productList = globalProductList;
  return productList;
}

final List<ModelProduct> globalProductList = [
  ModelProduct(
    productId: 1,
    productName: "Bru",
    categoryName: "Basketball",
    productPrice: 40.10,
    averageRatings: 4.1,
    noOfReview: 6,
    productDescription: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    productSizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Soft Leather",
    productDesign: "Home",
    productImage: "assets/images/bru.png",
    productColors: ["White", "Black"],
    productQuantities: [1, 2, 3, 4, 5],
  ),
  ModelProduct(
    productId: 2,
    productName: "Classic Slip-On",
    categoryName: "Casual",
    productPrice: 77.65,
    averageRatings: 4.3,
    noOfReview: 6,
    productDescription: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    productSizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Soft Leather",
    productDesign: "Home",
    productImage: "assets/images/classic_slip_on.png",
    productColors: ["Checkerboard", "Black"],
    productQuantities: [1, 2, 3, 4, 5],
  ),
  ModelProduct(
    productId: 3,
    productName: "GrandPro Tennis Sneaker",
    categoryName: "Sneakers",
    productPrice: 50,
    averageRatings: 4.0,
    noOfReview: 6,
    productDescription: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    productSizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Leather",
    productDesign: "Sports",
    productImage: "assets/images/grandpro_tennis_sneaker.png",
    productColors: ["White", "Tan", "Navy"],
    productQuantities: [1, 2, 3, 4, 5],
  ),
  ModelProduct(
    productId: 4,
    productName: "Women's Arizona Sandals",
    categoryName: "Sandals",
    productPrice: 66.35,
    averageRatings: 4.5,
    noOfReview: 6,
    productDescription: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    productSizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Rubber",
    productDesign: "Sandals",
    productImage: "assets/images/women_arizona_sandals.png",
    productColors: ["White", "Black", "Brown"],
    productQuantities: [1, 2, 3, 4, 5],
  ),
  ModelProduct(
    productId: 5,
    productName: "Air Max 90",
    categoryName: "Sneakers",
    productPrice: 44.30,
    averageRatings: 4.2,
    noOfReview: 6,
    productDescription: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    productSizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Leather",
    productDesign: "Sports",
    productImage: "assets/images/air_max_90.png",
    productColors: ["White", "Black", "Red"],
    productQuantities: [1, 2, 3, 4, 5],
  ),
  ModelProduct(
    productId: 6,
    productName: "Zoom Freak 4",
    categoryName: "Basketball",
    productPrice: 55.50,
    averageRatings: 4.2,
    noOfReview: 6,
    productDescription: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    productSizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Leather",
    productDesign: "Sports",
    productImage: "assets/images/zoom_freak_4.png",
    productColors: ["Multicolor", "Black"],
    productQuantities: [1, 2, 3, 4, 5],
  ),
  ModelProduct(
    productId: 7,
    productName: "Gel Kayano 29",
    categoryName: "Running",
    productPrice: 35,
    averageRatings: 4.2,
    noOfReview: 6,
    productDescription: "Its happened 1977. The Nike Blazer Mid '77 makes a legendary debut on the cort. A durable leather makes its perfect.",
    productSizes: [6, 7, 8, 9, 10],
    sellerId: 1,
    sellerName: "Shop Maxx",
    productCare: "Only apply dry cleaning",
    productCountry: "USA",
    productMaterial: "Durable Leather",
    productDesign: "Sports",
    productImage: "assets/images/gel_kayano_29.png",
    productColors: ["Blue", "Black", "Green"],
    productQuantities: [1, 2, 3, 4, 5],
  ),
];

final drawerListProvider = StateProvider.autoDispose<List<ModelDrawer>>((ref) {
  return [
    ModelDrawer(screen: MyProfileScreen(), title: language.myProfile, icon: Icons.person_outline),
    ModelDrawer(screen: WalletScreen(), title: language.wallet, icon: Icons.wallet_outlined),
    ModelDrawer(screen: MyAddressScreen(), title: language.myAddress, icon: Icons.location_city_outlined),
    ModelDrawer(screen: PreferencesScreen(), title: language.preferences, icon: Icons.settings_outlined),
    ModelDrawer(screen: HelpAndSupportScreen(), title: language.helpAndSupport, icon: Icons.help_outline),
    ModelDrawer(screen: Container(), drawerType: DrawerType.logout, title: language.logout, icon: Icons.logout_outlined),
  ];
});

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

final allProductProvider = AsyncNotifierProvider<DataNotifier, List<ModelProduct>>(DataNotifier.new);

final popularProductProvider = FutureProvider.autoDispose<List<ModelProduct>>((ref) {
  return [globalProductList[5], globalProductList[3], globalProductList[2], globalProductList[1]];
});

final openDrawerItemProvider = Provider.family<void, ({ModelDrawer drawerItem, BuildContext context})>((ref, args) {
  homeScaffoldKey.currentState?.closeDrawer();
  if (args.drawerItem.screen is! Container) {
    openScreen(args.context, args.drawerItem.screen);
  } else if (args.drawerItem.drawerType == DrawerType.logout) {
    showDialog(
      context: args.context,
      builder: (context) {
        return CommonDialog(
          title: language.sureToLogout,
          negativeText: language.cancel,
          positiveText: language.logout,
          onNegativeClick: () {
            Navigator.pop(context);
          },
          onPositiveClick: () {
            Navigator.pop(context);
            clearAllBoxes().then((value) {
              if (!context.mounted) return;
              return openScreenWithClearStack(context, SplashScreen());
            });
          },
        );
      },
    );
  }
});
