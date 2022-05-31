import 'package:awesome_app/src/features/authentication/domain/app_user.dart';
import 'package:awesome_app/src/utils/temporary_data_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DummyAuthRepository {
  final _authState = TemporaryStorage<AppUser?>(null);

  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;

  Future<void> loginAnonymous() async {
    await Future.delayed(const Duration(seconds: 1));
    _authState.value = AppUser(
      userId: '1',
      name: 'Anonymous',
    );
  }

  Future<void> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _authState.value = AppUser(
      userId: '2',
      name: username,
    );
  }

  Future<void> logout() async {
    _authState.value = null;
  }

  void dispose() => _authState.dispose();
}

final authRepositoryProvider = Provider<DummyAuthRepository>((ref) {
  final auth = DummyAuthRepository();
  ref.onDispose(() => auth.dispose());
  return auth;
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
