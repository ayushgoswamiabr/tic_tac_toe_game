import 'package:flutter/material.dart';

class Gamebutton {
  final id;
  String text;
  Color bg;
  bool enabled;

  Gamebutton(
      {this.id, this.text = "", this.bg = Colors.grey, this.enabled = true});
}
