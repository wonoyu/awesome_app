import 'package:awesome_app/src/features/home/data/home_repository.dart';
import 'package:awesome_app/src/features/home/domain/curated_photos.dart';
import 'package:awesome_app/src/utils/app_constants.dart';
import 'package:awesome_app/src/utils/temporary_data_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeCuratedPhotosRepository implements CuratedPhotosRepository {
  final _state = TemporaryStorage<CuratedPhotos?>(null);

  @override
  Stream<CuratedPhotos?> stateChanges() => _state.stream;
  @override
  CuratedPhotos? get currentState => _state.value;

  @override
  Future<void> getCuratedPhotos() async {
    await Future.delayed(const Duration(seconds: 1));
    _state.value = CuratedPhotos(
      photos: [
        Photo(
          alt: 'test',
          src: Source(
            portrait: AppConstants.imageTest,
          ),
        )
      ],
    );
    print("${_state.value!.photos![0].alt} kepanggil dong");
  }

  @override
  Future<void> loadMoreCuratedPhotos(int pages) async {
    await Future.delayed(const Duration(seconds: 1));
    _state.value = CuratedPhotos(
      photos: [
        Photo(
          alt: 'test',
          src: Source(
            portrait: AppConstants.imageTest,
          ),
        )
      ],
    );
  }

  @override
  Future<void> setCuratedPhotos(CuratedPhotos curatedPhotos) async {
    _state.value = curatedPhotos;
  }

  @override
  void dispose() => _state.dispose();
}

final fakeCuratedPhotosRepositoryProvider =
    Provider<FakeCuratedPhotosRepository>((ref) {
  final curatedPhotosRepository = FakeCuratedPhotosRepository();
  ref.onDispose(() => curatedPhotosRepository.dispose());
  return curatedPhotosRepository;
});

final fakeCuratedPhotosStateChangesProvider =
    StreamProvider.autoDispose<CuratedPhotos?>((ref) {
  final curatedPhotosRepository =
      ref.watch(fakeCuratedPhotosRepositoryProvider);
  return curatedPhotosRepository.stateChanges();
});
