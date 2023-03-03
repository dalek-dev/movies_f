part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object> get props => [];
}

class Details extends MovieDetailsEvent {
  final String idMovie;

  const Details(this.idMovie);

  @override
  List<Object> get props => [idMovie];
}
