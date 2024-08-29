import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/home_page_content/new_sub_task.dart';
import 'package:rive_learning/rive_app/theme.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  List<ImageProvider> _images = [
    ExactAssetImage('assets/avaters/avatar_1.jpg', scale: 0.2),
    ExactAssetImage('assets/avaters/avatar_2.jpg', scale: 1.2),
    ExactAssetImage('assets/avaters/avatar_3.jpg', scale: 1.2),
  ];

  List<String> _subtaskTitles = [
    'Create new style details page',
    'Add some illustrations',
    'Create high fidelity wireframe',
    'Create prototype'
  ];

  List<bool> _subTaskCheck = [false, false, false, false];

  void _toNewSubTask() async {
    final dynamic res = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            child: const FractionallySizedBox(
              heightFactor: 0.34,
              child: NewSubTask(),
            ),
          ),
        );
      },
      backgroundColor: Colors.white,
    );

    if (!context.mounted) return;

    // print('testing $res');
    setState(() {
      _subTaskCheck.add(false);
      _subtaskTitles.add(res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text(
          'Task details',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xff4e4879),
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Container(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'iOS Mobile App',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 24,
                                color: Color(0xff4e4879),
                              ),
                            ),
                            const Text(
                              'For Sunna Lab Agency',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  color: CupertinoColors.systemGrey),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Team',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          color: CupertinoColors.systemGrey),
                                    ),
                                    Row(children: [
                                      SizedBox(
                                        width: 90,
                                        child: FlutterImageStack.providers(
                                          providers: _images,
                                          totalCount: _images.length,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          boxShadow: [
                                            BoxShadow(
                                                color: RiveAppTheme.shadow
                                                    .withOpacity(0.1),
                                                blurRadius: 5,
                                                spreadRadius: 0.1,
                                                offset: Offset(0, 5))
                                          ],
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.add,
                                            color: CupertinoColors.systemBlue,
                                          ),
                                          style: IconButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            side: const BorderSide(
                                              color: CupertinoColors.systemGrey,
                                            ),
                                            // shadowColor:
                                          ),
                                        ),
                                      ),
                                    ])
                                  ],
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'My projects',
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          color: CupertinoColors.systemGrey),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '15 tasks',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        color: Color(0xff4e4879),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: 140,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Deadline'),
                                        ListTile(
                                          contentPadding: EdgeInsets.all(0),
                                          leading: Icon(
                                            Icons.timer,
                                            color: Color(0xff4e4879),
                                          ),
                                          title: Text(
                                            '2:00 PM - 4:00 PM',
                                            style: TextStyle(
                                                fontSize: 16.5,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xff4e4879)),
                                          ),
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.all(0),
                                          leading: Icon(
                                            Icons.calendar_month,
                                            color: Color(0xff4e4879),
                                          ),
                                          title: Text(
                                            'August 25, 2022',
                                            style: TextStyle(
                                                fontSize: 16.5,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xff4e4879)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            child:
                                                const CircularProgressIndicator(
                                              value: 0.75,
                                              color: Color(0xff5a5eea),
                                              backgroundColor:
                                                  CupertinoColors.systemGrey3,
                                              strokeCap: StrokeCap.round,
                                              strokeWidth: 9,
                                            ),
                                          ),
                                        ),
                                        const Center(
                                          child: Text(
                                            '75%',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  const Text(
                    'Descriptions',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      color: Color(0xff4e4879),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'iOS is a platform design reads a modern magazine with beautiful typography and simple layouts.',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xffa9a7b4)),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      const Text(
                        'Sub tasks',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24,
                          color: Color(0xff4e4879),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: _toNewSubTask,
                        child: const Text(
                          '+ Add task',
                          style: TextStyle(
                              color: CupertinoColors.activeBlue,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: IconButton(
                          onPressed: () {
                            setState(() {
                              _subTaskCheck[index] = !_subTaskCheck[index];
                            });
                          },
                          icon: _subTaskCheck[index]
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.blueAccent,
                                )
                              : Icon(Icons.circle_outlined),
                        ),
                        title: Text(
                          _subtaskTitles[index],
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w900,
                            color: _subTaskCheck[index] ? CupertinoColors.systemGrey : null,
                            decoration: _subTaskCheck[index] ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: _subtaskTitles.length,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
