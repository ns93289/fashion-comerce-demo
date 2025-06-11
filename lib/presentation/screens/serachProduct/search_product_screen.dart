import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/custom_icons.dart';
import '../../../core/constants/theme.dart';
import '../../../core/utils/tools.dart';
import '../../../data/dataSources/local/hive_helper.dart';
import '../../../data/models/search_model.dart';
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
    return Scaffold(appBar: CommonAppBar(title: _searchView()), body: SafeArea(child: _searchedList()));
  }

  Widget _searchView() {
    final searchTEC = ref.watch(searchTECProvider);
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(end: 10.w),
            child: CustomTextField(
              controller: searchTEC,
              decoration: InputDecoration(hintText: language.searchHint),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value ?? "";
              },
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            searchTEC.clear();
            ref.read(searchQueryProvider.notifier).state = "";
          },
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 10.w), child: Icon(CustomIcons.cancel)),
        ),
      ],
    );
  }

  Widget _searchedList() {
    final searchList = ref.watch(filteredItemsProvider);
    final query = ref.watch(searchQueryProvider);

    return query.isNotEmpty
        ? ListView.separated(
          itemCount: searchList.length,
          shrinkWrap: true,
          padding: EdgeInsetsDirectional.only(top: 10.h),
          itemBuilder: (context, index) {
            final ModelProduct(:productId, :productName, :selectedSize, :selectedColor) = searchList[index];
            return GestureDetector(
              onTap: () {
                putDataIntoRecentSearchBox(SearchModel(id: productId, searchString: productName));
                openScreen(context, ProductDetailsScreen(productId: productId, productName: productName, size: selectedSize, color: selectedColor));
              },
              child: Container(
                color: colorWhite,
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                child: Row(
                  children: [Expanded(child: _buildHighlightedText(productName, query)), Icon(Icons.arrow_forward_ios, color: colorTextLight, size: 15.sp)],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Padding(padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w), child: Divider(height: 0, thickness: 1.sp, color: colorDivider));
          },
        )
        : _recentSearchedList();
  }

  Widget _recentSearchedList() {
    return ValueListenableBuilder(
      valueListenable: recentSearchBox.listenable(),
      builder: (context, _, _) {
        final recentList = getRecentSearchFromRecentBox();

        return recentList.isNotEmpty
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 20.w, top: 10.h),
                  child: Text(language.recentSearches, style: bodyTextStyle(fontWeight: FontWeight.w500)),
                ),
                ListView.separated(
                  itemCount: recentList.length,
                  shrinkWrap: true,
                  padding: EdgeInsetsDirectional.only(top: 10.h),
                  itemBuilder: (context, index) {
                    SearchModel modelProduct = recentList[index];
                    return GestureDetector(
                      onTap: () {
                        openScreen(context, ProductDetailsScreen(productId: modelProduct.id, productName: modelProduct.searchString, size: "", color: ""));
                      },
                      child: Container(
                        color: colorWhite,
                        padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            Icon(Icons.history, color: colorTextLight, size: 20.sp),
                            SizedBox(width: 10.w),
                            Expanded(child: Text(modelProduct.searchString, maxLines: 1, style: bodyTextStyle())),
                            Icon(Icons.arrow_forward_ios, color: colorTextLight, size: 15.sp),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                      child: Divider(height: 0, thickness: 1.sp, color: colorDivider),
                    );
                  },
                ),
              ],
            )
            : Container();
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
