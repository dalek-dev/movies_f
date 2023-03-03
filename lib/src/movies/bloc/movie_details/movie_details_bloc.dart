import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/failures.dart';
import 'package:movies/src/movies/models/details.dart';
import 'package:movies/src/movies/repository/repositories/movies_repository.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

@injectable
class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MoviesRepository repo;

  MovieDetailsBloc({required this.repo}) : super(InitialDetailsState()) {
    on<Details>(((event, emit) async {
      emit(MovieDetailsLoading());
      final response = await repo.getMovieDetails(event.idMovie);
      response.fold(
          (failure) => emit(MovieDetailsError(
              errorMessage: (failure as GeneralFailure).message)),
          (success) => emit(MovieDetailsSuccess(success)));
    }));
  }
}
