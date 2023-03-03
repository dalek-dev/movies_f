part of 'upcomming_bloc.dart';

@immutable
abstract class UpCommingState extends Equatable {
  const UpCommingState();

  @override
  List<Object> get props => [];
}

class InitialUpCommingState extends UpCommingState {}

class UpCommingLoading extends UpCommingState {}

class UpCommingSuccess extends UpCommingState {
  final List<Movie> response;

  const UpCommingSuccess(this.response);
}

class UpCommingError extends UpCommingState {
  final String errorMessage;
  const UpCommingError({required this.errorMessage});
}
