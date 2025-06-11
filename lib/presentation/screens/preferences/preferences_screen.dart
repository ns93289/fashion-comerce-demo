import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utils/tools.dart';
import '../../components/custom_button.dart';
import '../../../core/provider/locale_provider.dart';
import '../../../data/models/modle_preference.dart';
import '../../provider/preference_provider.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../home/home_screen.dart';
import 'item_language.dart';

class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({super.key});

  @override
  ConsumerState<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.preferences)), body: SafeArea(child: _buildPreferencesList()));
  }

  Widget _buildPreferencesList() {
    return Stack(children: [_preferencesList(), Align(alignment: Alignment.bottomCenter, child: _updateButton())]);
  }

  Widget _preferencesList() {
    final List<ModelLanguage> languages = ref.watch(languagesProvider);
    final selectedLanguage = ref.watch(selectedLanguageProvider);

    return ListView.separated(
      itemCount: languages.length,
      shrinkWrap: true,
      padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w, bottom: 80.h),
      itemBuilder: (context, index) {
        final ModelLanguage item = languages[index];
        return GestureDetector(
          onTap: () {
            ref.read(selectedLanguageProvider.notifier).state = item.locale;
          },
          child: ItemLanguage(modelLanguage: item, selected: item.locale == selectedLanguage),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(padding: EdgeInsets.symmetric(vertical: 10.h), child: Divider(height: 0, thickness: 1.h, color: colorDivider));
      },
    );
  }

  Widget _updateButton() {
    final selectedLanguage = ref.watch(selectedLanguageProvider);

    return CustomButton(
      title: language.update,
      margin: EdgeInsetsDirectional.only(start: 20.w, end: 20.w, bottom: 20.h),
      width: 1.sw,
      onPress: () {
        ref.read(localeProvider.notifier).state = selectedLanguage;
        openScreenWithClearStack(context, HomeScreen());
      },
    );
  }
}
