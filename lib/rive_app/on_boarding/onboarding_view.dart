import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';
import 'package:rive_learning/rive_app/on_boarding/signin_view.dart';
import 'package:rive_learning/rive_app/theme.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OnboardingViewState();
  }
}

class _OnboardingViewState extends State<OnboardingView>
    with SingleTickerProviderStateMixin {
  AnimationController? _signInAnimController;

  late RiveAnimationController _btnController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signInAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      upperBound: 1,
    );
    _btnController = OneShotAnimation("active", autoplay: false);

    const springDesc = SpringDescription(
      mass: 0.1,
      stiffness: 40,
      damping: 5,
    );

    _btnController.isActiveChanged.addListener(() {
      if (!_btnController.isActive) {
        final springAnim = SpringSimulation(springDesc, 0, 1, 0);
        _signInAnimController?.animateWith(springAnim);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _signInAnimController?.dispose();
    _btnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Center(
              child: OverflowBox(
                maxWidth: double.infinity,
                child: Transform.translate(
                  offset: const Offset(200, 100),
                  child: Image.asset(
                    'assets/Backgrounds/Spline.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: const RiveAnimation.asset('assets/RiveAssets/shapes.riv'),
          ),
          AnimatedBuilder(
            animation: _signInAnimController!,
            builder: (context, child) {
              return Transform(
                transform: Matrix4.translationValues(0, -50 * _signInAnimController!.value, 0),
                child: child!,
              );
            },
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 80, 40, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 260,
                      padding: const EdgeInsets.only(bottom: 16),
                      child: const Text(
                        'Work effort    & more',
                        style: TextStyle(fontSize: 60, fontFamily: 'Poppins'),
                      ),
                    ),
                    const Text(
                      'Don\'t skip design. Learn design and code by building real apps with Flutter and Swift. Complete courses about the best tools.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        _btnController.isActive = true;
                      },
                      child: Container(
                        width: 236,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 10))
                          ],
                        ),
                        child: Stack(
                          children: [
                            RiveAnimation.asset(
                              'assets/RiveAssets/button.riv',
                              fit: BoxFit.cover,
                              controllers: [_btnController],
                            ),
                            Center(
                              child: Transform.translate(
                                offset: const Offset(4, 4),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_forward_rounded),
                                    Text(
                                      'Start working',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Purchases includes access to 30+ courses. 240+ premium tutorials, 120+ hours of videos, source files and certificates',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontFamily: 'Inter',
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _signInAnimController!,
              builder: (context, child) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: IgnorePointer(
                        ignoring: true,
                        child: Opacity(
                          opacity: 0.4 * _signInAnimController!.value,
                          child: Container(
                            color: RiveAppTheme.shadow,
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                        0,
                        -MediaQuery.of(context).size.height *
                            (1 - _signInAnimController!.value),
                      ),
                      child: SigninView(closeModal: () {
                        _signInAnimController?.reverse();
                      }),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
