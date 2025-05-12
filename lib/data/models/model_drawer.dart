import 'package:flutter/material.dart';

class ModelDrawer {
  Widget screen;
  String title;
  IconData? icon;
  DrawerType? drawerType;

  ModelDrawer({required this.title, required this.screen, this.icon, this.drawerType = DrawerType.screen});
}

enum DrawerType { screen, logout }
