part of 'movies_popular_bloc.dart';

@immutable
abstract class MoviesPopularEvent extends Equatable {
  const MoviesPopularEvent();

  @override
  List<Object> get props => [];
}

class FetchPopularMovies extends MoviesPopularEvent {}
