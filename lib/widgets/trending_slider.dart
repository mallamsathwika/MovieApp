import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_project/screens/details_screen.dart';

import '../constants.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
          itemCount: snapshot.data!.length,
          options: CarouselOptions(
            height: 300,
            autoPlay: true,
            viewportFraction: 0.55,
            enlargeCenterPage: true,
            pageSnapping: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 1),
          ),
          itemBuilder: (context, itemIndex, pageViewIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      name: snapshot.data[itemIndex]['title'] ??
                          snapshot.data[itemIndex]['original_title'],
                      bannerurl: snapshot.data[itemIndex]['backdrop_path'] !=
                              null
                          ? 'https://image.tmdb.org/t/p/w500${snapshot.data[itemIndex]['backdrop_path']}'
                          : 'https://www.prokerala.com/movies/assets/img/no-poster-available.webp',
                      description: snapshot.data[itemIndex]['overview'],
                      vote: snapshot.data[itemIndex]['vote_average'].toDouble(),
                      launch: snapshot.data[itemIndex]['release_date'] ??
                          snapshot.data[itemIndex]['first_air_date'],
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 300,
                  width: 200,
                  child: Image.network(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    '${Constants.imagePath}${snapshot.data[itemIndex].posterPath}',
                  ),
                ),
              ),
            );
          }),
    );
  }
}
