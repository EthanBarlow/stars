import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_of_the_day/application/download_notifier.dart';
import 'package:picture_of_the_day/application/star_notifier.dart';
import 'package:picture_of_the_day/infrastructure/repositories/star_repository.dart';

final _starRepositoryProvider =
    Provider<StarRepository>((ref) => RealStarRepository());

final starNotifierProvider =
    StateNotifierProvider<StarNotifier, StarState>((ref) {
  return StarNotifier(ref.watch(_starRepositoryProvider));
});

final downloadNotifierProvider = StateNotifierProvider<UserDownloadStateNotifier, bool>((ref) {
  return UserDownloadStateNotifier(false);
});
