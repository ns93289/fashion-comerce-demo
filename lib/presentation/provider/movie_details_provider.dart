import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/movie_details_model.dart';
import '../repository/movie_repo.dart';

final movieRepoProvider = Provider<MovieRepository>((ref) => MovieRepository());

final moviwDetailsProvider = FutureProvider.family.autoDispose<MovieDetailsModel, int>((ref, movieId) async {
  final movieRepo = ref.watch(movieRepoProvider);
  final movieJson = await movieRepo.getMovieDetails(movieId);
  final data = MovieDetailsModel.fromJson(movieJson);
  return data;
});
