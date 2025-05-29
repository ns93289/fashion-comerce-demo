import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/tools.dart';
import '../data/dataSources/remote/api_reponse.dart';
import '../domain/entities/address_entity.dart';
import '../domain/repositories/address_repo.dart';

class AddressService extends StateNotifier<AsyncValue<dynamic>> {
  final AddressRepo addressRepo;

  AddressService(this.addressRepo) : super(const AsyncValue.data(null));

  Future<void> callGetAddressApi() async {
    state = const AsyncValue.loading();
    try {
      final res = await addressRepo.getAddresses();
      if (res is ApiSuccess) {
        state = AsyncValue.data(res.data);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e) {
      logD("callGetAddressApi>>>", "error: ${e.toString()}");
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }

  Future<void> callAddAddressApi({required AddressEntity address}) async {
    state = const AsyncValue.loading();

    try {
      final res = await addressRepo.addAddress(address);
      if (res is ApiSuccess) {
        state = AsyncValue.data(res.data);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e) {
      logD("callAddAddressApi>>>", "error: ${e.toString()}");
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }

  Future<void> callEditAddressApi({required AddressEntity address}) async {
    state = const AsyncValue.loading();
    try {
      final res = await addressRepo.editAddress(address);
      if (res is ApiSuccess) {
        state = AsyncValue.data(res.data);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e) {
      logD("callEditAddressApi>>>", "error: ${e.toString()}");
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }

  Future<void> callDeleteAddressApi({required int addressId}) async {
    state = const AsyncValue.loading();
    try {
      final res = await addressRepo.deleteAddress(addressId: addressId);
      if (res is ApiSuccess) {
        state = AsyncValue.data(res.data);
      } else {
        state = AsyncValue.error((res as ApiError).errorData.message, StackTrace.empty);
      }
    } catch (e) {
      logD("callDeleteAddressApi>>>", "error: ${e.toString()}");
      state = AsyncValue.error(e, StackTrace.empty);
    }
  }
}
