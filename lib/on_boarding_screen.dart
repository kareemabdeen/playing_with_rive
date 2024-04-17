import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:playing_with_rive/animation_enum.dart';
import 'package:playing_with_rive/login_page_animation.dart';
import 'package:rive/rive.dart';

class OnboardingScreenWithRive extends StatefulWidget {
  const OnboardingScreenWithRive({
    super.key,
  });

  @override
  State<OnboardingScreenWithRive> createState() =>
      _OnboardingScreenWithRiveState();
}

class _OnboardingScreenWithRiveState extends State<OnboardingScreenWithRive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const RiveAnimation.asset(
            "assets/shapes.riv",
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  const SizedBox(
                    width: 260,
                    child: Column(
                      children: [
                        Text(
                          "Learn design & code",
                          style: TextStyle(
                            fontSize: 60,
                            fontFamily: "Poppins",
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools.",
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),

                  // TODO: Add the animated Button

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      "Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.",
                    ),
                  ),

                  Row(
                    children: [
                      const Spacer(),
                      MainButton(
                        height: 45,
                        width: 60,
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.screenHeight / 30,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.child,
    this.backgroundColor = Colors.black,
  });
  final void Function() onPressed;
  final double width;
  final double height;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FloatingActionButton.large(
        onPressed: onPressed,
        elevation: 0,
        backgroundColor: backgroundColor,
        child: child,
      ),
    );
  }
}
