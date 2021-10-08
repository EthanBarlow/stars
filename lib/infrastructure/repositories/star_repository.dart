import 'package:picture_of_the_day/infrastructure/models/Star.dart';
import 'package:picture_of_the_day/mocks/mock_star.dart';

abstract class StarRepository {
  Future<Star> fetchStar();
}

class RealStarRepository implements StarRepository {
  @override
  Future<Star> fetchStar() {
    // TODO: implement fetchStar
    throw UnimplementedError();
  }
}

class FakeStarRepository implements StarRepository {
  @override
  Future<Star> fetchStar() {
    return Future(() {
      return MockStar();
    });
  }
}
