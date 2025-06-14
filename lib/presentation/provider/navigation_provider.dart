import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../navigation/navigation_service.dart';

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return navigationService;
});
