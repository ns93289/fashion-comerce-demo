import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/dataSources/remote/api_reponse.dart';
import '../../data/models/model_order_details.dart';

final orderDetailsFP = FutureProvider.autoDispose<ApiResult<ModelOrderDetails>>((ref) {
  ModelOrderDetails modelOrderDetails = ModelOrderDetails(
    orderId: 1,
    deliveryAddress: "101, ABC Complex, XYZ Place, ASD, 100001, Delhi, India",
    orderNo: "ASD123456",
    orderStatus: 2,
    orderTime: "Thursday 8 May 2025",
    packedTime: "Thursday 8 May 2025",
    deliveryTime: "Saturday 10 May 2025",
    totalAmount: 100,
    orderedProducts: [

    ],
  );

  return ApiSuccess(modelOrderDetails);
});
