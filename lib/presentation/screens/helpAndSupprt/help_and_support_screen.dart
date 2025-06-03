import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/tools.dart';
import '../../provider/support_pages_provider.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import 'support_page_details.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.helpAndSupport)), body: SafeArea(child: _buildHelpAndSupport()));
  }

  Widget _buildHelpAndSupport() {
    return Consumer(
      builder: (context, ref, _) {
        final supportPages = ref.watch(supportPagesProvider);

        return ListView.separated(
          itemCount: supportPages.length,
          shrinkWrap: true,
          padding: EdgeInsetsDirectional.symmetric(vertical: 20.h),
          itemBuilder: (context, index) {
            final supportPage = supportPages[index];

            return GestureDetector(
              onTap: () {
                openScreen(context, SupportPageDetails(pageTitle: supportPage.pageTitle, pageUrl: supportPage.pageUrl));
              },
              child: Container(
                color: colorWhite,
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                child: Row(
                  children: [Expanded(child: Text(supportPage.pageTitle, style: bodyTextStyle())), Icon(Icons.arrow_forward_ios, color: colorTextLight)],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Padding(padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w), child: Divider(color: colorDivider));
          },
        );
      },
    );
  }
}
