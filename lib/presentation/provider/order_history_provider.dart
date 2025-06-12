import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../core/constants/app_constants.dart';
import '../../application/order_history_service.dart';
import '../../data/repositories/order_history_repo_impl.dart';
import '../../domain/entities/order_history_entity.dart';

final orderHistoryRepoProvider = Provider.autoDispose((ref) {
  return OrderHistoryRepoImpl();
});
final orderHistoryServiceProvider = StateNotifierProvider<OrderHistoryService, AsyncValue<List<OrderHistoryEntity>?>>((ref) {
  return OrderHistoryService(ref.watch(orderHistoryRepoProvider));
});

final orderHistoryPagingStateProvider = Provider.autoDispose<PagingController<int, OrderHistoryEntity>>((ref) {
  return PagingController<int, OrderHistoryEntity>(
    getNextPageKey: (state) {
      if (state.keys?.length == DefaultData.pageSize) {
        return (state.keys?.last ?? 0) + 1;
      } else if (state.keys?.length == null) {
        return 1;
      } else {
        return null;
      }
    },
    fetchPage: (pageKey) async {
      return await ref.read(orderHistoryServiceProvider.notifier).callOrderHistoryApi(page: pageKey) ?? [];
    },
  );
});
