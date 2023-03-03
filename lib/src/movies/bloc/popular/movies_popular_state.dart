part of 'movies_popular_bloc.dart';

@immutable
abstract class MoviesPopularState extends Equatable {
  const MoviesPopularState();

  @override
  List<Object> get props => [];
}

class InitialMoviesState extends MoviesPopularState {}

class MoviesLoading extends MoviesPopularState {}

class MoviesSuccess extends MoviesPopularState {
  final List<Movie> response;

  const MoviesSuccess(this.response);
}

class MoviesError extends MoviesPopularState {
  final String errorMessage;
  const MoviesError({required this.errorMessage});
}
