import 'package:awesome_app/src/features/authentication/data/dummy_auth_repository.dart';
import 'package:awesome_app/src/features/home/data/liked_photos_repository.dart';
import 'package:awesome_app/src/features/home/domain/curated_photos.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

import '../lib/src/features/home/data/home_repository_test.dart';

class MockAuthRepository extends Mock implements DummyAuthRepository {}

class MockHomeRepository extends Mock implements FakeCuratedPhotosRepository {}

class MockLikedPhotosRepository extends Mock implements LikedPhotosRepository {}

class MockCuratedPhotos extends Mock implements CuratedPhotos {}

class MockPhotos extends Mock implements Photo {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
