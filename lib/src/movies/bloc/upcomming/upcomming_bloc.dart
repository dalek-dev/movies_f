import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/failures.dart';
import 'package:movies/src/movies/models/movie.dart';
import 'package:movies/src/movies/repository/repositories/movies_repository.dart';

part 'upcomming_event.dart';
part 'upcomming_state.dart';

@injectable
class UpCommingBloc extends Bloc<UpCommingEvent, UpCommingState> {
  final MoviesRepository repo;

  UpCommingBloc({required this.repo}) : super(InitialUpCommingState()) {
    on<FetchUpCommingMovies>(((event, emit) async {
      emit(UpCommingLoading());
      final response = await repo.getUpComming();
      response.fold(
          (failure) => emit(UpCommingError(
              errorMessage: (failure as GeneralFailure).message)),
          (success) => emit(UpCommingSuccess(success)));
    }));
  }
}
