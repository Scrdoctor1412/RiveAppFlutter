import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/home_page_content/task_card.dart';
import 'package:rive_learning/rive_app/models/project_info.dart';
import 'package:rive_learning/rive_app/new_project_view.dart';
import 'package:rive_learning/rive_app/services/project/project_service.dart';

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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ProjectService _projectService = ProjectService();
  List<Map<String, dynamic>> _projectList = [];
  List<Map<String, dynamic>> _inWorkList = [];
  List<Map<String, dynamic>> _completedList = [];

  @override
  void initState() {
    super.initState();

    _lists = List.generate(2 /*2 columns */, (outerIndex) {
      return InnerList(
        name: outerIndex.toString(),
        children: List.generate(
            outerIndex == 0 ? _inWorkList.length : _completedList.length,
            (innerIndex) => '$outerIndex.$innerIndex'),
      );
    });

    initProjects();
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
              borderRadius: BorderRadius.circular(24)),
        ),
      ),
    );
  }

  void initProjects() async {
    await _projectService.getAllProjects2().then((querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()['projectName']}');
        _projectList.add(docSnapshot.data());
        print('success');
      }

      for (var project in _projectList) {
        if (project['projectFinished']) {
          _completedList.add(project);
        } else {
          _inWorkList.add(project);
        }
      }

      //update drag and drop list
      setState(() {
        _lists = List.generate(2 /*2 columns */, (outerIndex) {
          return InnerList(
            name: outerIndex.toString(),
            children: List.generate(
                outerIndex == 0 ? _inWorkList.length : _completedList.length,
                (innerIndex) => '$outerIndex.$innerIndex'),
          );
        });
      });
    });
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
                  flag
                      ? outerIndex == 0
                          ? 'COMPLETED'
                          : 'IN WORK'
                      : outerIndex == 0
                          ? 'IN WORK'
                          : 'COMPLETED',
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: flag
              ? outerIndex == 0
                  ? null
                  : _buildAddProject()
              : outerIndex == 0
                  ? _buildAddProject()
                  : null),
      children: List.generate(innerList.children.length,
          (index) => _buildItem('Research for mobile project', index)),
    );
  }

  _buildItem(String item, int index) {
    final _projecGet = _projectList[index];
    final project = Project(projectPosition: _projecGet['projectPosition'], projectName: _projecGet['projectName'], projectDesc: _projecGet['projectDesc'], projectUrgent: _projecGet['projectUrgent'], projectFinished: _projecGet['projectFinished'], timeStamp: _projecGet['timeStamp']);
    return DragAndDropItem(
      // child: TaskCard(
      //   project: Project(
      //     projectPosition: 'Dev',
      //     projectName: 'Hello World',
      //     projectDesc: 'testing dart and flutter',
      //     projectUrgent: 'low',
      //     projectFinished: false,
      //     timeStamp: Timestamp.now(),
      //   ),
      // ),
      child: TaskCard(project: project)
    );
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

  Widget _buildAddProject() {
    return InkWell(
      onTap: () {
        _toNewProject();
      },
      child: DottedBorder(
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
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addProject(Project newProject) async {
    await _projectService.addProject(newProject);

    int lastIndex = _lists[0].children.length;
    setState(() {
      _lists[0].children.insert(lastIndex, "test");
    });
  }

  void _toNewProject() async {
    final dynamic res = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            child: const FractionallySizedBox(
              heightFactor: 0.6,
              child: NewProjectView(),
            ),
          ),
        );
      },
      backgroundColor: Colors.white,
    );

    if (!context.mounted) return;

    final newProject = res as Project;
    // print(newProject.projectName);
    addProject(newProject);
  }
}
