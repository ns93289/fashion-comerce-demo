import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/tools.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_text_field.dart';
import '../../../data/models/model_product.dart';
import '../../provider/search_product_provider.dart';
import '../productDetails/product_details_screen.dart';

class SearchProductScreen extends ConsumerStatefulWidget {
  const SearchProductScreen({super.key});

  @override
  ConsumerState<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends ConsumerState<SearchProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.searchProducts)), body: SafeArea(child: _buildSearchProduct()));
  }

  Widget _buildSearchProduct() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.w, end: 20.w),
          child: CustomTextField(
            decoration: InputDecoration(hintText: language.searchHint),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            onChanged: (value) {
              ref.read(searchQueryProvider.notifier).state = value ?? "";
            },
          ),
        ),
        Expanded(child: _searchedList()),
      ],
    );
  }

  Widget _searchedList() {
    final filteredItems = ref.watch(filteredItemsProvider);

    return ListView.separated(
      itemCount: filteredItems.length,
      shrinkWrap: true,
      padding: EdgeInsetsDirectional.only(top: 20.h),
      itemBuilder: (context, index) {
        ModelProduct modelProduct = filteredItems[index];
        return GestureDetector(
          onTap: () {
            openScreen(context, ProductDetailsScreen(productId: modelProduct.productId, productName: modelProduct.productName));
          },
          child: Container(
            color: colorWhite,
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w, vertical: 5.h),
            child: Row(
              children: [
                Expanded(child: _buildHighlightedText(modelProduct.productName, ref.watch(searchQueryProvider))),
                Icon(Icons.arrow_forward_ios, color: colorTextLight, size: 15.sp),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(padding: EdgeInsets.symmetric(vertical: 10.h), child: Divider(height: 0, thickness: 1.sp, color: colorDivider));
      },
    );
  }

  Widget _buildHighlightedText(String text, String query) {
    if (query.isEmpty) return Text(text);

    final matches = text.toLowerCase().indexOf(query.toLowerCase());
    if (matches == -1) return Text(text);

    final beforeMatch = text.substring(0, matches);
    final matchText = text.substring(matches, matches + query.length);
    final afterMatch = text.substring(matches + query.length);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: beforeMatch, style: bodyTextStyle()),
          TextSpan(text: matchText, style: bodyTextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: afterMatch, style: bodyTextStyle()),
        ],
      ),
    );
  }
}
