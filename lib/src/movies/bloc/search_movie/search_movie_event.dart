part of 'search_movie_bloc.dart';

@immutable
abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class SearchMovie extends SearchMovieEvent {
  final String query;
  const SearchMovie(this.query);
}
