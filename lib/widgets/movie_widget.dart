import 'package:flutter/material.dart';
import 'package:movieapp/screens/detail_screen.dart';
import '../types/movie_list_type.dart';

class MovieWidget extends StatelessWidget {
  final String poster, title;
  final int id;
  final MovieListType type;

  final String imgBaseUrl = 'https://image.tmdb.org/t/p/w500/';

  const MovieWidget({
    super.key,
    required this.title,
    required this.poster,
    required this.id,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              poster: poster,
              id: id,
            ),
            // fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: type == MovieListType.popular ? 300 : 160,
            height: type == MovieListType.popular ? 230 : 160,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(
              '$imgBaseUrl$poster',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
              constraints: const BoxConstraints(maxWidth: 150),
              child: type == MovieListType.popular
                  ? null
                  : Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )),
        ],
      ),
    );
  }
}
