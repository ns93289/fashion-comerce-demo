import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/common_circle_progress_bar.dart';
import '../../../customWidgets/empty_record_view.dart';
import '../../../utils/tools.dart';
import '../../models/movie_details_model.dart';
import '../../provider/movie_details_provider.dart';
import 'movie_details_shimmer.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  final String movieName;

  const MovieDetailsScreen({super.key, required this.movieId, required this.movieName});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(widget.movieName)), body: _buildMovieDetails());
  }

  Widget _buildMovieDetails() {
    return Consumer(
      builder: (context, ref, child) {
        final movieDetails = ref.watch(moviwDetailsProvider(widget.movieId));

        return movieDetails.when(
          data: (movie) => _movieDetails(movie),
          loading: () => const MovieDetailsShimmer(),
          error: (e, _) => EmptyRecordView(message: e.toString()),
        );
      },
    );
  }

  Widget _movieDetails(MovieDetailsModel data) {
    final MovieDetailsModel(:posterPath, :title, :releaseDate, :backdropPath, :overview) = data;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(backdropPath),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(colorBlack.withAlpha(50), BlendMode.darken),
              ),
            ),
            height: 278.sp,
            child: CachedNetworkImage(
              imageUrl: posterPath,
              placeholder: (context, url) => CommonCircleProgressBar(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, top: 5.h), child: Text(title, style: bodyTextStyle(fontWeight: FontWeight.w500))),
          Padding(padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, bottom: 5.h), child: Text(releaseDate, style: bodyTextStyle(fontSize: 14.sp))),
          Padding(padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, bottom: 5.h), child: Text(overview, style: bodyTextStyle(fontSize: 14.sp))),
        ],
      ),
    );
  }
}
