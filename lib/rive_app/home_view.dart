import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/board_page/board_page_view.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/home_page_view.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/message/message_page_view.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/home_page_content/person_project_view_alt_3.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/setting_page_view.dart';
import 'package:rive_learning/rive_app/theme.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  int _currentViewIndex = 0;

  Widget? currentViewTesting;
  bool isClicked = false;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentView = HomePageView();

  void _onItemTapped(int index) {
    setState(() {
      _currentViewIndex = index;
      isClicked = false;
    });
  }

  void _testingViews() {
    setState(() {
      currentViewTesting = PersonProjectViewAlt3();
      isClicked = true;
    });
    print(isClicked);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _listOfViews = [
      HomePageView(
        settingViews: _testingViews,
      ),
      BoardPageView(),
      MessagePageView(),
      SettingPageView(),
    ];
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {},
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                  color: RiveAppTheme.shadow.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 7,
                  offset: Offset(0, 5)),
              BoxShadow(
                  color: RiveAppTheme.shadow.withOpacity(0.3),
                  blurRadius: 32,
                  spreadRadius: 16,
                  offset: Offset(7, 20))
            ],
          ),
          child: const Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
      body: isClicked
          ? currentViewTesting
          : _listOfViews.elementAt(_currentViewIndex),
      bottomNavigationBar: Container(
        height: 66,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 20,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Board',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            )
          ],
          currentIndex: _currentViewIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
