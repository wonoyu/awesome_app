import 'package:awesome_app/src/features/authentication/data/dummy_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController({required this.authRepository})
      : super(const AsyncData(null));
  final DummyAuthRepository authRepository;

  Future<void> loginAnonymously() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.loginAnonymous);
  }

  Future<void> login(String username, String password) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() => authRepository.login(username, password));
  }
}

final loginScreenControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginController(authRepository: authRepository);
});
