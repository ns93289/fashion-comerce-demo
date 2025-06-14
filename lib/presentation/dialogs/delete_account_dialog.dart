import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_entity.dart';
import '../../main.dart';
import '../provider/account_provider.dart';
import '../provider/navigation_provider.dart';
import '../screens/splash/splash_screen.dart';
import 'common_dialog.dart';

class DeleteAccountDialog extends ConsumerStatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  ConsumerState<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends ConsumerState<DeleteAccountDialog> {
  late final ProviderSubscription<AsyncValue<UserEntity?>> _listener;

  @override
  void initState() {
    super.initState();
    _listener = ref.listenManual(authenticationServiceProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (!mounted) return;
          ref.read(navigationServiceProvider).goBack();
          ref.read(navigationServiceProvider).navigateToWithClearStack(SplashScreen());
        },
      );
    });
  }

  @override
  void dispose() {
    _listener.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final apiResponse = ref.watch(authenticationServiceProvider);

    return CommonDialog(
      title: language.sureToDelete,
      negativeText: language.cancel,
      positiveText: language.delete,
      isLoading: apiResponse.isLoading,
      onNegativeClick: () {
        ref.read(navigationServiceProvider).goBack();
      },
      onPositiveClick: () {
        // ref.read(authenticationServiceProvider.notifier).callDeleteAccountApi();
      },
    );
  }
}
