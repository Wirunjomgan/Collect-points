import 'package:flutter/foundation.dart';

class UserPointModel extends ChangeNotifier {
  int _points = 2034;

  int get points => _points;

  void setPoints(int newPoints) {
    _points = newPoints;
    notifyListeners();
  }

  void deductPoints(int amount) {
    _points -= amount;
    notifyListeners();
  }

  void addPoints(int amount) {
    _points += amount;
    notifyListeners();
  }
}