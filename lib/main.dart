// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:playing_with_rive/on_boarding_screen.dart';

void main() {
  runApp(const PlayingWithRive());
}

class PlayingWithRive extends StatelessWidget {
  const PlayingWithRive({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnboardingScreenWithRive(),
    );
  }
}
