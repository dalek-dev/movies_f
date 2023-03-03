part of 'search_movie_bloc.dart';

@immutable
abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class InitialSearchMovieState extends SearchMovieState {}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieSuccess extends SearchMovieState {
  final List<Movie> response;

  const SearchMovieSuccess(this.response);
}

class SearchMovieError extends SearchMovieState {
  final String errorMessage;
  const SearchMovieError({required this.errorMessage});
}
