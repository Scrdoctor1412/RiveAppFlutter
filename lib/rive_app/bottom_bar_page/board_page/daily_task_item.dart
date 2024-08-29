import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:intl/intl.dart';
import 'package:rive_learning/rive_app/models/daily_task.dart';

class DailyTaskItem extends StatefulWidget {
  const DailyTaskItem({Key? key, required this.taskItem}) : super(key: key);

  final DailyTask taskItem;

  @override
  _DailyTaskItemState createState() => _DailyTaskItemState();
}

class _DailyTaskItemState extends State<DailyTaskItem> {
  List<ImageProvider> _images = [
    ExactAssetImage('assets/avaters/avatar_1.jpg'),
    ExactAssetImage('assets/avaters/avatar_2.jpg'),
    ExactAssetImage('assets/avaters/avatar_3.jpg'),
  ];

  Color changeColor(String status) {
    switch (status.toLowerCase()) {
      case 'in process':
        return Color(0xffffb663);
      case 'reviewing':
        return Color(0xffff7460);
      default:
        return Color(0xff5b60ee);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.taskItem.endTime != DateTime(1)
        ? buildItemType1()
        : buildItemType2();
  }

  Widget buildItemType1() {
    var begin = DateFormat('h a').format(widget.taskItem.beginTime!);
    var begin2 = DateFormat('h:mm a').format(widget.taskItem.beginTime!);
    var end = DateFormat('h:mm a').format(widget.taskItem.endTime!);

    return Container(
      height: 120,
      width: double.infinity,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                begin2,
                style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter'),
              ),
              Text(
                end,
                style: const TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                    color: changeColor(widget.taskItem.taskStatus!),
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.taskItem.taskTitle!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.taskItem.taskStatus!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$begin - $end',
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        FlutterImageStack.providers(
                          providers: _images,
                          totalCount: _images.length,
                          itemBorderWidth: 1,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildItemType2() {
    // var begin = DateFormat('h a').format(widget.taskItem.beginTime!);
    var begin2 = DateFormat('h:mm a').format(widget.taskItem.beginTime!);

    return Container(
      // color: Colors.grey,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            begin2,
            style: const TextStyle(
                color: CupertinoColors.systemGrey,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Slider(value: 0, onChanged: (_) {}),
            ),
          )
        ],
      ),
    );
  }
}
