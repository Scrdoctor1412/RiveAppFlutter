import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/board_page/daily_task_item.dart';
import 'package:rive_learning/rive_app/models/daily_task.dart';
import 'package:rive_learning/rive_app/theme.dart';

class BoardPageView extends StatefulWidget {
  const BoardPageView({super.key});

  @override
  State<BoardPageView> createState() {
    return _BoardPageViewState();
  }
}

class _BoardPageViewState extends State<BoardPageView> {
  List<bool> _daySelected = [false, false, false, false, false, false];
  List<DailyTask> _dailyTasks = [
    DailyTask('Mobile App Development', 'Complete', DateTime.parse('2024-07-20 01:00:04Z'), DateTime.parse('2024-07-20 02:00:04Z')),
    DailyTask('Mobile App Development', 'Complete', DateTime.parse('2024-07-20 03:00:04Z'), DateTime(1)),
    DailyTask('Dashboard & Mobile App', 'In Process', DateTime.parse('2024-07-20 04:00:04Z'), DateTime.parse('2024-07-20 05:00:04Z')),
    DailyTask('iOS Mobile App', 'Reviewing', DateTime.parse('2024-07-20 06:00:04Z'), DateTime.parse('2024-07-20 07:00:04Z')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text(
          'Schedule',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xff4e4879),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.white,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      // border: Border.all(color: Colors.black),
                      boxShadow: [
                        BoxShadow(
                          color: RiveAppTheme.shadow.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 1,
                          offset: Offset(1, 20),
                          // blurStyle: BlurStyle.outer
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Monday, 2022 August 25',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 17,
                                        color: Color(0xff4e4879),
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_down)
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '5 tasks today',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: CupertinoColors.systemGrey,
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.calendar_today,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          // padding: const EdgeInsets.only(bottom: 24),
                          height: 85,
                          width: double.infinity,
                          child: ListView.separated(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _daySelected[index] = !_daySelected[index];
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 14,
                                    right: 14,
                                    top: 12,
                                  ),
                                  height: 85,
                                  decoration: BoxDecoration(
                                      // border: Border.all(),
                                      color: _daySelected[index]
                                          ? Colors.blueAccent
                                          : Color(0xfff6f6fe),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: _daySelected[index]
                                          ? [
                                              BoxShadow(
                                                  color: RiveAppTheme.shadow
                                                      .withOpacity(0.3),
                                                  blurRadius: 14,
                                                  // spreadRadius: 2,
                                                  offset: Offset(0, 9))
                                            ]
                                          : []),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '23',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          color: _daySelected[index]
                                              ? Colors.white
                                              : Color(0xff4e4879),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Sun',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: _daySelected[index]
                                              ? Colors.white
                                              : CupertinoColors.systemGrey,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      _daySelected[index]
                                          ? Icon(
                                              Icons.circle,
                                              size: 9,
                                              color: _daySelected[index]
                                                  ? Colors.white
                                                  : Colors.transparent
                                                      .withOpacity(0),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 24),
                            itemCount: _daySelected.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Daily Task',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      color: Color(0xff4e4879),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return DailyTaskItem(taskItem: _dailyTasks[index],);
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 24,
                    ),
                    itemCount: _dailyTasks.length,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
