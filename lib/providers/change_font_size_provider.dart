import 'package:flutter/cupertino.dart';

class ChangeFontSizeProvider extends ChangeNotifier {
  int fontSize = 20;
  void increaseFontSize() {
    if (fontSize < 32) {
      fontSize++;
    }
    notifyListeners();
  }

  void decreaseFontSize() {
    if (fontSize > 14) {
      fontSize--;
    }
    notifyListeners();
  }
}
