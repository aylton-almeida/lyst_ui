import 'package:flutter/material.dart';

class FabOptions {
  IconData icon = Icons.add;
  bool isVisible = true;
  VoidCallback onPress = () {};

  FabOptions({this.icon, this.isVisible, this.onPress});

  @override
  String toString() {
    return '$icon\n$isVisible\n$onPress';
  }
}
