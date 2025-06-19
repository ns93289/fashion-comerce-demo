import 'package:flutter/material.dart';

class ModelDrawer {
  Widget screen;
  String title;
  IconData? icon;
  DrawerType? drawerType;
  bool loginRequired;

  ModelDrawer({required this.title, required this.screen, this.icon, this.drawerType = DrawerType.screen, this.loginRequired = true});
}

enum DrawerType { screen, logout, deleteAccount }
