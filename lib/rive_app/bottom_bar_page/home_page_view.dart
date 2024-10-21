import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/home_page_content/task_view.dart';
import 'package:rive_learning/rive_app/theme.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key, this.settingViews});

  final void Function()? settingViews;

  @override
  State<HomePageView> createState() {
    return _HomePageViewState();
  }
}

class _HomePageViewState extends State<HomePageView>
    with SingleTickerProviderStateMixin {
  List<ImageProvider> _images = [
    ExactAssetImage('assets/avaters/avatar_1.jpg', scale: 3),
    ExactAssetImage('assets/avaters/avatar_2.jpg', scale: 3),
    ExactAssetImage('assets/avaters/avatar_3.jpg', scale: 3),
  ];

  List<String> taskNames = [
    'Research for a hospital app',
    'Landing page design',
    'Web app design system',
    'Dasboard design fast'
  ];

  List<bool> taskCheck = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskCheck = List.filled(taskNames.length, false, growable: true);
    print(taskCheck);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hey, Ayzek',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins'),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '5 tasks for you today',
                            style: TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Inter',
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          'assets/avaters/avatar_5.jpg',
                          scale: 2.5,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  title: const Text(
                    'Your projects',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Inter',
                    ),
                  ),
                  trailing: InkWell(
                    onTap: widget.settingViews,
                    child: const Text(
                      'See all',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Inter',
                          color: Colors.blueAccent),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 24),
                  height: 233,
                  child: ListView.separated(
                    // padding: const ,
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 230,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: CupertinoColors.systemGrey3),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  //Back ground container
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16)),
                                      color: Color.fromARGB(255, 53, 109, 238),
                                    ),
                                    height: 180,
                                    width: 200,
                                  ),
                                  //Clipper container
                                  ClipPath(
                                    clipper: CustomClipPath(),
                                    child: Container(
                                      width: 200,
                                      height: 180,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16)),
                                        color: Color.fromARGB(255, 20, 76, 199),
                                      ),
                                    ),
                                  ),
                                  //Content Container
                                  Container(
                                    // height: 200,
                                    padding: const EdgeInsets.all(8),
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.search,
                                                color: Colors.white,
                                              ),
                                              style: IconButton.styleFrom(
                                                backgroundColor: Colors.white
                                                    .withOpacity(0.2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              padding: const EdgeInsets.all(0),
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.more_horiz,
                                                color: Colors.white,
                                              ),
                                              alignment: Alignment.topCenter,
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 25),
                                        const Text(
                                          'Research for mobile project',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          '42 tasks',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(height: 5),
                            Container(
                              // height: 25,
                              padding: const EdgeInsets.all(8),
                              width: 200,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Image.asset(
                                      'assets/avaters/avatar_5.jpg',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    '%85',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Inter'),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              width: 200,
                              // height: 5,
                              child: const LinearProgressIndicator(
                                value: 0.85,
                                color: Colors.green,
                                // valueColor: ,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 24,
                    ),
                    itemCount: 12,
                  ),
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Your tasks',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  itemBuilder: _buildTaskItem,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  itemCount: taskNames.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        // return ;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TaskView(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: RiveAppTheme.shadow.withOpacity(0.3),
              blurRadius: 6,
              spreadRadius: 1,
            )
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
          shadowColor: Colors.transparent,
          elevation: 0,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: CupertinoColors.systemGrey5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            // minLeadingWidth: 0,
            leading: IconButton(
              onPressed: () {
                setState(() {
                  taskCheck[index] = !taskCheck[index];
                });
              },
              icon: Icon(
                taskCheck[index] ? Icons.check_circle : Icons.circle_outlined,
                color: Colors.green,
                size: 32,
              ),
            ),
            title: Text(
              taskNames[index],
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Inter'),
            ),
            subtitle: const Text(
              'Today, 03:45 PM',
              style: TextStyle(
                color: CupertinoColors.systemGrey,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                fontSize: 13,
              ),
            ),
            trailing: SizedBox(
              width: 60,
              child: FlutterImageStack.providers(
                providers: _images,
                totalCount: 3,
                itemRadius: 60,
                itemBorderWidth: 3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0037500, size.height * -0.0040000);
    path_0.lineTo(size.width * -0.0058375, size.height * 0.6088400);
    path_0.quadraticBezierTo(size.width * 0.0855250, size.height * 0.5106600,
        size.width * 0.1897750, size.height * 0.4960000);
    path_0.cubicTo(
        size.width * 0.2852000,
        size.height * 0.5166200,
        size.width * 0.2806625,
        size.height * 0.8062600,
        size.width * 0.3737500,
        size.height * 0.8443800);
    path_0.cubicTo(
        size.width * 0.4374125,
        size.height * 0.8489400,
        size.width * 0.4620500,
        size.height * 0.8189800,
        size.width * 0.5262500,
        size.height * 0.7980000);
    path_0.cubicTo(
        size.width * 0.6669625,
        size.height * 0.7944600,
        size.width * 0.7280750,
        size.height * 0.7519400,
        size.width * 0.7447625,
        size.height * 0.7160000);
    path_0.cubicTo(
        size.width * 0.7575375,
        size.height * 0.5956400,
        size.width * 0.6492375,
        size.height * 0.5334800,
        size.width * 0.6625000,
        size.height * 0.4780000);
    path_0.cubicTo(
        size.width * 0.6693125,
        size.height * 0.3639600,
        size.width * 0.7727625,
        size.height * 0.3200000,
        size.width * 0.8029500,
        size.height * 0.1916800);
    path_0.cubicTo(
        size.width * 0.8134500,
        size.height * 0.1232600,
        size.width * 0.7970000,
        size.height * 0.0394400,
        size.width * 0.7692375,
        size.height * -0.0017200);
    path_0.quadraticBezierTo(size.width * 0.5759906, size.height * -0.0022900,
        size.width * -0.0037500, size.height * -0.0040000);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
