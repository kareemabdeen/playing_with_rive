// ignore_for_file: constant_identifier_names, deprecated_member_use

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:playing_with_rive/on_boarding_screen.dart';

void main() {
  runApp(
    DevicePreview(
      //enabled: !kReleaseMode,
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
        // const CustomPlugin(),
      ],
      builder: (context) => const PlayingWithRive(), // Wrap your app
    ),
  );
}

class PlayingWithRive extends StatelessWidget {
  const PlayingWithRive({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnboardingScreenWithRive(),
    );
  }
}
