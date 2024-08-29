import 'package:dotted_border/dotted_border.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/home_page_content/task_card.dart';
import 'package:rive_learning/rive_app/models/task_info.dart';

class DragAndDrop extends StatefulWidget {
  const DragAndDrop({Key? key}) : super(key: key);

  @override
  State createState() => _DragAnDropState();
}

class InnerList {
  final String name;
  List<String> children;
  InnerList({required this.name, required this.children});
}

class _DragAnDropState extends State<DragAndDrop> {
  late List<InnerList> _lists;
  bool flag = false;

  @override
  void initState() {
    super.initState();

    _lists = List.generate(2, (outerIndex) {
      return InnerList(
        name: outerIndex.toString(),
        children: List.generate(outerIndex == 0 ? 2 : 6, (innerIndex) => '$outerIndex.$innerIndex'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: DragAndDropLists(
          children: List.generate(_lists.length, (index) => _buildList(index)),
          onItemReorder: _onItemReorder,
          onListReorder: _onListReorder,
          axis: Axis.horizontal,
          listWidth: 320,
          listDraggingWidth: 320,
          listPadding: const EdgeInsets.all(10.0),
          listDecoration: BoxDecoration(
            color: Color.fromARGB(20, 50, 173, 230),
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(24)
          ),
        ),
      ),
    );
  }

  _buildList(int outerIndex) {
    var innerList = _lists[outerIndex];
    return DragAndDropList(
      header: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  flag ? outerIndex == 0 ? 'COMPLETED' : 'IN WORK' : outerIndex == 0 ? 'IN WORK' : 'COMPLETED',
                  style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: CupertinoColors.systemGrey),
                      borderRadius: BorderRadius.circular(24)),
                  child: Text(
                    '${innerList.children.length}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: CupertinoColors.systemGrey),
                  ),
                ),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
              ],
            ),
            const Divider(
              color: Colors.blueAccent,
              thickness: 3,
            ),
          ],
        ),
      ),
      footer: Container(
        child: DottedBorder(
          borderPadding: const EdgeInsets.symmetric(horizontal: 20),
          strokeWidth: 2,
          borderType: BorderType.RRect,
          radius: Radius.circular(8),
          padding: const EdgeInsets.all(12),
          dashPattern: [5, 5],
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              Text(
                'Add card',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Inter'),
              ),
            ],
          ),
        ),
      ),
      children: List.generate(innerList.children.length,
          (index) => _buildItem(innerList.children[index], index)),
    );
  }

  _buildItem(String item, int index) {
    return DragAndDropItem(
        child: TaskCard(
      taskInfo: TaskInfo('taskPos $index', item, 'taskSub', 0.2, 'taskStatus'),
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
      flag = !flag;
      _lists.insert(newListIndex, movedList);
    });
  }
}
