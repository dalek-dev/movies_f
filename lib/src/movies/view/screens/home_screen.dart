import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/mixins/snack_mixin.dart';
import 'package:movies/core/utils/blend_mask.dart';
import 'package:movies/services/dependency_injector.dart';
import 'package:movies/src/movies/bloc/popular/movies_popular_bloc.dart';
import 'package:movies/src/movies/bloc/top_rated/top_rated_bloc.dart';
import 'package:movies/src/movies/bloc/upcomming/upcomming_bloc.dart';
import 'package:movies/src/movies/view/screens/details_screen.dart';
import 'package:movies/src/movies/view/screens/search_screen.dart';
import 'package:movies/src/movies/view/widgets/card_widget.dart';
import 'package:movies/src/movies/view/widgets/popcorn_loader.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SnacksMixin {
  late MoviesPopularBloc _moviesBloc;
  late TopRatedBloc _topRatedBloc;
  late UpCommingBloc _upCommingBloc;

  int _focusedIndex = 0;

  @override
  void initState() {
    super.initState();
    _moviesBloc = getIt<MoviesPopularBloc>();
    _topRatedBloc = getIt<TopRatedBloc>();
    _upCommingBloc = getIt<UpCommingBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moviesBloc.add(FetchPopularMovies());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => _moviesBloc,
          ),
          BlocProvider(
            create: (_) => _topRatedBloc,
          ),
          BlocProvider(
            create: (_) => _upCommingBloc,
          ),
        ],
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  BlocConsumer<MoviesPopularBloc, MoviesPopularState>(
                    bloc: _moviesBloc,
                    listener: (context, state) {
                      if (state is MoviesError) {
                        showErrorSnack(
                            context: context, message: state.errorMessage);
                      }
                      if (state is MoviesSuccess) {
                        _topRatedBloc.add(FetchTopRatedMovies());
                      }
                    },
                    builder: ((context, state) {
                      if (state is MoviesLoading) {
                        return Center(
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 80,
                              ),
                              CardPoster(
                                child: Center(
                                  child: PopcornLoader(
                                    size: 120,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      }

                      if (state is MoviesSuccess) {
                        return BlendMask(
                            opacity: 0.2,
                            blendMode: BlendMode.darken,
                            child: CardPoster(
                              width: double.infinity,
                              height: 400,
                              borderSize: 0,
                              decorationImage: DecorationImage(
                                  image: NetworkImage(
                                      'http://image.tmdb.org/t/p/w780/${state.response[_focusedIndex].posterPath ?? ''}'),
                                  fit: BoxFit.fitWidth),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  SizedBox(
                                    height: 280,
                                    child: ScrollSnapList(
                                        onItemFocus: (index) {
                                          setState(() {
                                            _focusedIndex = index;
                                          });
                                        },
                                        dynamicItemSize: true,
                                        shrinkWrap: true,
                                        itemSize: 200,
                                        itemCount: state.response.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 200),
                                                  pageBuilder: (_, __, ___) =>
                                                      DetailsScreen(
                                                          idMovie: state
                                                                  .response[
                                                                      index]
                                                                  .id ??
                                                              0),
                                                  transitionsBuilder: (_,
                                                          animation,
                                                          __,
                                                          child) =>
                                                      FadeTransition(
                                                    opacity: animation,
                                                    child: child,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: CardPoster(
                                              decorationImage: DecorationImage(
                                                  image: NetworkImage(
                                                      'http://image.tmdb.org/t/p/w780/${state.response[index].posterPath ?? ''}'),
                                                  fit: BoxFit.cover),
                                            ),
                                          );
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ),
                            ));
                      }
                      return Center(
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 80,
                            ),
                            CardPoster(
                              child: Center(
                                child: PopcornLoader(
                                  size: 120,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        child: Text(
                          'Top Rated',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      )),
                  BlocConsumer<TopRatedBloc, TopRatedState>(
                    bloc: _topRatedBloc,
                    listener: (context, state) {
                      if (state is TopRatedError) {
                        showErrorSnack(
                            context: context, message: state.errorMessage);
                      }
                      if (state is TopRatedSuccess) {
                        _upCommingBloc.add(FetchUpCommingMovies());
                      }
                    },
                    builder: ((context, state) {
                      if (state is TopRatedLoading) {
                        return const Center(
                          child: CardPoster(
                            child: Center(
                              child: PopcornLoader(
                                size: 80,
                              ),
                            ),
                          ),
                        );
                      }

                      if (state is TopRatedSuccess) {
                        return SizedBox(
                          height: 170,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.response.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              const Duration(milliseconds: 200),
                                          pageBuilder: (_, __, ___) =>
                                              DetailsScreen(
                                                  idMovie: state
                                                          .response[index].id ??
                                                      0),
                                          transitionsBuilder:
                                              (_, animation, __, child) =>
                                                  FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          ),
                                        ),
                                      );
                                    },
                                    child: CardPoster(
                                      height: 150,
                                      width: 100,
                                      decorationImage: DecorationImage(
                                          image: NetworkImage(
                                              'http://image.tmdb.org/t/p/w780/${state.response[index].posterPath ?? ''}'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                      return const Center(
                        child: CardPoster(
                          child: Center(
                            child: PopcornLoader(
                              size: 80,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                        child: Text(
                          'Up Comming',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      )),
                  BlocConsumer<UpCommingBloc, UpCommingState>(
                    bloc: _upCommingBloc,
                    listener: (context, state) {
                      if (state is UpCommingError) {
                        showErrorSnack(
                            context: context, message: state.errorMessage);
                      }
                    },
                    builder: ((context, state) {
                      if (state is UpCommingLoading) {
                        return const Center(
                          child: CardPoster(
                            child: Center(
                              child: PopcornLoader(
                                size: 80,
                              ),
                            ),
                          ),
                        );
                      }

                      if (state is UpCommingSuccess) {
                        return SizedBox(
                          height: 170,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.response.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              const Duration(milliseconds: 200),
                                          pageBuilder: (_, __, ___) =>
                                              DetailsScreen(
                                                  idMovie: state
                                                          .response[index].id ??
                                                      0),
                                          transitionsBuilder:
                                              (_, animation, __, child) =>
                                                  FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          ),
                                        ),
                                      );
                                    },
                                    child: CardPoster(
                                      height: 150,
                                      width: 100,
                                      decorationImage: DecorationImage(
                                          image: NetworkImage(
                                              'http://image.tmdb.org/t/p/w780/${state.response[index].posterPath ?? ''}'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                      return const Center(
                        child: CardPoster(
                          child: Center(
                            child: PopcornLoader(
                              size: 80,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const Positioned(
              top: 40,
              right: 0,
              left: 0,
              child: Center(
                child: Text(
                  'Movies',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.shade100.withOpacity(0.3)),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (_, __, ___) => const SearchScreen(),
                          transitionsBuilder: (_, animation, __, child) =>
                              FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
