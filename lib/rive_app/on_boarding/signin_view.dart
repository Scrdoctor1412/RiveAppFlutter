import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'package:rive_learning/rive_app/home_view.dart';
import 'package:rive_learning/rive_app/services/auth/auth_service.dart';
import 'package:rive_learning/rive_app/theme.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key, this.closeModal});

  final Function? closeModal;

  @override
  State<SigninView> createState() {
    return _SigninViewState();
  }
}

class _SigninViewState extends State<SigninView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late SMITrigger _errorAnim;
  late SMITrigger _successAnim;
  late SMITrigger _confettiAnim;

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onCheckRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    _successAnim = controller.findInput<bool>("Check") as SMITrigger;
    _errorAnim = controller.findInput<bool>("Error") as SMITrigger;
  }

  void _onConfettiInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    _confettiAnim =
        controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  void login() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    setState(() {
      _isLoading = true;
    });

    try{
      var a = await authService.signInWithEmailandPassword(_emailController.text, _passwordController.text);
      // print(a.)
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    bool isEmailValid = _emailController.text.trim().isNotEmpty;
    bool isPassValid = _passwordController.text.trim().isNotEmpty;
    bool isValid = isEmailValid && isPassValid;

    Future.delayed(const Duration(seconds: 1), () {
      isValid ? _successAnim.fire() : _errorAnim.fire();
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
      if(isValid){
        _confettiAnim.fire();
      }
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeView()));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.8),
                          Colors.white10,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    padding: const EdgeInsets.all(29),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: RiveAppTheme.shadow.withOpacity(0.3),
                          offset: const Offset(0, 3),
                          blurRadius: 5,
                        ),
                        BoxShadow(
                          color: RiveAppTheme.shadow.withOpacity(0.3),
                          offset: const Offset(0, 30),
                          blurRadius: 30,
                        )
                      ],
                      color: CupertinoColors.secondarySystemBackground,
                      backgroundBlendMode: BlendMode.luminosity,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 34,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 34),
                        const Text(
                          // 'Access to 240+ hours of content. Learn design and code by building real apps with Flutter and Swift.',
                          'Access to your working progress and continue to work effectively by tracking this app',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Email',
                            style: TextStyle(
                              color: CupertinoColors.secondaryLabel,
                              fontFamily: 'Inter',
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: authInputStyle('email'),
                          controller: _emailController,
                        ),
                        const SizedBox(height: 24),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Password',
                            style: TextStyle(
                              color: CupertinoColors.secondaryLabel,
                              fontFamily: 'Inter',
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          obscureText: true,
                          decoration: authInputStyle('password'),
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: const Color(0xFFF77D8E).withOpacity(0.5),
                                blurRadius: 20,
                                offset: const Offset(0, 10)),
                          ]),
                          child: CupertinoButton(
                            color: const Color(0xFFF77D8E),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_forward_rounded),
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {
                              login();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.3),
                                      fontSize: 15,
                                      fontFamily: 'Inter'),
                                ),
                              ),
                              const Expanded(child: Divider())
                            ],
                          ),
                        ),
                        const Text(
                          'Sign up with Email, Apple or Google',
                          style: TextStyle(
                              color: CupertinoColors.secondaryLabel,
                              fontFamily: 'Inter',
                              fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset('assets/icons/email_box.svg'),
                            SvgPicture.asset('assets/icons/apple_box.svg'),
                            SvgPicture.asset('assets/icons/google_box.svg'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: true,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_isLoading)
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: RiveAnimation.asset(
                              'assets/RiveAssets/check.riv',
                              onInit: _onCheckRiveInit,
                            ),
                          ),
                        Positioned.fill(
                          child: SizedBox(
                            width: 500,
                            height: 500,
                            child: Transform.scale(
                              scale: 3,
                              child: RiveAnimation.asset(
                                'assets/RiveAssets/confetti.riv',
                                onInit: _onConfettiInit,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        borderRadius: BorderRadius.circular(36 / 2),
                        minSize: 36,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(36 / 2),
                              boxShadow: [
                                BoxShadow(
                                    color: RiveAppTheme.shadow.withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: const Offset(0, 3))
                              ]),
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          widget.closeModal!();
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration authInputStyle(String iconName) {
  return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.1),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.1),
        ),
      ),
      contentPadding: const EdgeInsets.all(15),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: SvgPicture.asset('assets/icons/$iconName.svg'),
      ));
}
