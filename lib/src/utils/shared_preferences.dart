import 'package:awesome_app/src/features/home/domain/curated_photos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferencesProvider>(
    (ref) => throw UnimplementedError("This Service is Error"));

class SharedPreferencesProvider {
  SharedPreferencesProvider(this.sharedPreferences);
  final SharedPreferences sharedPreferences;
  final parser = CuratedPhotosParser();

  static const likedImagesKey = 'likedImagesKey';

  Future<void> setLikedImages(List<Photo> likedImages) async {
    final String encodedData = Photo.encode(likedImages);
    await sharedPreferences.setString(likedImagesKey, encodedData);
  }

  List<Photo> getLikedImages() {
    final String? jsonData = sharedPreferences.getString(likedImagesKey);
    if (jsonData != null) {
      final List<Photo> decodedData = Photo.decode(jsonData);
      return decodedData;
    }
    return [];
  }

  static const curatedPhotosKey = 'curatedPhotosKey';

  Future<void> setCuratedPhotos(CuratedPhotos curatedPhotos) async {
    final String encodedData = await parser.encodeIsolate(curatedPhotos);
    await sharedPreferences.setString(curatedPhotosKey, encodedData);
  }

  Future<CuratedPhotos?> getCuratedPhotos() async {
    final String? jsonData = sharedPreferences.getString(curatedPhotosKey);
    if (jsonData != null) {
      final CuratedPhotos decodedData = await parser.decodeIsolate(jsonData);
      return decodedData;
    }
    return null;
  }
}
