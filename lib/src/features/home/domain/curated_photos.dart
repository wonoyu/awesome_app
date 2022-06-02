import 'dart:convert';

import 'package:flutter/foundation.dart';

class CuratedPhotos {
  CuratedPhotos({
    this.photos,
    this.page,
    this.perPage,
    this.nextPage,
    this.prevPage,
  });

  List<Photo>? photos;
  int? page;
  int? perPage;
  String? nextPage;
  String? prevPage;

  factory CuratedPhotos.fromJson(Map<String, dynamic> json) => CuratedPhotos(
        page: json['page'],
        perPage: json["per_page"],
        nextPage: json["next_page"],
        prevPage: json["prev_page"],
        photos: List<Photo>.from(
            json["photos"].map((photo) => Photo.fromJson(photo))),
      );

  static Map<String, dynamic> toJson(CuratedPhotos curatedPhotos) => {
        "page": curatedPhotos.page,
        "per_page": curatedPhotos.perPage,
        "next_page": curatedPhotos.nextPage,
        "prev_page": curatedPhotos.prevPage,
        "photos": List<dynamic>.from(
            curatedPhotos.photos!.map((photo) => Photo.toJson(photo))),
      };

  static String encode(CuratedPhotos curatedPhotos) =>
      jsonEncode(curatedPhotos);

  static CuratedPhotos decode(String curatedPhotos) =>
      jsonDecode(curatedPhotos);
}

class Photo {
  Photo({
    this.id,
    this.alt,
    this.photographer,
    this.photographerUrl,
    this.width,
    this.height,
    this.liked,
    this.src,
  });

  int? id;
  String? alt;
  String? photographer;
  String? photographerUrl;
  int? width;
  int? height;
  bool? liked;
  Source? src;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        alt: json["alt"],
        photographer: json["photographer"],
        photographerUrl: json["photographer_url"],
        width: json["width"],
        height: json["height"],
        liked: json["liked"],
        src: Source.fromJson(json["src"]),
      );

  static Map<String, dynamic> toJson(Photo photo) => {
        'id': photo.id,
        'alt': photo.alt,
        'photographer': photo.photographer,
        'photographer_url': photo.photographerUrl,
        'width': photo.width,
        'height': photo.height,
        'liked': photo.liked,
        'src': photo.src?.toJson(),
      };

  static String encode(List<Photo> photo) => jsonEncode(
      photo.map<Map<String, dynamic>>((photo) => Photo.toJson(photo)).toList());

  static List<Photo> decode(String photos) =>
      (jsonDecode(photos) as List<dynamic>)
          .map<Photo>((photo) => Photo.fromJson(photo))
          .toList();
}

class Source {
  Source({
    this.original,
    this.large2x,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  });

  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        original: json["original"],
        large2x: json["large2x"],
        large: json["large"],
        medium: json["medium"],
        small: json["small"],
        portrait: json["portrait"],
        landscape: json["landscape"],
        tiny: json["tiny"],
      );

  Map<String, dynamic> toJson() => {
        'original': original,
        'large2x': large2x,
        'large': large,
        'medium': medium,
        'small': small,
        'portrait': portrait,
        'landscape': landscape,
        'tiny': tiny,
      };
}

class CuratedPhotosParser {
  CuratedPhotosParser();

  Future<CuratedPhotos> decodeIsolate(String encodedJson) {
    return compute(_decodeAndParseJson, encodedJson);
  }

  Future<String> encodeIsolate(CuratedPhotos curatedPhotos) {
    return compute(_encodeToJson, curatedPhotos);
  }

  CuratedPhotos _decodeAndParseJson(String encodedJson) {
    final decodedJson = jsonDecode(encodedJson);
    final curatedPhotos = CuratedPhotos.fromJson(decodedJson);
    return curatedPhotos;
  }

  String _encodeToJson(CuratedPhotos curatedPhotos) {
    final encodedJson = jsonEncode(CuratedPhotos.toJson(curatedPhotos));
    return encodedJson;
  }
}
