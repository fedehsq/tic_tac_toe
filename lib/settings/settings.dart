import 'package:flutter/foundation.dart';

class Settings {
  ValueNotifier<bool> godMode = ValueNotifier(false);
  ValueNotifier<int> godModeDepth = ValueNotifier(3); // Depth for god mode
  ValueNotifier<int> normalDepth = ValueNotifier(2); // Depth for normal mode

  void toggleGodMode() {
    godMode.value = !godMode.value;
  }

  int getDepth() {
    return godMode.value ? godModeDepth.value : normalDepth.value;
  }
}
