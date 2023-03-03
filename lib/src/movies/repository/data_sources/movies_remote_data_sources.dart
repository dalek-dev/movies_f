import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:movies/core/errors/exceptions.dart';
import 'package:movies/env/env.dart';
import 'package:movies/src/movies/models/details.dart';
import 'package:movies/src/movies/models/movie.dart';

abstract class MoviesRemoteDataSource {
  Future<List<Movie>> getUpComming();
  Future<List<Movie>> getPopular();
  Future<List<Movie>> getTopRated();
  Future<MovieDetails> getMovieDetails(String idMovie);
  Future<List<Movie>> searchMovie(String query);
}

const errorMessage = 'Ocurrió un problema, por favor intenta nuevamente';

@Injectable(as: MoviesRemoteDataSource)
class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final http.Client httpClient = http.Client();

  @override
  Future<List<Movie>> getUpComming() async {
    final http.Response response = await httpClient.get(
      Uri.parse('${Env.apiBaseKy}/movie/upcoming?api_key=${Env.apiKy}'),
      headers: {
        'Authorization': 'Bearer ${Env.apiAuthKy}',
        'Content-Type': Env.ctType,
      },
    );

    try {
      var result = MoviesResponse.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return Future.value(result.results);
      } else {
        throw GeneralException(message: errorMessage);
      }
    } on GeneralException catch (e) {
      throw GeneralException(message: e.message);
    } catch (e) {
      throw GeneralException();
    }
  }

  @override
  Future<List<Movie>> getPopular() async {
    final http.Response response = await httpClient.get(
      Uri.parse('${Env.apiBaseKy}/movie/popular?api_key=${Env.apiKy}'),
      headers: {
        'Authorization': 'Bearer ${Env.apiAuthKy}',
        'Content-Type': Env.ctType,
      },
    );

    try {
      var result = MoviesResponse.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return Future.value(result.results);
      } else {
        throw GeneralException(message: errorMessage);
      }
    } on GeneralException catch (e) {
      throw GeneralException(message: e.message);
    } catch (e) {
      throw GeneralException();
    }
  }

  @override
  Future<List<Movie>> getTopRated() async {
    final http.Response response = await httpClient.get(
      Uri.parse('${Env.apiBaseKy}/movie/top_rated?api_key=${Env.apiKy}'),
      headers: {
        'Authorization': 'Bearer ${Env.apiAuthKy}',
        'Content-Type': Env.ctType,
      },
    );

    try {
      var result = MoviesResponse.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return Future.value(result.results);
      } else {
        throw GeneralException(message: errorMessage);
      }
    } on GeneralException catch (e) {
      throw GeneralException(message: e.message);
    } catch (e) {
      throw GeneralException();
    }
  }

  @override
  Future<MovieDetails> getMovieDetails(String idMovie) async {
    final http.Response response = await httpClient.get(
      Uri.parse('${Env.apiBaseKy}/movie/$idMovie?api_key=${Env.apiKy}'),
      headers: {
        'Authorization': 'Bearer ${Env.apiAuthKy}',
        'Content-Type': Env.ctType,
      },
    );

    try {
      var result = MovieDetails.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return Future.value(result);
      } else {
        throw GeneralException(message: errorMessage);
      }
    } on GeneralException catch (e) {
      throw GeneralException(message: e.message);
    } catch (e) {
      throw GeneralException();
    }
  }

  @override
  Future<List<Movie>> searchMovie(String query) async {
    final http.Response response = await httpClient.get(
      Uri.parse(
          '${Env.apiBaseKy}/search/movie?api_key=${Env.apiKy}&query=$query'),
      headers: {
        'Authorization': 'Bearer ${Env.apiAuthKy}',
        'Content-Type': Env.ctType,
      },
    );

    try {
      var result = MoviesResponse.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return Future.value(result.results);
      } else {
        throw GeneralException(message: errorMessage);
      }
    } on GeneralException catch (e) {
      throw GeneralException(message: e.message);
    } catch (e) {
      throw GeneralException();
    }
  }
}
