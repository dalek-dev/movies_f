import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/failures.dart';
import 'package:movies/src/movies/models/movie.dart';
import 'package:movies/src/movies/repository/repositories/movies_repository.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

@injectable
class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final MoviesRepository repo;

  TopRatedBloc({required this.repo}) : super(InitialTopRatedState()) {
    on<FetchTopRatedMovies>(((event, emit) async {
      emit(TopRatedLoading());
      final response = await repo.getTopRated();
      response.fold(
          (failure) => emit(
              TopRatedError(errorMessage: (failure as GeneralFailure).message)),
          (success) => emit(TopRatedSuccess(success)));
    }));
  }
}
