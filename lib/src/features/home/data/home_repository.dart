import 'package:awesome_app/src/features/home/application/curated_photos_api.dart';
import 'package:awesome_app/src/features/home/domain/curated_photos.dart';
import 'package:awesome_app/src/utils/temporary_data_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CuratedPhotosRepository {
  final _state = TemporaryStorage<CuratedPhotos?>(null);

  Stream<CuratedPhotos?> stateChanges() => _state.stream;
  CuratedPhotos? get currentState => _state.value;

  Future<void> getCuratedPhotos() async {
    if (_state.value == null) {
      final response = await CuratedPhotoClient.getCuratedPhotos();
      final parser = CuratedPhotosParser();
      if (response.statusCode == 200) {
        final curatedPhotos = await parser.decodeIsolate(response.body);
        _state.value = curatedPhotos;
      }
    }
  }

  void setCuratedPhotos(CuratedPhotos curatedPhotos) {
    _state.value = curatedPhotos;
  }

  void dispose() => _state.dispose();
}

final curatedPhotosRepositoryProvider =
    Provider<CuratedPhotosRepository>((ref) {
  final curatedPhotosRepository = CuratedPhotosRepository();
  ref.onDispose(() => curatedPhotosRepository.dispose());
  return curatedPhotosRepository;
});

final curatedPhotosStateChangesProvider =
    StreamProvider.autoDispose<CuratedPhotos?>((ref) {
  final curatedPhotosRepository = ref.watch(curatedPhotosRepositoryProvider);
  return curatedPhotosRepository.stateChanges();
});
