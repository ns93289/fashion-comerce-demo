import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/model_product.dart';
import 'home_provider.dart';

final searchTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final itemsProvider = Provider<List<ModelProduct>>((ref) {
  return globalProductList;
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredItemsProvider = Provider<List<ModelProduct>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final items = ref.watch(itemsProvider);

  if (query.isEmpty) return [];

  return items.where((item) => item.productName.toLowerCase().contains(query)).toList();
});
