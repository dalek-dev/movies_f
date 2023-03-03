part of 'upcomming_bloc.dart';

@immutable
abstract class UpCommingEvent extends Equatable {
  const UpCommingEvent();

  @override
  List<Object> get props => [];
}

class FetchUpCommingMovies extends UpCommingEvent {}
