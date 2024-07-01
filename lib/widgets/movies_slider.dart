import 'package:flutter/material.dart';
import 'package:tmdb_project/screens/details_screen.dart';

import '../constants.dart';

class MoviesSlider extends StatelessWidget {
  const MoviesSlider({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      name: snapshot.data[index]['title'] ??
                          snapshot.data[index]['original_title'],
                      bannerurl: snapshot.data[index]['backdrop_path'] != null
                          ? 'https://image.tmdb.org/t/p/w500${snapshot.data[index]['backdrop_path']}'
                          : 'https://www.prokerala.com/movies/assets/img/no-poster-available.webp',
                      description: snapshot.data[index]['overview'],
                      vote: snapshot.data[index]['vote_average'].toDouble(),
                      launch: snapshot.data[index]['release_date'] ??
                          snapshot.data[index]['first_air_date'],
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 200,
                  width: 150,
                  child: Image.network(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      '${Constants.imagePath}${snapshot.data![index].posterPath}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
