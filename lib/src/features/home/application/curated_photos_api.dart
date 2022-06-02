import 'package:http/http.dart' as http;
import 'package:awesome_app/src/utils/app_constants.dart';

class CuratedPhotosApi {
  static Uri curatedPhotosUri() => Uri(
        scheme: "https",
        host: AppConstants.baseUrl,
        path: AppConstants.curatedUrl,
        queryParameters: {
          "per_page": '80',
        },
      );

  static Map<String, String> headers() {
    return {
      'Authorization': 'Bearer ${AppConstants.apiKey}',
    };
  }
}

class CuratedPhotoClient {
  static Future<http.Response> getCuratedPhotos() async {
    return await http.get(
      CuratedPhotosApi.curatedPhotosUri(),
      headers: CuratedPhotosApi.headers(),
    );
  }
}
