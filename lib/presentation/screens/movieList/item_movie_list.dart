import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../customWidgets/common_circle_progress_bar.dart';
import '../../../utils/tools.dart';
import '../../models/movie_list_model.dart';

class ItemMovieList extends StatelessWidget {
  final MovieItem item;

  const ItemMovieList({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final MovieItem(:posterPath, :title, :releaseDate, :backdropPath) = item;
    return Container(
      decoration: BoxDecoration(
        color: colorWhite,
        boxShadow: [BoxShadow(color: colorBlack.withAlpha(50), blurRadius: 10, spreadRadius: 5)],
        borderRadius: BorderRadius.circular(5.r),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 185 / 278,
            child: CachedNetworkImage(
              imageUrl: posterPath,
              placeholder: (context, url) => CommonCircleProgressBar(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, top: 5.h),
            child: Text(title, style: bodyTextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          Padding(padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, bottom: 2.h), child: Text(releaseDate, style: bodyTextStyle(fontSize: 14.sp))),
        ],
      ),
    );
  }
}
