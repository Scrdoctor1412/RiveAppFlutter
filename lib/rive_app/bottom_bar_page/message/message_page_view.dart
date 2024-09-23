import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/message/message_home.dart';


class MessagePageView extends StatefulWidget {
  const MessagePageView({super.key});

  @override
  State<MessagePageView> createState() {
    return _MessagePageViewState();
  }
}

class _MessagePageViewState extends State<MessagePageView>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu),
                      padding: const EdgeInsets.all(0),
                      style: IconButton.styleFrom(
                          backgroundColor: CupertinoColors.systemGrey5),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Messages',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      padding: const EdgeInsets.all(0),
                      style: IconButton.styleFrom(
                          backgroundColor: CupertinoColors.systemGrey5),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 43,
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: CupertinoColors.systemGrey,
                            ),
                            // hintText: 'Search ...',
                            filled: true,
                            fillColor: CupertinoColors.systemGrey5,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                              gapPadding: 0,
                              borderSide: BorderSide(
                                color: CupertinoColors.systemGrey5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        height: 117,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(32),
                                      child: Image.asset(
                                          'assets/avaters/avatar_1.jpg',
                                          width: 60)),
                                  Text(
                                    'User ${index+1}',
                                    style:
                                        const TextStyle(fontWeight: FontWeight.w500),
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 16),
                            itemCount: 10),
                      ),

                      // SegmentedButton(segments: [
                      //   ButtonSegment(value: 1),
                      //   ButtonSegment(value: 2),
                      // ], selected: {
                      //   1
                      // }),

                      MessageHome()
                      // Container(
                      //   height: 50,
                      //   child: TabBar(
                      //     controller: _tabController,
                      //     tabs: [
                      //       Text('lmao'),
                      //       Text('lmao'),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   height: 500-18,
                      //   child: TabBarView(
                      //       controller: _tabController,
                      //       children: [MessageHome(), SigninView()]),
                      // )
                      // ListView.separated(
                      //     physics: NeverScrollableScrollPhysics(),
                      //     shrinkWrap: true,
                      //     itemBuilder: (context, index) {
                      //       return Row(
                      //         children: [
                      //           Image.asset('assets/avaters/avatar_2.jpg')
                      //         ],
                      //       );
                      //     },
                      //     separatorBuilder: (context, index) => const SizedBox(),
                      //     itemCount: 100),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
