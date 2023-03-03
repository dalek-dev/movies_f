import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/errors/exceptions.dart';
import 'package:movies/core/errors/failures.dart';
import 'package:movies/src/movies/models/details.dart';
import 'package:movies/src/movies/models/movie.dart';
import 'package:movies/src/movies/repository/data_sources/movies_remote_data_sources.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>>> getUpComming();
  Future<Either<Failure, List<Movie>>> getPopular();
  Future<Either<Failure, List<Movie>>> getTopRated();
  Future<Either<Failure, MovieDetails>> getMovieDetails(String idMovie);
  Future<Either<Failure, List<Movie>>> searchMovie(String query);
}

@Injectable(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  MoviesRemoteDataSource remoteDataSource;
  MoviesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getUpComming() async {
    try {
      var response = await remoteDataSource.getUpComming();
      return Right(response);
    } on GeneralException catch (e) {
      return Left(GeneralFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopular() async {
    try {
      var response = await remoteDataSource.getPopular();
      return Right(response);
    } on GeneralException catch (e) {
      return Left(GeneralFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRated() async {
    try {
      var response = await remoteDataSource.getTopRated();
      return Right(response);
    } on GeneralException catch (e) {
      return Left(GeneralFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(String idMovie) async {
    try {
      var response = await remoteDataSource.getMovieDetails(idMovie);
      return Right(response);
    } on GeneralException catch (e) {
      return Left(GeneralFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovie(String query) async {
    try {
      var response = await remoteDataSource.searchMovie(query);
      return Right(response);
    } on GeneralException catch (e) {
      return Left(GeneralFailure(message: e.message));
    } catch (e) {
      return Left(GeneralFailure());
    }
  }
}
