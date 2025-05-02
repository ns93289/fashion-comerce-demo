import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../bloc/bloc.dart';
import '../../../data/repository/api_repository.dart';
import '../../models/movie_list_model.dart';

class MovieListBloc extends Bloc {
  final BuildContext context;

  MovieListBloc(this.context) {
    pagingController.addPageRequestListener((pageKey) => callMovieListApi(pageKey));
    pagingController.notifyPageRequestListeners(1);
  }

  final MovieRepo _movieRepo = MovieRepo();

  final pagingController = PagingController<int, MovieItem>(firstPageKey: 1);

  callMovieListApi(int pageKey) async {
    try {
      final data = MovieListModel.fromJson(await _movieRepo.getMovieList(pageKey));

      if (data.movieList.isNotEmpty) {
        if (pageKey == data.totalPages) {
          pagingController.appendLastPage(data.movieList);
        } else {
          pagingController.appendPage(data.movieList, pageKey + 1);
        }
      }
    } catch (e) {
      pagingController.error = e.toString();
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
  }
}
