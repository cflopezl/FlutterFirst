// To parse this JSON data, do
//
//     final findMovieResponse = findMovieResponseFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas/models/models.dart';

class FindMovieResponse {
    FindMovieResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory FindMovieResponse.fromJson(String str) => FindMovieResponse.fromMap(json.decode(str));

    factory FindMovieResponse.fromMap(Map<String, dynamic> json) => FindMovieResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
}

