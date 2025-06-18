import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../components/common_circle_progress_bar.dart';
import '../../components/empty_record_view.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/custom_icons.dart';
import '../../../core/constants/theme.dart';
import '../../../data/dataSources/local/hive_helper.dart';
import '../../../domain/entities/search_entity.dart';
import '../../../main.dart';
import '../../components/common_app_bar.dart';
import '../../components/custom_text_field.dart';
import '../../provider/navigation_provider.dart';
import '../../provider/search_product_provider.dart';
import '../productDetails/product_details_screen.dart';

class SearchProductScreen extends ConsumerStatefulWidget {
  const SearchProductScreen({super.key});

  @override
  ConsumerState<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends ConsumerState<SearchProductScreen> {
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (query.trim().isNotEmpty) {
        ref.read(homeSearchServiceProvider.notifier).callSearchAll(query: query.trim());
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

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
                _onSearchChanged(value ?? "");
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
    final query = ref.watch(searchQueryProvider);
    final searchResult = ref.watch(homeSearchServiceProvider);

    return query.isNotEmpty
        ? searchResult.when(
          data: (data) {
            final List<SearchEntity> productList = (data as SearchResultEntity?)?.products ?? [];
            final List<SearchEntity> subCategoryList = data?.subCategories ?? [];
            final List<SearchEntity> brandList = data?.brands ?? [];

            return SingleChildScrollView(
              child: Column(
                children: [
                  if (productList.isNotEmpty)
                    Container(
                      width: 1.sw,
                      color: colorDivider,
                      margin: EdgeInsetsDirectional.only(top: 10.h),
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                      child: Text(language.inProducts, style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
                    ),
                  if (productList.isNotEmpty)
                    ListView.separated(
                      itemCount: productList.length,
                      shrinkWrap: true,
                      padding: EdgeInsetsDirectional.only(top: 10.h),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final SearchEntity(:id, :name, :isForKids, :isForMale, :isForFemale) = productList[index];
                        return GestureDetector(
                          onTap: () {
                            putDataIntoRecentSearchBox(name);
                            ref.read(navigationServiceProvider).navigateTo(ProductDetailsScreen(productId: id, productName: name));
                          },
                          child: Container(
                            color: colorWhite,
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Expanded(child: _buildHighlightedText(name, query)),
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
                  if (subCategoryList.isNotEmpty)
                    Container(
                      width: 1.sw,
                      color: colorDivider,
                      margin: EdgeInsetsDirectional.only(top: 10.h),
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                      child: Text(language.inSubCategories, style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
                    ),
                  if (subCategoryList.isNotEmpty)
                    ListView.separated(
                      itemCount: subCategoryList.length,
                      shrinkWrap: true,
                      padding: EdgeInsetsDirectional.only(top: 10.h),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final SearchEntity(:id, :name, :isForKids, :isForMale, :isForFemale) = subCategoryList[index];
                        return GestureDetector(
                          onTap: () {
                            putDataIntoRecentSearchBox(name);
                            ref.read(navigationServiceProvider).navigateTo(ProductDetailsScreen(productId: id, productName: name));
                          },
                          child: Container(
                            color: colorWhite,
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Expanded(child: _buildHighlightedText(name, query)),
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
                  if (brandList.isNotEmpty)
                    Container(
                      width: 1.sw,
                      color: colorDivider,
                      margin: EdgeInsetsDirectional.only(top: 10.h),
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                      child: Text(language.inBrands, style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
                    ),
                  if (brandList.isNotEmpty)
                    ListView.separated(
                      itemCount: brandList.length,
                      shrinkWrap: true,
                      padding: EdgeInsetsDirectional.only(top: 10.h),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final SearchEntity(:id, :name, :isForKids, :isForMale, :isForFemale) = brandList[index];
                        return GestureDetector(
                          onTap: () {
                            putDataIntoRecentSearchBox(name);
                            ref.read(navigationServiceProvider).navigateTo(ProductDetailsScreen(productId: id, productName: name));
                          },
                          child: Container(
                            color: colorWhite,
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Expanded(child: _buildHighlightedText(name, query)),
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
              ),
            );
          },
          error: (error, stackTrace) => EmptyRecordView(message: language.emptyProductsMsg),
          loading: () => Center(child: CommonCircleProgressBar()),
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
                    return GestureDetector(
                      onTap: () {
                        ref.read(searchQueryProvider.notifier).state = recentList[index];
                        _onSearchChanged(recentList[index]);
                        final searchTEC = ref.watch(searchTECProvider);
                        searchTEC.text=recentList[index];
                      },
                      child: Container(
                        color: colorWhite,
                        padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                        child: Row(
                          children: [
                            Icon(Icons.history, color: colorTextLight, size: 20.sp),
                            SizedBox(width: 10.w),
                            Expanded(child: Text(recentList[index], maxLines: 1, style: bodyTextStyle())),
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
