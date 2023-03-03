part of 'top_rated_bloc.dart';

@immutable
abstract class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object> get props => [];
}

class InitialTopRatedState extends TopRatedState {}

class TopRatedLoading extends TopRatedState {}

class TopRatedSuccess extends TopRatedState {
  final List<Movie> response;

  const TopRatedSuccess(this.response);
}

class TopRatedError extends TopRatedState {
  final String errorMessage;
  const TopRatedError({required this.errorMessage});
}
