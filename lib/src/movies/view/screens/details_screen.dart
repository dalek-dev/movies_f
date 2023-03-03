import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/mixins/snack_mixin.dart';
import 'package:movies/services/dependency_injector.dart';
import 'package:movies/src/movies/bloc/movie_details/movie_details_bloc.dart';
import 'package:movies/src/movies/models/details.dart';
import 'package:movies/src/movies/view/widgets/cine_widget.dart';

class DetailsScreen extends StatefulWidget {
  final int idMovie;
  const DetailsScreen({required this.idMovie, super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with SnacksMixin {
  late MovieDetailsBloc _detailsBloc;
  late MovieDetails movie;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _detailsBloc = getIt<MovieDetailsBloc>();
    movie = MovieDetails.none();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _detailsBloc.add(Details(widget.idMovie.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => _detailsBloc,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Column(
                children: [
                  BlocListener<MovieDetailsBloc, MovieDetailsState>(
                    listener: (context, state) {
                      if (state is MovieDetailsError) {
                        showErrorSnack(
                            context: context, message: state.errorMessage);
                      }
                      if (state is MovieDetailsLoading) {
                        print('is loading');
                      }
                      if (state is MovieDetailsSuccess) {
                        setState(() {
                          movie = state.response;
                        });
                      }
                    },
                    child: const SizedBox.shrink(),
                  ),
                  CineWidget(
                    backdropPath: movie.backdropPath,
                  ),
                ],
              ),
            ),
            const Positioned(
              top: 30,
              child: BackButton(
                color: Colors.white,
              ),
            ),
            Positioned(
              top: size.height / 2.5,
              left: size.width * 0.32,
              right: size.width * 0.32,
              child: (movie.backdropPath == null)
                  ? const SizedBox.shrink()
                  : Container(
                      height: size.height / 4,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        image: DecorationImage(
                            image: NetworkImage(
                                'http://image.tmdb.org/t/p/w780/${movie.posterPath}'),
                            fit: BoxFit.fill),
                      ),
                    ),
            ),
            Positioned(
              top: size.height / 1.55,
              left: 70,
              right: 70,
              child: (movie.overview == null)
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: size.width * 0.40,
                            ),
                            child: Text(
                              movie.title ?? '',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text(
                                '${movie.voteAverage?.toStringAsFixed(2) ?? 0.0}',
                                style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey.shade500),
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: size.width * 0.2,
                              ),
                              child: Text(
                                movie.originalTitle ?? '',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey.shade300),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: size.width * 0.7,
                          ),
                          child: Text(movie.overview ?? '',
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                        )
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
