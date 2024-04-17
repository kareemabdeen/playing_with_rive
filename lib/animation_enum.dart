// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum PeerAnimationEnum {
  idle,
  Hands_up,
  hands_down,
  success,
  fail,
  Look_down_right,
  Look_down_left,
  look_idle,
}

extension PlayingWithMediaQuery on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}
