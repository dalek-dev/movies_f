// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:movies/src/movies/bloc/movie_details/movie_details_bloc.dart'
    as _i8;
import 'package:movies/src/movies/bloc/popular/movies_popular_bloc.dart' as _i9;
import 'package:movies/src/movies/bloc/search_movie/search_movie_bloc.dart'
    as _i5;
import 'package:movies/src/movies/bloc/top_rated/top_rated_bloc.dart' as _i6;
import 'package:movies/src/movies/bloc/upcomming/upcomming_bloc.dart' as _i7;
import 'package:movies/src/movies/repository/data_sources/movies_remote_data_sources.dart'
    as _i3;
import 'package:movies/src/movies/repository/repositories/movies_repository.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.MoviesRemoteDataSource>(
        () => _i3.MoviesRemoteDataSourceImpl());
    gh.factory<_i4.MoviesRepository>(() => _i4.MoviesRepositoryImpl(
        remoteDataSource: gh<_i3.MoviesRemoteDataSource>()));
    gh.factory<_i5.SearchMovieBloc>(
        () => _i5.SearchMovieBloc(repo: gh<_i4.MoviesRepository>()));
    gh.factory<_i6.TopRatedBloc>(
        () => _i6.TopRatedBloc(repo: gh<_i4.MoviesRepository>()));
    gh.factory<_i7.UpCommingBloc>(
        () => _i7.UpCommingBloc(repo: gh<_i4.MoviesRepository>()));
    gh.factory<_i8.MovieDetailsBloc>(
        () => _i8.MovieDetailsBloc(repo: gh<_i4.MoviesRepository>()));
    gh.factory<_i9.MoviesPopularBloc>(
        () => _i9.MoviesPopularBloc(repo: gh<_i4.MoviesRepository>()));
    return this;
  }
}
