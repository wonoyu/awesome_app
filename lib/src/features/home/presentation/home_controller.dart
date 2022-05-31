import 'package:awesome_app/src/features/authentication/data/dummy_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenController extends StateNotifier<AsyncValue<void>> {
  HomeScreenController({required this.authRepository})
      : super(const AsyncData(null));
  final DummyAuthRepository authRepository;

  Future<void> logout() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.logout);
  }
}

final homeScreenControllerProvider =
    StateNotifierProvider.autoDispose<HomeScreenController, AsyncValue<void>>(
        (ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return HomeScreenController(authRepository: authRepository);
});
