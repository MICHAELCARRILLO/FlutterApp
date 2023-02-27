import 'package:flutter/foundation.dart';

class PDFStateProvider extends ChangeNotifier {
  bool _isCreated = false;
  int currentCounter = 0;
  bool get isCreated => _isCreated;
  int get counter => currentCounter;

  Future<void> setLoading(bool isCreated) async {
    _isCreated = isCreated;
    notifyListeners();
  }

  Future<void> setCounter(int counter) async {
    currentCounter = counter;
    notifyListeners();
  }
}
