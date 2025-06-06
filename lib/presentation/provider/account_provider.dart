import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/authentication_service.dart';
import '../../core/utils/tools.dart';
import '../../data/models/model_drawer.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import '../../main.dart';
import '../dialogs/logout_dialog.dart';
import '../screens/address/my_address_screen.dart';
import '../screens/changePassword/change_password_screen.dart';
import '../screens/helpAndSupprt/help_and_support_screen.dart';
import '../screens/myProfile/my_profile_screen.dart';
import '../screens/orderHistory/order_history_screen.dart';
import '../screens/preferences/preferences_screen.dart';
import '../screens/wallet/wallet_screen.dart';

final drawerListProvider = StateProvider.autoDispose<List<ModelDrawer>>((ref) {
  return [
    ModelDrawer(screen: MyProfileScreen(), title: language.myProfile),
    ModelDrawer(screen: OrderHistoryScreen(), title: language.myOrders),
    ModelDrawer(screen: ChangePasswordScreen(), title: language.changePassword),
    ModelDrawer(screen: MyAddressScreen(), title: language.myAddress),
    ModelDrawer(screen: PreferencesScreen(), title: language.preferences),
    ModelDrawer(screen: WalletScreen(), title: language.wallet),
    ModelDrawer(screen: HelpAndSupportScreen(), title: language.helpAndSupport),
    ModelDrawer(screen: Container(), drawerType: DrawerType.deleteAccount, title: language.deleteMyAccount),
    ModelDrawer(screen: Container(), drawerType: DrawerType.logout, title: language.logout),
  ];
});

final openDrawerItemProvider = Provider.autoDispose.family<void, ({ModelDrawer drawerItem, BuildContext context})>((ref, args) {
  if (args.drawerItem.screen is! Container) {
    openScreen(args.context, args.drawerItem.screen);
  } else if (args.drawerItem.drawerType == DrawerType.logout) {
    ref.read(logoutProvider(args.context));
  }
});

final authRepoProvider = Provider.autoDispose<AuthRepo>((ref) {
  return AuthRepoImpl();
});
final authenticationServiceProvider = StateNotifierProvider<AuthenticationService, AsyncValue<UserEntity?>>((ref) {
  return AuthenticationService(ref.watch(authRepoProvider));
});
final logoutProvider = Provider.autoDispose.family<void, BuildContext>((ref, context) {
  showDialog(
    context: context,
    builder: (context) {
      return LogoutDialog();
    },
  );
});