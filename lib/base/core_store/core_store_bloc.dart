import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class CoreStore extends ChangeNotifier {
  /// Screen Pagination index
  ValueNotifier<int> screenIndex = ValueNotifier<int>(0);

  ValueNotifier<String> lastSelectedUrl = ValueNotifier<String>("");

  // Method to navigate forward and backward
  void navigate({bool isBack = false}) {
    if (isBack) {
      // Navigate back (decrease the screen index)
      if (screenIndex.value > 0) {
        screenIndex.value--;
      }
    } else {
      // Navigate forward (increase the screen index)
      if (screenIndex.value < 1) { // Add your condition for maximum index
        screenIndex.value++;
      }
    }

    notifyListeners();
  }

  // Update the last selected URL
  void urlUpdate(String url) async {
    lastSelectedUrl.value = url;
    notifyListeners();
  }
}
