import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/home_page_content/task_card.dart';
import 'package:rive_learning/rive_app/models/task_info.dart';
import 'package:rive_learning/drag_and_drop.dart';

class PersonProjectViewAlt3 extends StatefulWidget {
  const PersonProjectViewAlt3({Key? key}) : super(key: key);

  @override
  State createState() => _PersonProjectViewAlt3State();
}

class InnerList {
  final String name;
  List<String> children;
  InnerList({required this.name, required this.children});
}

class _PersonProjectViewAlt3State extends State<PersonProjectViewAlt3> {
  late List<InnerList> _lists;

  @override
  void initState() {
    super.initState();
    _lists = List.generate(2, (outerIndex) {
      return InnerList(
        name: outerIndex.toString(),
        children: List.generate(3, (innerIndex) => '$outerIndex.$innerIndex'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: [
                    const Text(
                      'Ayzek\'s project',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.person_add_alt_1_rounded,
                          color: CupertinoColors.systemGrey2,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_horiz,
                          color: CupertinoColors.systemGrey2,
                        ))
                  ],
                ),
              ),
              const Divider(
                height: 0,
              ),
              Expanded(child: DragAndDrop())
            ],
          ),
        ),
      ),
    );
  }

  _buildList(int outerIndex) {
    var innerList = _lists[outerIndex];
    return DragAndDropList(
      header: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(7.0)),
                color: Colors.pink,
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                'Header ${innerList.name}',
                style: Theme.of(context).primaryTextTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
      footer: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(7.0)),
                color: Colors.pink,
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                'Footer ${innerList.name}',
                style: Theme.of(context).primaryTextTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
      children: List.generate(innerList.children.length,
          (index) => _buildItem(innerList.children[index])),
    );
  }

  _buildItem(String item) {
    return DragAndDropItem(
        child: TaskCard(
      taskInfo: TaskInfo('taskPos', 'taskTitle', 'taskSub', 0.2, 'taskStatus'),
    ));
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _lists[oldListIndex].children.removeAt(oldItemIndex);
      _lists[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _lists.removeAt(oldListIndex);
      _lists.insert(newListIndex, movedList);
    });
  }
}
