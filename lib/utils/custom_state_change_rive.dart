/*
import 'package:rive/rive.dart';

typedef OnInputChange = void Function(int id, dynamic value);

class CustomStateMachineController extends StateMachineController {
  CustomStateMachineController(
      StateMachine stateMachine, {  // Change here
        core.OnStateChange? onStateChange,
        required this.onInputChanged,
      }) : super( stateMachine, onStateChange: onStateChange, );

  final OnInputChange onInputChanged;

  @override
  void setInputValue(int id, value) {
    print('Changed id: $id,  value: $value');
    for (final input in stateMachine.inputs) {
      if (input.id == id) {
        // Do something with the input
        print('Found input: $input');
      }
    }
    // Or just pass it back to the calling widget
    onInputChanged.call(id, value);
    super.setInputValue(id, value);
  }

  static CustomStateMachineController? fromArtboard(
      Artboard artboard,
      String stateMachineName, {
        core.OnStateChange? onStateChange,
        required OnInputChange onInputChanged,
      }) {
    for (final animation in artboard.animations) {
      if (animation is StateMachine && animation.name == stateMachineName) {
        return CustomStateMachineController(
          animation,
          onStateChange: onStateChange,
          onInputChanged: onInputChanged,
        );
      }
    }
    return null;
  }
}*/
