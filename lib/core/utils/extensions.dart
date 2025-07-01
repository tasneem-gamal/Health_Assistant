import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this, rootNavigator: true).push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<T?> pushReplacement<T, TO>(Widget page) {
    return Navigator.of(this, rootNavigator: true).pushReplacement<T, TO>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return Navigator.of(this, rootNavigator: true).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  void pop() {
    Navigator.of(this, rootNavigator: true).pop();
  }
}
