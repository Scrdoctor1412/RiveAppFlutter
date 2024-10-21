import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rive_learning/rive_app/home_view.dart';
import 'package:rive_learning/rive_app/on_boarding/onboarding_view.dart';
import 'package:rive_learning/rive_app/testing_get_firebase.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return const HomeView();
            // return const TestingGetFirebase();
          }else{
            return const OnboardingView();
          }
        },
      ),
    );
  }
}
