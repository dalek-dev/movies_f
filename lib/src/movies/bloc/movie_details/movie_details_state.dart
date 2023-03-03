part of 'movie_details_bloc.dart';

@immutable
abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

class InitialDetailsState extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetails response;

  const MovieDetailsSuccess(this.response);
}

class MovieDetailsError extends MovieDetailsState {
  final String errorMessage;
  const MovieDetailsError({required this.errorMessage});
}
