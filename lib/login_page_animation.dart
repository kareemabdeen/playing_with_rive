import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playing_with_rive/animation_enum.dart';
import 'package:playing_with_rive/on_boarding_screen.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Artboard? riveArtboard;
  final rightEmail = 'kareem.elshreef18@gmail.com';
  final rightPassword = 'kareem12345';
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLookingRight = false;
  final FocusNode passwordFocusNode = FocusNode();
  bool isLookingLeft = false;

  late RiveAnimationController controllerIdle;
  late RiveAnimationController controllerHandsUp;
  late RiveAnimationController controllerHandsDown;
  late RiveAnimationController controllerLookLeft;
  late RiveAnimationController controllerLookRight;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerFail;

  void initAllRiveController() {
    controllerIdle = SimpleAnimation(PeerAnimationEnum.idle.name);
    controllerHandsUp = SimpleAnimation(PeerAnimationEnum.Hands_up.name);
    controllerHandsDown = SimpleAnimation(PeerAnimationEnum.hands_down.name);
    controllerLookRight =
        SimpleAnimation(PeerAnimationEnum.Look_down_right.name);
    controllerLookLeft = SimpleAnimation(PeerAnimationEnum.Look_down_left.name);
    controllerSuccess = SimpleAnimation(PeerAnimationEnum.success.name);
    controllerFail = SimpleAnimation(PeerAnimationEnum.fail.name);

    checkForPasswordFocusNodeToChangeAnimationState();
  }

  void checkForPasswordFocusNodeToChangeAnimationState() {
    passwordFocusNode.addListener(
      () {
        if (passwordFocusNode.hasFocus) {
          // addHandsUpController();
          addSpecifcAnimationAction(controllerHandsUp);
        } else if (!passwordFocusNode.hasFocus) {
          // addHandsDownController();
          addSpecifcAnimationAction(controllerHandsDown);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initAllRiveController();

    loadRiveFileWithItsStates();
  }

  void loadRiveFileWithItsStates() {
    rootBundle.load('assets/login_animation.riv').then(
      (data) {
        final riveFile = RiveFile.import(data);
        final Artboard artboard =
            riveFile.mainArtboard; // mskna el states of rive animation
        setState(() {
          riveArtboard = artboard;
        });
        riveArtboard!.addController(
          controllerIdle,
        ); // load the first look state
      },
    );
  }

  @override
  void dispose() {
    passwordFocusNode.removeListener;
    super.dispose();
  }

  void removeAllControllers() {
    riveArtboard?.artboard.removeController(controllerIdle);
    riveArtboard?.artboard.removeController(controllerHandsUp);
    riveArtboard?.artboard.removeController(controllerHandsDown);
    riveArtboard?.artboard.removeController(controllerLookLeft);
    riveArtboard?.artboard.removeController(controllerLookRight);
    riveArtboard?.artboard.removeController(controllerSuccess);
    riveArtboard?.artboard.removeController(controllerFail);
    isLookingLeft = false;
    isLookingRight = false;
    setState(() {});
  }

  Future<void> validateEmailAndPassword() async {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (formState.currentState!.validate()) {
          addSpecifcAnimationAction(controllerSuccess);
        } else {
          addSpecifcAnimationAction(controllerFail);
        }
      },
    );
  }

  void addSpecifcAnimationAction(
      RiveAnimationController<dynamic> riveController) {
    removeAllControllers();
    riveArtboard?.artboard.addController(riveController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(35),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        titleSpacing: 10,
        shadowColor: const Color.fromARGB(0, 198, 75, 75),
        title: Text(
          'R  I  V  E',
          style: TextStyle(
            color: Colors.black.withOpacity(.8),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.screenWidth / 20,
            vertical: context.screenHeight / 100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: context.screenHeight / 3,
                child: riveArtboard == null
                    ? const SizedBox.shrink()
                    : Rive(
                        artboard: riveArtboard!,
                      ),
              ),
              Form(
                key: formState,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.white60),
                      decoration: InputDecoration(
                        labelText: "Email",
                        fillColor: Colors.white,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      validator: (value) {
                        if (value != rightEmail) {
                          return 'Your email is not Right';
                        }
                        return null;
                      },
                      maxLength: 30,
                      onChanged: (value) {
                        if (value.isNotEmpty &&
                            value.length <= 16 &&
                            !isLookingLeft) {
                          addSpecifcAnimationAction(controllerLookLeft);
                        } else if (value.isNotEmpty && value.length > 16) {
                          addSpecifcAnimationAction(controllerLookRight);
                        } else {
                          return addSpecifcAnimationAction(controllerIdle);
                        }
                      },
                    ),
                    SizedBox(
                      height: context.screenHeight / 30,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white60),
                      obscureText: true,
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
                        labelText: "password",
                        fillColor: Colors.white,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      validator: (value) =>
                          value != rightPassword ? "Wrong password" : null,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth / 20,
                        vertical: context.screenHeight / 20,
                      ),
                      child: MainButton(
                        height: 45,
                        width: double.infinity,
                        backgroundColor: Colors.white,
                        onPressed: () {
                          passwordFocusNode.unfocus();
                          validateEmailAndPassword();
                        },
                        child: Text(
                          'submit',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.screenHeight / 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
