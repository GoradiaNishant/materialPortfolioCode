import 'package:flutter/material.dart';

class CoreStore extends ChangeNotifier {
  /// Screen Pagination index
  ValueNotifier<int> screenIndex = ValueNotifier<int>(0);

  ValueNotifier<String> lastSelectedUrl = ValueNotifier<String>("");

  void navigate() {
    switch (screenIndex.value) {
      case 0:
        screenIndex.value++;

        break;
      case 1:
        screenIndex.value--;

        break;
    }

    notifyListeners();

    return;
  }

  void urlUpdate(String url) async {
    lastSelectedUrl.value = url;

    notifyListeners();
  }
}