

import 'dart:async';

class AboutMeScreenBloc {

  final StreamController<String> _animationStreamController = StreamController<String>.broadcast();
  Stream<String> get animationStream => _animationStreamController.stream;


  void changeAnimation(String newAssetPath) {
    _animationStreamController.add(newAssetPath);
  }

  void dispose() {
    _animationStreamController.close();
  }
}

