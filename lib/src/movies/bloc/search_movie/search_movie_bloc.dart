import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/failures.dart';
import 'package:movies/src/movies/models/movie.dart';
import 'package:movies/src/movies/repository/repositories/movies_repository.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

@injectable
class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final MoviesRepository repo;
  SearchMovieBloc({required this.repo}) : super(InitialSearchMovieState()) {
    on<SearchMovie>(((event, emit) async {
      emit(SearchMovieLoading());
      final response = await repo.searchMovie(event.query);
      response.fold(
          (failure) => emit(SearchMovieError(
              errorMessage: (failure as GeneralFailure).message)),
          (success) => emit(SearchMovieSuccess(success)));
    }));
  }
}
