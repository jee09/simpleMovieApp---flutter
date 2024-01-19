import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_detail_model.dart';
import 'package:movieapp/services/api_service.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final String title, poster;
  final int id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.poster,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final String imgBaseUrl = 'https://image.tmdb.org/t/p/w500/';
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieDetailById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    print('movie: $movie');

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Back to list',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Image.network(
            '$imgBaseUrl${widget.poster}',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(1), // 아래쪽은 더 어둡게
                  Colors.black.withOpacity(0.4), // 중간은 약간 어둡게
                  Colors.transparent, // 위쪽은 투명하게
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FutureBuilder(
                  future: movie,
                  builder: (context, snapshot) {
                    String formattedRuntime = '';
                    if (snapshot.hasData) {
                      // runtime이 null이 아닐 때 계산
                      int totalMinutes = snapshot.data!.runtime;
                      int hours = totalMinutes ~/ 60;
                      int minutes = totalMinutes % 60;
                      formattedRuntime = "${hours}h ${minutes}min";
                    }
                    return snapshot.hasData
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                const SizedBox(
                                  height: 200,
                                ),
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 35,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                RatingStars(
                                  value: snapshot.data!.vote_average / 2,
                                  starCount: 5,
                                  valueLabelVisibility: false,
                                  starOffColor:
                                      const Color.fromARGB(116, 231, 232, 234),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  ' $formattedRuntime | ${snapshot.data!.genres.join(', ')}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                const Text(
                                  'Storyline',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 32,
                                  ),
                                ),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 270),
                                  child: Text(
                                    snapshot.data!.overview,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                ...[
                                  Center(
                                    child: GestureDetector(
                                      onTap: () async {
                                        try {
                                          String? urlStr =
                                              snapshot.data!.homepage;
                                          var url = Uri.tryParse(urlStr);
                                          if (url != null &&
                                              await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: const Text(
                                                  '열 수 있는 링크가 없어요',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                backgroundColor:
                                                    Colors.blueAccent,
                                                action: SnackBarAction(
                                                  label: '닫기',
                                                  textColor: Colors.white,
                                                  onPressed: () {},
                                                ),
                                                duration:
                                                    const Duration(seconds: 3),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin:
                                                    const EdgeInsets.all(10.0),
                                                elevation: 6.0,
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                '열 수 있는 링크가 없어요',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              backgroundColor:
                                                  Colors.blueAccent,
                                              action: SnackBarAction(
                                                label: '닫기',
                                                textColor: Colors.white,
                                                onPressed: () {},
                                              ),
                                              duration:
                                                  const Duration(seconds: 3),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              margin:
                                                  const EdgeInsets.all(10.0),
                                              elevation: 6.0,
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        width: 200,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffF8D848),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Buy Ticket',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ])
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
