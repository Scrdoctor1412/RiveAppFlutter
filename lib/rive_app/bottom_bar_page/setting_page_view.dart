import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive_learning/rive_app/services/auth/auth_service.dart';

class SettingPageView extends StatefulWidget {
  const SettingPageView({super.key});

  @override
  State<SettingPageView> createState() {
    return _SettingPageViewState();
  }
}

class _SettingPageViewState extends State<SettingPageView> {

  void signOut(){
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: signOut, icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Text('setting'),
    );
  }
}
