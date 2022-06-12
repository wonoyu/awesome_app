import 'package:http/http.dart' as httpClient;
import 'package:awesome_app/src/utils/app_constants.dart';

class CuratedPhotosApi {
  static Uri curatedPhotosUri(int pages) => Uri(
        scheme: "https",
        host: AppConstants.baseUrl,
        path: AppConstants.curatedUrl,
        queryParameters: {
          "per_page": '$pages',
        },
      );

  static Map<String, String> headers() {
    return {
      'Authorization': 'Bearer ${AppConstants.apiKey}',
    };
  }
}

class CuratedPhotoClient {
  static Future<httpClient.Response> getCuratedPhotos(int pages) async {
    return await httpClient.get(
      CuratedPhotosApi.curatedPhotosUri(pages),
      headers: CuratedPhotosApi.headers(),
    );
  }
}
