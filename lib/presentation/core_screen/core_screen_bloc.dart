import 'dart:async';

class CoreScreenBloc {

  final StreamController<String> _animationStreamController = StreamController<String>.broadcast();
  Stream<String> get animationStream => _animationStreamController.stream;

  final StreamController<bool> _isCollapsedController = StreamController<bool>.broadcast();
  Stream<bool> get isCollapsed => _isCollapsedController.stream;

  void changeIsCollapsed(bool newValue) {
    _isCollapsedController.add(newValue);
  }

  void changeAnimation(String newAssetPath) {
    _animationStreamController.add(newAssetPath);
  }

  void dispose() {
    _animationStreamController.close();
    _isCollapsedController.close();
  }
}

