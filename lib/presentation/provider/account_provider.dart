import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/dataSources/local/hive_constants.dart';
import '../../data/dataSources/local/hive_helper.dart';
import '../../application/authentication_service.dart';
import '../../data/models/model_drawer.dart';
import '../../data/repositories/auth_repo_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import '../../main.dart';
import '../dialogs/delete_account_dialog.dart';
import '../dialogs/logout_dialog.dart';
import '../screens/address/my_address_screen.dart';
import '../screens/changePassword/change_password_screen.dart';
import '../screens/helpAndSupprt/help_and_support_screen.dart';
import '../screens/myProfile/my_profile_screen.dart';
import '../screens/orderHistory/order_history_screen.dart';
import '../screens/preferences/preferences_screen.dart';
import '../screens/wallet/wallet_screen.dart';
import 'home_provider.dart';
import 'navigation_provider.dart';

final drawerListProvider = StateProvider.autoDispose<List<ModelDrawer>>((ref) {
  return [
    ModelDrawer(screen: MyProfileScreen(), title: language.myProfile),
    ModelDrawer(screen: OrderHistoryScreen(), title: language.myOrders),
    ModelDrawer(screen: ChangePasswordScreen(), title: language.changePassword),
    ModelDrawer(screen: MyAddressScreen(), title: language.myAddress),
    ModelDrawer(screen: PreferencesScreen(), title: language.preferences, loginRequired: false),
    ModelDrawer(screen: WalletScreen(), title: language.wallet),
    ModelDrawer(screen: HelpAndSupportScreen(), title: language.helpAndSupport, loginRequired: false),
    ModelDrawer(screen: Container(), drawerType: DrawerType.deleteAccount, title: language.deleteMyAccount),
    ModelDrawer(screen: Container(), drawerType: DrawerType.logout, title: language.logout),
  ];
});

final openDrawerItemProvider = Provider.autoDispose.family<void, ModelDrawer>((ref, drawerItem) {
  if (drawerItem.loginRequired && getIntDataFromUserBox(key: hiveUserId) == 0) {
    ref.read(loginRequiredDialogProvider);
    return;
  }
  if (drawerItem.screen is! Container) {
    ref.read(navigationServiceProvider).navigateTo(drawerItem.screen);
  } else if (drawerItem.drawerType == DrawerType.logout) {
    ref.read(navigationServiceProvider).showCustomDialog(LogoutDialog());
  } else if (drawerItem.drawerType == DrawerType.deleteAccount) {
    ref.read(navigationServiceProvider).showCustomDialog(DeleteAccountDialog());
  }
});

final authRepoProvider = Provider.autoDispose<AuthRepo>((ref) {
  return AuthRepoImpl();
});
final authenticationServiceProvider = StateNotifierProvider<AuthenticationService, AsyncValue<UserEntity?>>((ref) {
  return AuthenticationService(ref.watch(authRepoProvider));
});
