import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/services/api_service.dart';
import 'package:movieapp/widgets/movie_widget.dart';
import '../types/movie_list_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();
  final Future<List<MovieModel>> nowMovies = ApiService.getnowMovies();
  final Future<List<MovieModel>> commingMovies = ApiService.getComingMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: Container(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Popular Movies',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                  textAlign: TextAlign.start,
                ),
                FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 265,
                                child:
                                    makeList(snapshot, MovieListType.popular),
                              ),
                            ],
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
                const Text(
                  'Now in Cinemas',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                  textAlign: TextAlign.start,
                ),
                FutureBuilder(
                  future: nowMovies,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 260,
                                child: makeList(
                                    snapshot, MovieListType.nowPlaying),
                              ),
                            ],
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
                const Text(
                  'Coming soon',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                  textAlign: TextAlign.start,
                ),
                FutureBuilder(
                  future: commingMovies,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 260,
                                child: makeList(
                                    snapshot, MovieListType.comingSoon),
                              ),
                            ],
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView makeList(
      AsyncSnapshot<List<MovieModel>> snapshot, MovieListType type) {
    // print('snapshot ${snapshot.hasData}');
    // print('Building item ${snapshot.data}');
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      separatorBuilder: (context, index) => const SizedBox(
        width: 15,
      ),
      itemBuilder: (context, index) {
        var movie = snapshot.data?[index];
        return MovieWidget(
          title: movie!.title,
          poster: movie.poster_path,
          id: movie.id,
          type: type,
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
    );
  }
}
