import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDownloadStateNotifier extends StateNotifier<bool> {
  UserDownloadStateNotifier([bool hasDownloaded = false])
      : super(hasDownloaded);

  void setHasDownloaded() {
    state = true;
  }

  void setHasNotDownloaded() {
    state = false;
  }

  bool get hasDownloaded => state;
}
