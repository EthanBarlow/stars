import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:picture_of_the_day/infrastructure/models/Star.dart';
import 'package:picture_of_the_day/infrastructure/repositories/star_repository.dart';

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

class StarNotifier extends StateNotifier<StarState> {
  final StarRepository _starRepository;
  StarNotifier(this._starRepository) : super(StarInitial());

  Future<void> getStarData() async {
    try {
      state = StarLoading();
      final star = await _starRepository.fetchStar();
      state = StarLoaded(star);
    } on Exception {
      state = StarError('shooting star...');
    }
  }
  
}

