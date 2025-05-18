import 'package:flutter/material.dart';

extension Navigation on BuildContext {

  // Method to push a named route onto the stack
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  // Method to replace the current route with a new named route
  Future<T?> pushReplacementNamed<T, TO>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushReplacementNamed<T, TO>(routeName, arguments: arguments);
  }

  // Method to push a named route and remove all the routes until a condition is met
  Future<T?> pushNamedAndRemoveUntil<T>(String newRouteName, RoutePredicate predicate, {Object? arguments}) {
    return Navigator.of(this).pushNamedAndRemoveUntil<T>(newRouteName, predicate, arguments: arguments);
  }

  // Method to pop the current route off the stack
  void pop(){
    Navigator.of(this).pop();
  }
}