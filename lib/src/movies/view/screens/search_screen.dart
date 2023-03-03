import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/mixins/snack_mixin.dart';
import 'package:movies/services/dependency_injector.dart';
import 'package:movies/src/movies/bloc/search_movie/search_movie_bloc.dart';
import 'package:movies/src/movies/view/screens/details_screen.dart';
import 'package:movies/src/movies/view/widgets/card_widget.dart';
import 'package:movies/src/movies/view/widgets/popcorn_loader.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SnacksMixin {
  late SearchMovieBloc _moviesBloc;
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _moviesBloc = getIt<SearchMovieBloc>();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocProvider(
      create: (_) => _moviesBloc,
      child: Stack(
        children: [
          Positioned(
            top: 40,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade100.withOpacity(0.1)),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
            ),
          ),
          Positioned(
            top: 40,
            right: 10,
            left: 50,
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.shade100.withOpacity(0.3),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                child: TextField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      Future.delayed(const Duration(seconds: 5), () {
                        _moviesBloc.add(SearchMovie(value));
                      });
                    }
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "Search movies ..."),
                  controller: _editingController,
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Expanded(
                    child: BlocConsumer<SearchMovieBloc, SearchMovieState>(
                        listener: (context, state) {
                      if (state is SearchMovieError) {
                        showErrorSnack(
                            context: context, message: state.errorMessage);
                      }
                      if (state is SearchMovieSuccess) {}
                    }, builder: (context, state) {
                      if (state is SearchMovieLoading) {
                        return const Center(
                          child: PopcornLoader(
                            size: 200,
                          ),
                        );
                      }
                      if (state is SearchMovieSuccess) {
                        return (state.response.isNotEmpty)
                            ? Scrollbar(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: state.response.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10, right: 10),
                                        child: GestureDetector(
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
                                                                .response[index]
                                                                .id ??
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
                                            height: 180,
                                            width: size.width,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                (state.response[index]
                                                            .backdropPath ==
                                                        null)
                                                    ? Container(
                                                        width: size.width / 2.5,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          16),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          16)),
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/images/popcorn_1.png'),
                                                              fit: BoxFit
                                                                  .fitWidth),
                                                        ),
                                                      )
                                                    : Container(
                                                        width: size.width / 2.5,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          16),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          16)),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  'http://image.tmdb.org/t/p/w780/${state.response[index].backdropPath}'),
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 20.0),
                                                        child: Container(
                                                          constraints:
                                                              BoxConstraints(
                                                            maxWidth:
                                                                size.width *
                                                                    0.40,
                                                          ),
                                                          child: Text(
                                                            state
                                                                    .response[
                                                                        index]
                                                                    .title ??
                                                                '',
                                                            style: const TextStyle(
                                                                fontSize: 24,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        10.0),
                                                            child: Text(
                                                              '${state.response[index].voteAverage?.toStringAsFixed(2) ?? 0.0}',
                                                              style: TextStyle(
                                                                  fontSize: 36,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400),
                                                            ),
                                                          ),
                                                          Container(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth:
                                                                  size.width *
                                                                      0.25,
                                                            ),
                                                            child: Text(
                                                                state
                                                                        .response[
                                                                            index]
                                                                        .overview ??
                                                                    '',
                                                                maxLines: 3,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .black)),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            : const Center(
                                child: PopcornLoader(
                                  size: 200,
                                ),
                              );
                      }
                      return const Center(
                        child: PopcornLoader(
                          size: 200,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 40,
            child: BackButton(
              color: Colors.black,
            ),
          ),
        ],
      ),
    ));
  }
}
