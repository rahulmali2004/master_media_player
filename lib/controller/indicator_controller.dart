import 'package:flutter/foundation.dart';

class indicator extends ChangeNotifier {
  int currentindex = 0;
  change_index({required int index}) {
    currentindex = index;
    notifyListeners();
  }
}
