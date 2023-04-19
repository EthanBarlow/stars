import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_of_the_day/constants.dart';
import 'package:picture_of_the_day/infrastructure/models/Star.dart';
import 'package:picture_of_the_day/infrastructure/repositories/star_repository.dart';
import 'package:picture_of_the_day/star_exception.dart';

abstract class StarState {
  const StarState();
}

class StarInitial extends StarState {
  const StarInitial();
}

class StarLoading extends StarState {
  const StarLoading();
}

class StarLoaded extends StarState {
  final Star star;
  const StarLoaded(this.star);
}

class StarError extends StarState {
  final String message;
  const StarError(this.message);
}

class StarNotifier extends ChangeNotifier {
  final StarRepository _starRepository;
  late StarState state;
  StarNotifier(this._starRepository) {
    state = StarInitial();
  }

  Future<void> getStarData(DateTime dateTime) async {
    try {
      print('start loading');
      state = const StarLoading();
      notifyListeners();
      final star = await _starRepository.fetchStar(dateTime);
      // throw StarException(code: StarExceptionCode.rateLimitReached);
      state = StarLoaded(star);
      notifyListeners();
      print('star loaded');
    } on StarException catch (ex) {
      print('star exception: $ex');
      if (ex.code == StarExceptionCode.rateLimitReached) {
        state = const StarError(rateLimitMessage);
      } else {
        state = const StarError('shooting star...');
      }
      notifyListeners();
    } on Exception catch (e) {
      print(e);
      state = const StarError('shooting star...');
      notifyListeners();
    }
  }
}


/* class StarNotifier extends StateNotifier<StarState> {
  final StarRepository _starRepository;
  StarNotifier(this._starRepository) : super(const StarInitial());

  Future<void> getStarData(DateTime dateTime) async {
    try {
      print('start loading');
      state = const StarLoading();
      final star = await _starRepository.fetchStar(dateTime);
      // throw StarException(code: StarExceptionCode.rateLimitReached);
      state = StarLoaded(star);
      print('star loaded');
    } on StarException catch (ex) {
      print('star exception: $ex');
      if (ex.code == StarExceptionCode.rateLimitReached) {
        state = const StarError(rateLimitMessage);
      } else {
        state = const StarError('shooting star...');
      }
    } on Exception catch (e) {
      print(e);
      state = const StarError('shooting star...');
    }
  }
}
 */