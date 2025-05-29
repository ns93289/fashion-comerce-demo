import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/tools.dart';
import '../../domain/entities/user_entity.dart';
import '../../main.dart';
import '../provider/home_provider.dart';
import '../screens/splash/splash_screen.dart';
import 'common_dialog.dart';

class LogoutDialog extends ConsumerStatefulWidget {
  const LogoutDialog({super.key});

  @override
  ConsumerState<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends ConsumerState<LogoutDialog> {
  late final ProviderSubscription<AsyncValue<UserEntity?>> _listener;

  @override
  void initState() {
    super.initState();
    _listener = ref.listenManual(authenticationServiceProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (!mounted) return;
          Navigator.of(context, rootNavigator: true).pop();
          openScreenWithClearStack(context, SplashScreen());
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
      title: language.sureToLogout,
      negativeText: language.cancel,
      positiveText: language.logout,
      isLoading: apiResponse.isLoading,
      onNegativeClick: () {
        Navigator.pop(context);
      },
      onPositiveClick: () {
        ref.read(authenticationServiceProvider.notifier).callLogoutApi();
      },
    );
  }
}
