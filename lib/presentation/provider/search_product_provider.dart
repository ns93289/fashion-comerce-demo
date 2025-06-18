import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/home_service.dart';
import '../../data/repositories/home_repo_impl.dart';
import '../../domain/repositories/home_repo.dart';

final searchTECProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});

final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

final homeRepoProvider = Provider.autoDispose<HomeRepo>((ref) {
  return HomeRepoImpl();
});

final homeSearchServiceProvider = StateNotifierProvider.autoDispose<HomeService, AsyncValue<dynamic>>((ref) {
  return HomeService(ref.watch(homeRepoProvider));
});