import 'package:picture_of_the_day/Api.dart';
import 'package:picture_of_the_day/infrastructure/models/Star.dart';
import 'package:picture_of_the_day/mocks/mock_star.dart';

abstract class StarRepository {
  Future<Star> fetchStar(DateTime date);
}

class RealStarRepository implements StarRepository {
  @override
  Future<Star> fetchStar(DateTime date) {
    return ApiHelper.getStar(date);
  }
}

class FakeStarRepository implements StarRepository {
  @override
  Future<Star> fetchStar(DateTime date) {
    return Future(() {
      return MockStar();
    });
  }
}
