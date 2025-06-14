import 'package:fashion_comerce_demo/presentation/components/common_circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/constants/colors.dart';
import '../../../domain/entities/order_history_entity.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/empty_record_view.dart';
import '../../provider/navigation_provider.dart';
import '../../provider/order_history_provider.dart';
import '../orderDetails/order_details_screen.dart';
import 'item_order_history.dart';

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.myOrders)), body: SafeArea(child: _buildOrderHistory()));
  }

  Widget _buildOrderHistory() {
    return Consumer(
      builder: (context, ref, child) {
        final pagingController = ref.watch(orderHistoryPagingStateProvider);

        return PagingListener<int, OrderHistoryEntity>(
          controller: pagingController,
          builder: (context, state, fetchNextPage) {
            return PagedListView.separated(
              state: state,
              fetchNextPage: fetchNextPage,
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.only(top: 0.h, bottom: 20.h, start: 20.w, end: 20.w),
              builderDelegate: PagedChildBuilderDelegate<OrderHistoryEntity>(
                itemBuilder: (context, item, index) {
                  return ItemOrderHistory(
                    orderHistoryItem: item,
                    onReviewPress: () {
                      ref.read(navigationServiceProvider).navigateTo(OrderDetailsScreen(orderId: item.orderId));
                    },
                  );
                },
                firstPageErrorIndicatorBuilder: (context) {
                  return EmptyRecordView(message: state.error.toString());
                },
                newPageProgressIndicatorBuilder: (context) => CommonCircleProgressBar(),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return Padding(padding: EdgeInsets.symmetric(vertical: 15.h), child: Divider(thickness: 1.sp, color: colorDivider, height: 0));
              },
            );
          },
        );
      },
    );
  }
}
