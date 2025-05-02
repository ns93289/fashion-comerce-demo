import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../constants/colors.dart';
import '../../../customWidgets/common_app_bar.dart';
import '../../../customWidgets/common_circle_progress_bar.dart';
import '../../../customWidgets/empty_record_view.dart';
import '../../../utils/tools.dart';
import '../movieDetails/movie_details_screen.dart';
import 'item_movie_list.dart';
import 'movie_list_bloc.dart';
import '../../models/movie_list_model.dart';
import 'movie_list_shimmer.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late MovieListBloc _bloc;

  @override
  void didChangeDependencies() {
    _bloc = MovieListBloc(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text("Movie List")), body: _movieList());
  }

  Widget _movieList() {
    return PagedGridView<int, MovieItem>(
      pagingController: _bloc.pagingController,
      padding: EdgeInsetsDirectional.symmetric(vertical: 10.h, horizontal: 10.w),
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) {
          return GestureDetector(
            onTap: () {
              openScreen(context, MovieDetailsScreen(movieId: item.id, movieName: item.title));
            },
            child: ItemMovieList(item: item),
          );
        },
        newPageProgressIndicatorBuilder: (context) {
          return CommonCircleProgressBar(color: colorBlack);
        },
        firstPageProgressIndicatorBuilder: (context) {
          return MovieListShimmer();
        },
        firstPageErrorIndicatorBuilder: (context) {
          return EmptyRecordView(message: _bloc.pagingController.error);
        },
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 185.sp / 333.sp, crossAxisSpacing: 10.w, mainAxisSpacing: 10.h),
    );
  }
}
