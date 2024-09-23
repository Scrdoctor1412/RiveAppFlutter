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
  void signOut() {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signOut, icon: Icon(Icons.exit_to_app)),
        ],
        title: const Text(
          'Settings',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  Widget body() {
    List<String> settingTitles = ['Account', 'Display', 'Help and Support'];
    List<Icon> settingIcons = [
      Icon(Icons.person),
      Icon(Icons.tv),
      Icon(Icons.question_mark_rounded)
    ];
    return Container(
      //height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      height: 42,
                      child: Row(
                        children: [
                          settingIcons[index],
                          const SizedBox(width: 16),
                          Text(
                            settingTitles[index],
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 20,
                ),
                itemCount: settingTitles.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
