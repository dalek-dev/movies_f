import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/failures.dart';
import 'package:movies/src/movies/models/movie.dart';
import 'package:movies/src/movies/repository/repositories/movies_repository.dart';

part 'movies_popular_event.dart';
part 'movies_popular_state.dart';

@injectable
class MoviesPopularBloc extends Bloc<MoviesPopularEvent, MoviesPopularState> {
  final MoviesRepository repo;

  MoviesPopularBloc({required this.repo}) : super(InitialMoviesState()) {
    on<FetchPopularMovies>(((event, emit) async {
      emit(MoviesLoading());
      final response = await repo.getPopular();
      response.fold(
          (failure) => emit(
              MoviesError(errorMessage: (failure as GeneralFailure).message)),
          (success) => emit(MoviesSuccess(success)));
    }));
  }
}
